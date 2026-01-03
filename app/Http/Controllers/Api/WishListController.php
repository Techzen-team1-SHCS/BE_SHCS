<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\UserBehavior;
use App\Models\WishList;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class WishListController extends Controller
{
    public function index()
    {
        $wishlists = WishList::all();
        return response()->json([
            'success'=>200,
            'data'=>$wishlists
        ]);
    }
    public function show(){
        $userId=Auth::id();
        $wishlists=WishList::where('user_id',$userId)->with('hotel','hotel.images')->get();
        if(!$userId){
            return response()->json([
                'success'=>401,
                'message'=>'Unauthorized'
            ]);
        }
        return response()->json([
            'success'=>200,
            'data'=>$wishlists
        ]);
    }
    public function store(Request $request){
        try {
            $userId=Auth::id();
            if(!$userId){
                return response()->json([
                    'success'=>401,
                    'message'=>'Unauthorized'
                ]);
            }
            $request->validate([
                'hotel_id'=>'required|exists:hotels,id'
            ]);
            $wishlist=WishList::create([
                'user_id'=>$userId,
                'hotel_id'=>$request->hotel_id
            ]);
            return response()->json([
                'success'=>201,
                'data'=>$wishlist
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }
    public function destroy($id){
        $wishlist=WishList::find($id);
        if(!$wishlist){
            return response()->json([
                'success'=>404,
                'message'=>'Not Found'
            ]);
        }
        $wishlist->delete();
        return response()->json([
            'success'=>200,
            'message'=>'Deleted Successfully'
        ]);
    }
    public function removeLike(Request $request)
{
    $validated = $request->validate([
        'user_id' => 'required|exists:users,id',
        'hotel_id' => 'required|exists:hotels,id',
    ]);

    DB::beginTransaction();

    try {
        // 1️⃣ Xóa log hành vi like
        UserBehavior::where('user_id', $validated['user_id'])
            ->where('hotel_id', $validated['hotel_id'])
            ->where('action', 'like')
            ->delete();

        // 2️⃣ Xóa khỏi wishlist
        $wishlistDeleted = WishList::where('user_id', $validated['user_id'])
            ->where('hotel_id', $validated['hotel_id'])
            ->delete();

        DB::commit();

        if ($wishlistDeleted === 0) {
            return response()->json([
                'status' => 'warning',
                'message' => 'Không có khách sạn trong wishlist'
            ], 200);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Đã xóa khỏi danh sách yêu thích và log like'
        ]);

    } catch (\Throwable $e) {
        DB::rollBack();

        return response()->json([
            'status' => 'error',
            'message' => 'Xóa thất bại',
            'error' => $e->getMessage()
        ], 500);
    }
}
     public function check(Request $request)
    {
        $request->validate([
            'hotel_id' => 'required|integer|exists:hotels,id'
        ]);

        $userId = $request->user()->id;
        $hotelId = $request->hotel_id;
        $liked = Wishlist::where('user_id', $userId)
            ->where('hotel_id', $hotelId)
            ->exists();

        return response()->json([
            'liked' => $liked
        ]);
    }

}
