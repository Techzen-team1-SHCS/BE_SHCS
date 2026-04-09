<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreBookingRequest extends FormRequest
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
            'user_id'  => 'required|exists:users,id',
            'room_id'  => 'required|exists:rooms,id',
            'check_in' => 'required|date|after_or_equal:today',
            'check_out'=> 'required|date|after:check_in',
            'quantity' => 'required|integer|min:1',
            'selected_room_numbers' => 'nullable|string'
        ];
    }

    public function messages(): array
    {
        return [
            'user_id.required' => 'User ID is required',
            'user_id.exists' => 'User not found',
            'room_id.required' => 'Room ID is required',
            'room_id.exists' => 'Room not found',
            'check_in.required' => 'Check-in date is required',
            'check_in.date' => 'Check-in date must be a date',
            'check_in.after_or_equal' => 'Check-in date must be after or equal to today',
            'check_out.required' => 'Check-out date is required',
            'check_out.date' => 'Check-out date must be a date',
            'check_out.after' => 'Check-out date must be after check-in date',
            'quantity.required' => 'Quantity is required',
            'quantity.integer' => 'Quantity must be an integer',
            'quantity.min' => 'Quantity must be at least 1',
            'selected_room_numbers.string' => 'Selected room numbers must be a string'
        ];
    }
}
