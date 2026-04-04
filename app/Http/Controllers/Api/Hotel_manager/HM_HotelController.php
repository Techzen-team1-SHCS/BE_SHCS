<?php

namespace App\Http\Controllers\Api\Hotel_manager;

use App\Events\HotelPendingApproval;
use App\Http\Controllers\Controller;
use App\Http\Requests\StoreHotelRequest;
use App\Http\Requests\UpdateHotelRequest;
use App\Models\Hotel;
use App\Models\Hotel_Style;
use App\Models\Image;
use App\Models\Notification;
use App\Models\Scopes\ApprovedScope;
use App\Models\User;
use App\Notifications\HotelPendingApprovalNotification;
use Carbon\Carbon;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class HM_HotelController extends Controller
{
    use AuthorizesRequests;
    public function owner()
    {
        $this->authorize('viewAny', Hotel::class);
        $user = Auth::user();

        // 🚀 Caching kết quả trong 5 phút để tăng tốc
        $cacheKey = "hm_hotels_owner_{$user->id}";
        
        $hotels = \Illuminate\Support\Facades\Cache::remember($cacheKey, 300, function () use ($user) {
            $today = Carbon::today();
            
            return Hotel::withoutGlobalScope(ApprovedScope::class)
                ->where('user_id', $user->id)
                ->with([
                    'images',
                    'styles',
                    'rooms:id,hotel_id,availability_status' // Rút gọn select
                ])
                ->withSum([
                    'bookings as revenue' => function ($query) use ($today) {
                        // Tối ưu query sum bằng index created_at (đã check có index)
                        $query->whereDate('bookings.created_at', $today);
                    }
                ], 'total_price')
                ->withCount('roomNumbers as totalRooms')
                ->latest()
                ->get();
        });

        return response()->json([
            'status'  => true,
            'message' => 'Danh sách khách sạn của bạn',
            'data'    => $hotels
        ]);
    }

    public function show_owner($id)
    {
        $user = Auth::user();

        $hotel = Hotel::withoutGlobalScope(ApprovedScope::class)
            ->with(['images', 'styles'])
            ->where('id', $id)
            ->where('user_id', $user->id)
            ->first();

        if (!$hotel) {
            return response()->json([
                'status' => false,
                'message' => 'Không tìm thấy dữ liệu yêu cầu',
            ], 404);
        }

        $this->authorize('view', $hotel);

        return response()->json([
            'status'  => true,
            'message' => 'Chi tiết khách sạn',
            'data'    => $hotel
        ]);
    }

    public function create_owner(StoreHotelRequest $request)
    {
        $this->authorize('create', Hotel::class);

        $validated = $request->validated();
        DB::beginTransaction();

        try {
            $user = Auth()->user();

            $hotel = Hotel::create([
                'name'              => $validated['name'],
                'province'          => $validated['province'],
                'description'       => $validated['description'],
                'price'             => $validated['price'],
                'name_nearby_place' => $validated['name_nearby_place'],
                'hotel_class'       => $validated['hotel_class'],
                'amenities'         => $validated['amenities'] ?? null,
                'user_id'           => $user->id,
                'status'            => 'pending',
                'text'              => $validated['text']
            ]);

            if (!empty($validated['styles'])) {
                $hotel->styles()->sync($validated['styles']);
            }

            DB::commit();
            $uploadedImages = [];
            if ($request->hasFile('images')) {
                foreach ($request->file('images') as $file) {
                    $uploadedFile = Cloudinary::uploadFile($file->getRealPath(), [
                        'folder' => 'hotels/' . $hotel->id . 'webp',
                        'format'         => 'webp', // 💥 tự động chuyển sang webp
                        'transformation' => [
                            'quality' => 'auto',   // tự tối ưu chất lượng
                            'fetch_format' => 'webp'
                        ],
                    ]);

                    $imageUrl = $uploadedFile->getSecurePath();

                    Image::create([
                        'url'      => $imageUrl,
                        'reference_id' => $hotel->id,
                        'type' => 'hotel' // giữ đơn giản, dùng hotel_id
                    ]);

                    $uploadedImages[] = $imageUrl;
                }
            }
            /*
            =========================
            TẠO NOTIFICATION CHO ADMIN
            =========================
            */

            // ─── 🟢 Notify ADMIN: Hotel mới cần duyệt (Tối ưu bằng batch insert) ────────────────
            $admins = User::where('role', '1')->select('id')->get();
            $notificationData = [];
            $now = now();
            
            foreach ($admins as $admin) {
                $notificationData[] = [
                    'user_id' => $admin->id,
                    'type'    => 'hotel_pending',
                    'title'   => 'Hotel mới cần duyệt',
                    'message' => "Khách sạn '{$hotel->name}' đang chờ duyệt",
                    'is_read' => 0,
                    'data'    => json_encode(['hotel_id' => $hotel->id]),
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }
            
            if (!empty($notificationData)) {
                Notification::insert($notificationData);
            }

            // Xóa cache của chủ sở hữu
            $this->clearCache($user->id);

            /*
            =========================
            REALTIME
            =========================
            */

            event(new HotelPendingApproval($hotel));

            return response()->json([
                'status' => true,
                'message' => 'Hotel created and waiting approval',
                'data' => $hotel,
                'images' => $uploadedImages,
                'styles' => $validated['styles'] ?? [],
            ], 201);
        } catch (\Throwable $e) {
            DB::rollBack();

            return response()->json([
                'status' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }
    public function update_owner(UpdateHotelRequest $request, $id)
    {

        $hotel = Hotel::withoutGlobalScope(ApprovedScope::class)->findOrFail($id);
        $user = Auth()->user();

        $this->authorize('update', $hotel);

        $validated = $request->validated();

        DB::beginTransaction();

        try {
            // Update hotel
            $hotel->update([
                'name'              => $validated['name'],
                'province'          => $validated['province'],
                'description'       => $validated['description'],
                'price'             => $validated['price'],
                'name_nearby_place' => $validated['name_nearby_place'],
                'hotel_class'       => $validated['hotel_class'],
                'amenities'         => $validated['amenities'] ?? null,
                'text'              => $validated['text'] ?? null,
                'user_id'           => $user->id
            ]);
            // Update styles
            $hotel->styles()->sync($validated['styles'] ?? []);

            // Delete images
            if (!empty($validated['delete_images'])) {

                $images = Image::whereIn('id', $validated['delete_images'])
                    ->where('type', 'hotel')
                    ->where('reference_id', $hotel->id)
                    ->get();

                foreach ($images as $image) {
                    $image->delete();
                }
            }

            // Upload new images
            if ($request->hasFile('images')) {

                foreach ($request->file('images') as $file) {
                    $uploadedFile = Cloudinary::uploadFile($file->getRealPath(), [
                        'folder' => 'hotels/' . $hotel->id,
                    ]);

                    $imageUrl = $uploadedFile->getSecurePath();

                    Image::create([
                        'url'          => $imageUrl,
                        'type'         => 'hotel',
                        'reference_id' => $hotel->id,
                    ]);
                }
            }

            DB::commit();

            // Xóa cache của chủ sở hữu
            $this->clearCache($user->id);

            $hotel->load(['images', 'styles']);

            return response()->json([
                'status' => 'success',
                'hotel'  => $hotel
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();

            Log::error('Update hotel failed', [
                'error' => $e->getMessage(),
                'line' => $e->getLine(),
                'file' => $e->getFile()
            ]);

            return response()->json([
                'status'  => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
    public function destroy_owner($id)
    {
        $hotel = Hotel::withoutGlobalScope(ApprovedScope::class)->findOrFail($id);
        $this->authorize('delete', $hotel);
        DB::beginTransaction();
        try {
            // Xóa styles
            Hotel_Style::where('hotel_id', $hotel->id)->delete();
            // Xóa ảnh
            $images = Image::where('reference_id', $hotel->id)
                ->where('type', 'hotel')
                ->get();

            foreach ($images as $image) {
                if (!empty($image->public_id)) {
                    // Xóa file trên Cloudinary
                    Cloudinary::destroy($image->public_id);
                }
                $image->delete(); // Xóa record trong DB
            }
            // Xóa hotel
            $hotel->delete();
            DB::commit();

            // Xóa cache của chủ sở hữu
            $this->clearCache($hotel->user_id);
            return response()->json([
                'status'  => 'success',
                'message' => 'Hotel deleted successfully'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status'  => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Xóa cache của dashboard Hotel Manager
     */
    private function clearCache($userId)
    {
        \Illuminate\Support\Facades\Cache::forget("hm_hotels_owner_{$userId}");
    }
}
