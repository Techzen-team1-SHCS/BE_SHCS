<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class RoomRequest extends FormRequest
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
            'hotel_id'=>'required|exists:hotels,id',
            'room_type'=>'required|string|max:255',
            'price'=>'required|numeric|min:0',
            'max_guest'=>'required|integer|min:1',
            'quantity'=>'required|integer|min:1',
            'amenities' => 'nullable|array',
            'amenities.*' => 'string|max:50',
            'available_from'=>'required|date',
            'available_to'=>'required|date|after_or_equal:available_from',
            'availability_status'=>'nullable|in:available,unavailable',
        ];
    }
    public function messages()
    {
        return[
            'hotel_id.required'=>'Vui lòng chọc khách sạn.',
            'hotel_id.exists'=>'Khách sạn không tồn tại.',
            'room_type.required'=>'Vui lòng nhập loại phòng.',
            'price.required'=>'Vui lòng nhập giá phòng.',
            'max_guest.required'=>'Vui lòng nhập số khách tối đa.',
            'quantity.required'=>'Vui lòng nhập số lượng phòng.',
            'available_from.required'=>'Vui lòng nhập ngày bắt đầu khả dụng.',
            'available_to.after_or_equal'=>'Ngày kết thúc phải sau hoặc bằng ngày bắt đầu.'
        ];
    }
}
