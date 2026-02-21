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
    public function index()
    {
        $hotels = Hotel::with([
                'firstimage:id,reference_id,url'
            ])->get();
        return response()->json([
            'status' => 'success',
            'content' => $hotels
        ]);
    }


    public function sameProvince($id, Request $request)
    {
        try {
            $limit = (int) $request->get('limit', 2);

            // Lấy province nhưng chỉ lấy field cần
            $hotel = Hotel::select('id', 'province')
                ->findOrFail($id);

            $sameProvinceHotels = Hotel::query()
                ->select([
                    'id',
                    'name',
                    'province',
                    'hotel_class'
                ])
                ->where('province', $hotel->province)
                ->where('id', '!=', $id)
                ->with([
                    'images'
                ])
                ->limit($limit)
                ->get();

            return response()->json([
                'success' => true,
                'data' => $sameProvinceHotels
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => 'Lỗi server'
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
            $sameStyleHotels = Hotel::with(['images']) // Bỏ constraint
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

    public function topHotels()
    {
        // Key cache
        $cacheKey = 'top_hotels';

        // Lấy từ cache nếu có, nếu không thì query và lưu cache 60 giây
        $hotels = Cache::remember($cacheKey, 60, function () {
            return Hotel::with(['styles', 'images'])
                ->orderBy('hotel_class', 'desc')
                ->take(5)
                ->get()
                ->map(function ($hotel) {
                    $hotel->price_formatted = number_format($hotel->price, 0, ',', '.');
                    return $hotel;
                });
        });

        if ($hotels->isEmpty()) {
            return response()->json([
                'status' => 400,
                'message' => 'Lỗi không tìm thấy khách sạn'
            ]);
        }

        return response()->json([
            'status' => 200,
            'message' => 'Lấy danh sách top 5 khách sạn thành công',
            'data' => $hotels
        ], 200);
    }
    public function destinationsCount()
    {
        return Cache::remember('destinations_count', 300, function () {
            return [
                ['province' => 'Hà nội', 'count' => Hotel::where('province', 'Hà nội')->count()],
                ['province' => 'Đà nẵng', 'count' => Hotel::where('province', 'Đà nẵng')->count()],
                ['province' => 'Hồ chí minh', 'count' => Hotel::where('province', 'Hồ Chí Minh')->count()],
                ['province' => 'Nha trang', 'count' => Hotel::where('province', 'Nha Trang')->count()],
                ['province' => 'Huế', 'count' => Hotel::where('province', 'Huế')->count()],
                ['province' => 'Hải phòng', 'count' => Hotel::where('province', 'Hải Phòng')->count()],
                ['province' => 'Phú Quốc', 'count' => Hotel::where('province', 'Phú Quốc')->count()],
                ['province' => 'Đà Lạt', 'count' => Hotel::where('province', 'Đà Lạt')->count()],
            ];
        });
    }


    public function search(Request $request)
    {
        try {

            /* ===== CACHE KEY ===== */
            $cacheKey = 'hotel_search:' . md5(json_encode([
                'searchTerm'  => $request->searchTerm,
                'destination' => $request->destination,
                'roomType'    => $request->roomType,
                'checkIn'     => $request->checkIn,
                'checkOut'    => $request->checkOut,
                'filters'     => $request->selectedFilters,
                'page'        => $request->get('page', 1),
                'per_page'    => $request->get('per_page', 10),
            ]));

            $response = Cache::remember(
                $cacheKey,
                now()->addMinutes(10),
                function () use ($request, $cacheKey) {

                    // 👉 DÒNG NÀY CHỈ XUẤT HIỆN KHI CACHE MISS
                    Log::error('⚠️ QUERY DB RUNNING', ['key' => $cacheKey]);

                    $query = Hotel::query()
                        ->select([
                            'hotels.id',
                            'hotels.name',
                            'hotels.province',
                            'hotels.description',
                            'hotels.price',
                            'hotels.hotel_class',
                        ])
                        ->with([
                            'firstimage:id,reference_id,url',
                            'firstroom:id,hotel_id,available_from,available_to,quantity',
                        ]);

                    /* ===== SEARCH ===== */
                    if ($request->filled('searchTerm')) {
                        $query->where('hotels.name', 'like', "%{$request->searchTerm}%");
                    }

                    if ($request->filled('destination')) {
                        $query->where('hotels.province', 'like', "%{$request->destination}%");
                    }

                    if ($request->filled('roomType')) {
                        $query->whereHas('styles', function ($q) use ($request) {
                            $q->where('style', 'like', "%{$request->roomType}%");
                        });
                    }
                    if ($request->filled('checkIn') && $request->filled('checkOut')) {
                        $query->whereHas('firstroom', function ($q) use ($request) {
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

                    if ($request->filled('selectedFilters')) {
                        $filters = is_array($request->selectedFilters)
                            ? $request->selectedFilters
                            : explode(',', $request->selectedFilters);

                        foreach ($filters as $filter) {

                            if (preg_match('/(\d+) sao/', $filter, $m)) {
                                $query->where('hotel_class', '>=', (int)$m[1] * 10);
                                continue;
                            }

                            $ratingMap = [
                                'Tuyệt hảo' => 50,
                                'Rất tốt'   => 40,
                                'Tốt'       => 30,
                                'Dễ chịu'   => 20,
                            ];

                            foreach ($ratingMap as $text => $value) {
                                if (str_contains($filter, $text)) {
                                    $query->where('hotel_class', '>=', $value);
                                    continue 2;
                                }
                            }

                            $query->where(function ($q) use ($filter) {
                                $q->orWhereJsonContains('amenities', $filter)
                                ->orWhere('hotels.name', 'like', "%{$filter}%")
                                ->orWhere('hotels.province', 'like', "%{$filter}%");
                            });
                        }
                    }

                    $hotels = $query->paginate($request->get('per_page', 10));

                    $hotels->getCollection()->transform(function ($hotel) {
                        $hotel->price_formatted = number_format($hotel->price, 0, ',', '.');
                        return $hotel;
                    });

                    return [
                        'status' => 200,
                        'data'   => $hotels,
                        'total_results' => $hotels->total(),
                    ];
                }
            );

            return response()->json($response);

        } catch (\Throwable $e) {
            return response()->json([
                'status' => 500,
                'error' => $e->getMessage()
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
