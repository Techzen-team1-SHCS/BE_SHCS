<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreHotelRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true; // Cho phép tất cả request
    }

    public function rules(): array
    {
        return [
            'name'              => 'required|string|max:255',
            'province'          => 'required|string|max:255',
            'description'       => 'required|string',
            'price'             => 'required|numeric|min:0',
            'name_nearby_place' => 'required|string|max:255',
            'hotel_class'       => 'required|integer|min:0|max:5',
            'styles.*'          => 'nullable|integer|exists:styles,id',
            'images'            => 'array',   // ✅ nhiều ảnh
            'images.*'          => 'image|mimes:jpg,jpeg,png,webp,gif|max:2048'
        ];
    }

    public function messages(): array
    {
        return [
            'name.required' => 'Tên khách sạn là bắt buộc',
            'province.required' => 'Tỉnh/Thành phố là bắt buộc',
            'price.numeric' => 'Giá phải là số',
            'hotel_class.max' => 'Số sao tối đa là 5',
            'images.*.image' => 'Ảnh tải lên phải là file hình ảnh',
        ];
    }

    // ✅ Trả về lỗi JSON thay vì redirect
    protected function failedValidation(Validator $validator)
    {
        throw new HttpResponseException(response()->json([
            'status' => 'error',
            'errors' => $validator->errors()
        ], 422));
    }
}
