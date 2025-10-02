<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreHotelRequest;
use App\Models\Hotel;
use App\Models\Hotel_Style;
use App\Models\Image;
use App\Models\Style;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HotelController extends Controller
{
    public function index(){
        try {
            $hotels = Hotel::with(['styles', 'images'])->get();
            return response()->json([
                'status'=>200,
                'content'=>$hotels
            ],200);
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'error'=>'Không có khách sạn nào để hiển thị'
            ],500);
        }
    }
    public function show($id){
        try {
            $hotel = Hotel::with(['styles', 'images'])->findOrFail($id);
            if(!$hotel){
                return response()->json([
                    'status'=>404,
                    'error'=>'Không tìm thấy khách sạn nào'
                ]);
            }
            return response()->json([
                'status'=>200,
                'content'=>$hotel
            ],200);
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'error'=>$th->getMessage($th)
            ]);
        }
    }

    public function search(Request $request)
    {
        try {
            $query = Hotel::with(['styles', 'images']);

            // Keyword search
            if ($request->filled('keyword')) {
                $keyword = $request->keyword;
                $columns = ['name', 'province', 'description', 'name_nearby_place'];

                $query->where(function($q) use ($columns, $keyword) {
                    foreach ($columns as $col) {
                        $q->orWhere($col, 'like', "%{$keyword}%");
                    }
                    $q->orWhereHas('styles', function($sq) use ($keyword) {
                        $sq->where('style', 'like', "%{$keyword}%");
                    });
                });
            }

            // Province filter
            if ($request->filled('province')) {
                $query->where('province', $request->province);
            }
            // Exact price filter
            if ($request->filled('price')) {
                $query->where('price', $request->price);
            }

            // Price filter
            if ($request->filled('price_min')) {
                $query->where('price', '>=', $request->price_min);
            }
            if ($request->filled('price_max')) {
                $query->where('price', '<=', $request->price_max);
            }

            // Styles filter (array id)
            if ($request->filled('styles')) {
                $query->whereHas('styles', function($q) use ($request) {
                    $q->whereIn('styles.id', (array) $request->styles);
                });
            }

            // Sorting
            if ($request->filled('sort')) {
                switch ($request->sort) {
                    case 'price_asc':   $query->orderBy('price', 'asc'); break;
                    case 'price_desc':  $query->orderBy('price', 'desc'); break;
                    case 'newest':      $query->orderBy('created_at', 'desc'); break;
                    case 'rating_desc': $query->orderBy('hotel_class', 'desc'); break;
                }
            }

            // Pagination
            $perPage = $request->get('limit', 10);
            $hotels = $query->paginate($perPage);
            $hotels->getCollection()->transform(function ($hotel) {
            $hotel->price_formatted = number_format($hotel->price, 0, ',', '.');
            return $hotel;
            });
            return response()->json([
                'status'  => 200,
                'content' => $hotels
            ], 200);

        } catch (\Throwable $th) {
            return response()->json([
                'status' => 500,
                'error'  => 'Lỗi tìm kiếm: ' . $th->getMessage()
            ], 500);
        }
    }




    public function store(StoreHotelRequest $request)
    {
        $validated = $request->validated();

        DB::beginTransaction();
        try {
            // Tạo hotel
            $hotel = Hotel::create([
                'name'              => $validated['name'],
                'province'          => $validated['province'],
                'description'       => $validated['description'],
                'price'             => $validated['price'],
                'name_nearby_place' => $validated['name_nearby_place'],
                'hotel_class'       => $validated['hotel_class'],
            ]);

            // Liên kết styles (nếu có)
            if (!empty($validated['styles'])) {
                $hotel->styles()->sync($validated['styles']);
            }

            DB::commit();

            // Upload ảnh (sau khi commit hotel để chắc chắn có id)
            $uploadedImages = [];
            if ($request->hasFile('images')) {
                foreach ($request->file('images') as $file) {
                    $uploadedFile = Cloudinary::uploadFile($file->getRealPath(), [
                        'folder' => 'hotels/' . $hotel->id,
                    ]);

                    $imageUrl = $uploadedFile->getSecurePath();

                    Image::create([
                        'url'      => $imageUrl,
                        'reference_id' => $hotel->id,
                        'type'=>'hotel' // giữ đơn giản, dùng hotel_id
                    ]);

                    $uploadedImages[] = $imageUrl;
                }
            }

            return response()->json([
                'status' => 'success',
                'hotel'  => $hotel,
                'images' => $uploadedImages,
                'styles' => $validated['styles'] ?? [],
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status'  => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }


    public function update(StoreHotelRequest $request, $id)
    {
        $validated = $request->validated();

        DB::beginTransaction();
        try {
            $hotel = Hotel::findOrFail($id);

            // Update thông tin cơ bản
            $hotel->update([
                'name'              => $validated['name'],
                'province'          => $validated['province'],
                'description'       => $validated['description'],
                'price'             => $validated['price'],
                'name_nearby_place' => $validated['name_nearby_place'],
                'hotel_class'       => $validated['hotel_class'],
            ]);

            // Update styles (nếu không gửi thì xoá hết)
            $hotel->styles()->sync($validated['styles'] ?? []);

            // Xóa ảnh cũ nếu có yêu cầu
            if (!empty($validated['delete_images'])) {
                $images = Image::whereIn('id', $validated['delete_images'])
                    ->where('type', 'hotel')
                    ->where('reference_id', $hotel->id)
                    ->get();

                foreach ($images as $image) {
                    // Optional: Cloudinary::destroy($publicId);
                    $image->delete();
                }
            }

            // Thêm ảnh mới
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

            // Load lại quan hệ để lấy dữ liệu mới nhất
            $hotel->load(['images', 'styles']);

            return response()->json([
                'status' => 'success',
                'hotel'  => $hotel
            ], 200);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status'  => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }


    public function destroy($id)
    {
        DB::beginTransaction();
        try {
            $hotel = Hotel::findOrFail($id);

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

}
