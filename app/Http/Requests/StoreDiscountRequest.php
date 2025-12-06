<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreDiscountRequest extends FormRequest
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
    public function rules()
    {
        return [
            'title' => 'required|string|max:255',
            'code' => 'required|string|max:50|unique:discounts,code',
            'value' => 'required|string', // "20%"
            'minOrder' => 'required|integer|min:0',
            'maxDiscount' => 'required|integer|min:0',
            'image' => 'nullable|string',
            'isActive' => 'boolean',
            'expiryDate' => 'required|date|after:today',
        ];
    }
}
