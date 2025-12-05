<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreHotelRequest;
use App\Models\Hotel;
use App\Models\Hotel_Style;
use App\Models\Image;
use App\Models\Room;
use App\Models\Style;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Password;
use Maatwebsite\Excel\Facades\Excel;
use PhpOffice\PhpSpreadsheet\IOFactory;

class HotelController extends Controller
{
    public function index(){
        try {
            $hotels = Hotel::with(['styles', 'images','rooms'])->get();
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
    public function sameProvince($id,Request $request)
    {
        try {
            $hotel=Hotel::with(['styles','images','rooms'])->findOrFail($id);
            $limit=$request->get('limit',2);
             $sameProvinceHotels = Hotel::with(['styles', 'images', 'rooms']) // Thêm relationships
            ->where('province', $hotel->province)
            ->where('id', '!=', $id)
            ->limit($limit)
            ->get();
            return response()->json([
                'success'=>true,
                'data'=>$sameProvinceHotels
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => 'Lỗi server: ' . $th->getMessage()
            ], 500);
        }
    }
    public function sameStyle($id,Request $request)
    {
        try {
            $limit=$request->get('limit',3);
            $currentHotel=Hotel::findOrFail($id);
            $currentStyleIds = $currentHotel->styles->pluck('id')->toArray();
            if (empty($currentStyleIds)) {
                return response()->json([
                    'success' => true,
                    'data' => [],
                    'message' => 'Khách sạn không có room styles'
                ]);
            }
            $sameStyleHotels = Hotel::with(['styles', 'images','rooms']) // Bỏ constraint
            ->whereHas('styles', function($query) use ($currentStyleIds) {
                $query->whereIn('styles.id', $currentStyleIds);
            })
            ->where('id', '!=', $id)
            ->limit($limit)
            ->get();
            return response()->json([
            'success' => true,
            'data' => $sameStyleHotels,
        ]);
        } catch (\Throwable $th) {
            return response()->json([
            'success' => false,
            'message' => 'Lỗi server: ' . $th->getMessage()
        ], 500);
        }
    }
    public function show($id){
        try {
            $hotel = Hotel::with(['styles', 'images','rooms'])->findOrFail($id);
            if(!$hotel){
                return response()->json([
                    'status'=>404,
                    'error'=>'Không tìm thấy khách sạn nào'
                ]);
            }
            $totalRooms = Room::where('hotel_id', $id)->sum('quantity');
            return response()->json([
                'status'=>200,
                'data'=>$hotel,
                'totalRooms'=>$totalRooms
            ],200);
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'error'=>$th->getMessage($th)
            ]);
        }
    }

    public function topHotels() {
    // Lấy cache hoặc truy vấn mới 10 khách sạn
        $hotels = Hotel::with(['styles', 'images'])
        ->orderBy('hotel_class', 'desc') // sắp xếp từ cao xuống thấp
        ->take(5)
        ->get();
        // Format giá trực tiếp trên Collection
        $hotels->transform(function ($hotel) {
            $hotel->price_formatted = number_format($hotel->price, 0, ',', '.');
            return $hotel;
        });

        // Kiểm tra rỗng
        if ($hotels->isEmpty()) {
            return response()->json([
                'status' => 400,
                'message' => 'Lỗi không tìm thấy khách sạn'
            ]);
        }

        // Trả về JSON
        return response()->json([
            'status' => 200,
            'message' => 'Lấy danh sách top 10 khách sạn thành công',
            'data' => $hotels
        ], 200);
}

