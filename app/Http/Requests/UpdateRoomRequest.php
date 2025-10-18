<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateRoomRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'hotel_id' => 'sometimes|exists:hotels,id',
            'room_type' => 'sometimes|string|max:100',
            'price' => 'sometimes|numeric|min:0',
            'max_guest' => 'sometimes|integer|min:1',
            'quantity' => 'sometimes|integer|min:1',
            'amenities' => 'nullable|string',
            'available_from' => 'nullable|date',
            'available_to' => 'nullable|date|after_or_equal:available_from',
            'availability_status' => 'nullable|in:available,unavailable',
        ];
    }

    public function messages(): array
    {
        return [
            'hotel_id.exists' => 'Khách sạn không tồn tại trong hệ thống.',
            'room_type.string' => 'Loại phòng phải là chuỗi ký tự.',
            'room_type.max' => 'Tên loại phòng không được vượt quá 100 ký tự.',
            'price.numeric' => 'Giá phòng phải là số.',
            'price.min' => 'Giá phòng phải lớn hơn hoặc bằng 0.',
            'max_guest.integer' => 'Số khách tối đa phải là số nguyên.',
            'max_guest.min' => 'Số khách tối thiểu là 1.',
            'quantity.integer' => 'Số lượng phòng phải là số nguyên.',
            'quantity.min' => 'Số lượng phòng phải lớn hơn 0.',
            'available_from.date' => 'Ngày bắt đầu khả dụng không hợp lệ.',
            'available_to.date' => 'Ngày kết thúc khả dụng không hợp lệ.',
            'available_to.after_or_equal' => 'Ngày kết thúc phải sau hoặc bằng ngày bắt đầu.',
            'availability_status.in' => 'Trạng thái phải là available hoặc unavailable.',
        ];
    }
}
