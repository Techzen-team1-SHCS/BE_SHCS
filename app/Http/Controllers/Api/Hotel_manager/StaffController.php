<?php

namespace App\Http\Controllers\Api\Hotel_manager;

use App\Http\Controllers\Controller;
use App\Models\Staff;
use Illuminate\Http\Request;

class StaffController extends Controller
{
    public function index(){
        try {
            $staff=Staff::all();
            return response()->json([
                'status'=>200,
                'message'=>'Success',
                'data'=>$staff
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'message'=>'Internal server error',
                'error'=>$th->getMessage()
            ]);
        }
    }
    public function show($id){
        try {
            $staff=Staff::find($id);
            if($staff){
                return response()->json([
                    'status'=>200,
                    'message'=>'Success',
                    'data'=>$staff
                ]);
            }else{
                return response()->json([
                    'status'=>404,
                    'message'=>'Staff not found'
                ]);
            }
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'message'=>'Internal server error',
                'error'=>$th->getMessage()
            ]);
        }
    }
    public function store(Request $request){
        try {
            $validate=$request->validate([
                'name'=>'required',
                'email'=>'required|email',
                'phone'=>'required',
                'address'=>'required',
                'age'=>'required',
                'avatar'=>'required'
            ]);
            $staff=Staff::create($validate);
            return response()->json([
                'status'=>200,
                'message'=>'Success',
                'data'=>$staff
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'message'=>'Internal server error',
                'error'=>$th->getMessage()
            ]);
        }
    }
    public function update(Request $request, $id){
        try {
            $validate=$request->validate([
                'name'=>'nullable',
                'email'=>'nullable|email',
                'phone'=>'nullable',
                'address'=>'nullable',
                'age'=>'nullable',
                'avatar'=>'nullable'
            ]);
            $staff=Staff::find($id);
            if($staff){
                $staff->update($validate);
                return response()->json([
                    'status'=>200,
                    'message'=>'Success',
                    'data'=>$staff
                ]);
            }else{
                return response()->json([
                    'status'=>404,
                    'message'=>'Staff not found'
                ]);
            }
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'message'=>'Internal server error',
                'error'=>$th->getMessage()
            ]);
        }
    }
    public function destroy($id){
        try {
            $staff=Staff::find($id);
            if($staff){
                $staff->delete();
                return response()->json([
                    'status'=>200,
                    'message'=>'Success',
                ]);
            }else{
                return response()->json([
                    'status'=>404,
                    'message'=>'Staff not found'
                ]);
            }
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'message'=>'Internal server error',
                'error'=>$th->getMessage()
            ]);
        }
    }
        
}
