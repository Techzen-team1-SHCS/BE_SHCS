<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\WishList;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

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
}
