<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreDiscountRequest;
use App\Models\Discount;
use Error;
use Illuminate\Http\Request;

class DiscountController extends Controller
{
    public function index(){
        try {
            $discount=Discount::all();
            if(!$discount){
                return response()->json([
                    'status'=>404,
                    'error'=>'Not found'
                ]);
            }
            return response()->json([
                'status'=>200,
                'data'=>$discount
            ]);
        } catch (\Throwable $th) {
            throw new Error('errot'.$th->getMessage());
        }
    }
    public function store(StoreDiscountRequest $request){
        try {
            $validated=$request->validated();
            $discount=Discount::create($validated);
            return response()->json([
                'status'=>200,
                'data'=>$discount
            ]);
        } catch (\Throwable $th) {
            throw $th;
        }
    }
}
