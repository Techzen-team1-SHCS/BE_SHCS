<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateHotelRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name'              => 'nullable|string|max:255',
            'province'          => 'nullable|string|max:255',
            'description'       => 'nullable|string',
            'text'              => 'nullable|string',
            'price'             => 'nullable|numeric|min:0',
            'name_nearby_place' => 'nullable|string|max:255',
            'amenities'        => 'nullable|array',
            'hotel_class'       => 'nullable|between:1,5',
            'styles.*'          => 'nullable|integer|exists:styles,id',
            'images'            => 'array',   // ✅ nhiều ảnh
            'images.*'          => 'image|mimes:jpg,jpeg,png,webp,gif|max:2048'
        ];
    }
    public function messages(): array
    {
        return [
            'name.nullable' => 'Tên khách sạn là bắt buộc',
            'province.nullable' => 'Tỉnh/Thành phố là bắt buộc',
            'price.numeric' => 'Giá phải là số',
            'hotel_class.max' => 'Số sao tối đa là 5',
            'images.*.image' => 'Ảnh tải lên phải là file hình ảnh',
        ];
    }
}