    public function search(Request $request)
    {
        try {
            $query = Hotel::with(['rooms', 'styles', 'images']);

        // 1️⃣ Keyword filter (tìm tự do)
        if ($request->filled('searchTerm')) {
            $keyword = $request->searchTerm;
            $query->where(function ($q) use ($keyword) {
                $q->where('name', 'like', "%$keyword%")
                  ->orWhere('description', 'like', "%$keyword%")
                  ->orWhere('name_nearby_place', 'like', "%$keyword%");
            });
        }

        // 2️⃣ Destination / Province filter (từ FE gọi là destination)
        if ($request->filled('destination')) {
            $query->where('province', 'like', "%{$request->destination}%");
        }

        // 3️⃣ Room Type filter
        if ($request->filled('roomType')) {
            $query->whereHas('styles', function ($q) use ($request) {
                $q->where('style', 'like', "%{$request->roomType}%");
            });
        }

        // 4️⃣ Guest & Date filter
        if ($request->filled('checkIn') && $request->filled('checkOut')) {
            $query->whereHas('rooms', function ($q) use ($request) {
                if ($request->filled('checkIn') && $request->filled('checkOut')) {
                    $q->where(function ($r) use ($request) {
                        $r->whereNull('available_from')
                          ->orWhere('available_from', '<=', $request->checkIn);
                    })->where(function ($r) use ($request) {
                        $r->whereNull('available_to')
                          ->orWhere('available_to', '>=', $request->checkOut);
                    });
                }
            });
        }

        // 5️⃣ Price filter
       if ($request->filled('selectedFilters')) {
            $selectedFilters = is_array($request->selectedFilters)
                ? $request->selectedFilters
                : explode(',', $request->selectedFilters);

            $query->where(function ($q) use ($selectedFilters) {
                foreach ($selectedFilters as $filter) {
                    if (preg_match('/(\d+) sao/', $filter, $matches)) {
                        $q->where('hotel_class', '>=', (int)$matches[1] * 10);
                    } elseif (preg_match('/Tuyệt hảo|Rất tốt|Tốt|Dễ chịu/', $filter)) {
                        $ratingMap = [
                            'Tuyệt hảo' => 50,
                            'Rất tốt'   => 40,
                            'Tốt'       => 30,
                            'Dễ chịu'   => 20,
                        ];
                        foreach ($ratingMap as $key => $value) {
                            if (str_contains($filter, $key)) {
                                $q->where('hotel_class', '>=', $value);
                            }
                        }
                    } else {
                        // Đây là filter amenities hoặc text
                        $q->where(function ($inner) use ($filter) {
                            $inner->orWhereJsonContains('amenities', $filter)
                                ->orWhere('amenities', 'like', "%$filter%")
                                ->orWhere('name', 'like', "%$filter%")
                                ->orWhere('province', 'like', "%$filter%");
                        });
                    }
                }
            });
        }

        // 6️⃣ Sort filter
        $sort = $request->get('sort', 'price_asc');


        // 7️⃣ Pagination + Format
        $perPage = $request->get('per_page', 10);
        $hotels = $query->paginate($perPage);

        $hotels->getCollection()->transform(function ($hotel) {
            $hotel->price_formatted = number_format($hotel->price, 0, ',', '.');
            return $hotel;
        });

            return response()->json([
                'status' => 200,
                'data' => $hotels,
                'total_results' => $hotels->total(),
            ]);

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
                        'folder' => 'hotels/' . $hotel->id .'webp',
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

      public function uploadImages(Request $request, $hotelId)
    {
        $hotel = Hotel::find($hotelId);
        if (!$hotel) {
            return response()->json([
                'status' => 'error',
                'message' => 'Hotel not found'
            ], 404);
        }

        if (!$request->hasFile('images')) {
            return response()->json([
                'status' => 'error',
                'message' => 'No images uploaded'
            ], 400);
        }

        $uploadedImages = [];

        DB::beginTransaction();
        try {
            foreach ($request->file('images') as $file) {
                $uploadedFile = Cloudinary::uploadFile($file->getRealPath(), [
                    'folder' => 'hotels/' . $hotel->id,
                    'format' => 'webp',
                    'transformation' => [
                        'quality' => 'auto',
                        'fetch_format' => 'webp'
                    ],
                ]);

                $imageUrl = $uploadedFile->getSecurePath();

                Image::create([
                    'url' => $imageUrl,
                    'reference_id' => $hotel->id,
                    'type' => 'hotel'
                ]);

                $uploadedImages[] = $imageUrl;
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'hotel_id' => $hotel->id,
                'images' => $uploadedImages
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }



}
