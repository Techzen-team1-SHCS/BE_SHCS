<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreHotelRequest;
use App\Http\Requests\UpdateHotelRequest;
use App\Models\Hotel;
use App\Models\Hotel_Style;
use App\Models\Image;
use App\Models\Room;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use App\Services\HotelService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;


class HotelController extends Controller
{
    public function __construct(private readonly HotelService $hotelService)
    {
    }

    public function index()
    {
        // Lấy page và per_page từ request
        $page = (int) request('page', 1);
        $perPage = (int) request('per_page', 20);
        
        $hotels = Hotel::with([
                'firstimage:id,reference_id,url'
            ])->paginate($perPage, ['*'], 'page', $page);
            
        return response()->json([
            'status' => 'success',
            'data' => $hotels->items(),
            'pagination' => [
                'current_page' => $hotels->currentPage(),
                'last_page' => $hotels->lastPage(),
                'per_page' => $hotels->perPage(),
                'total' => $hotels->total(),
            ],
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

        // Lấy từ cache nếu có, nếu không thì query và lưu cache 86400 giây (1 ngày)
        $hotels = Cache::remember($cacheKey, 86400, function () {
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
            return Hotel::query()
                ->selectRaw('province, COUNT(*) as count')
                ->groupBy('province')
                ->orderByDesc('count')
                ->limit(8)
                ->get();
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
                    $perPage = max(1, min((int) $request->get('per_page', 10), 20));

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

                    $hotels = $query->paginate($perPage);

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

            $this->hotelService->invalidateHotelCaches();
            if ($request->hasFile('images')) {
                $this->hotelService->queueImageUploads($hotel->id, $request->file('images'));
            }

            return response()->json([
                'status' => 'success',
                'hotel'  => $hotel,
                'images' => [],
                'styles' => $validated['styles'] ?? [],
                'message' => $request->hasFile('images')
                    ? 'Hotel created. Images are processing in background.'
                    : 'Hotel created successfully.',
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status'  => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }


    public function update(UpdateHotelRequest $request, $id)
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
                'amenities'        => $validated['amenities'] ?? $hotel->amenities,
                'text'              => $validated['text'] ?? $hotel->text,
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
                $this->hotelService->queueImageUploads($hotel->id, $request->file('images'));
            }

            DB::commit();

            // Load lại quan hệ để lấy dữ liệu mới nhất
            $hotel->load(['images', 'styles']);
            $this->hotelService->invalidateHotelCaches();

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
            $this->hotelService->invalidateHotelCaches();

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
        // Tắt global scope approved để hotel đang pending vẫn tìm được
        $hotel = Hotel::withoutGlobalScope(\App\Models\Scopes\ApprovedScope::class)->find($hotelId);

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

        DB::beginTransaction();
        try {
            DB::commit();
            $this->hotelService->queueImageUploads($hotel->id, $request->file('images'));
            $this->hotelService->invalidateHotelCaches();

            return response()->json([
                'status' => 'success',
                'hotel_id' => $hotel->id,
                'message' => 'Images are processing in background'
            ], 202);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
    



}