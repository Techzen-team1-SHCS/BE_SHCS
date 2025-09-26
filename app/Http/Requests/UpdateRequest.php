<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true; // ✅ Cho phép request chạy
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name'     => 'sometimes|required|string|max:255',
            'email'    => 'sometimes|required|email|unique:users,email,' . $this->route('id'),
            'phone'    => 'nullable|string|max:15',
            'password' => 'nullable|string|min:6|confirmed', // nếu có nhập thì check min + confirmed
            'avatar'   => 'nullable|image|mimes:jpg,jpeg,png|max:2048', // max 2MB
        ];
    }

    public function messages(): array
    {
        return [
            'name.required'     => 'Tên không được để trống',
            'email.required'    => 'Email không được để trống',
            'email.email'       => 'Email không đúng định dạng',
            'email.unique'      => 'Email đã tồn tại',
            'password.min'      => 'Mật khẩu phải có ít nhất 6 ký tự',
            'password.confirmed'=> 'Xác nhận mật khẩu không khớp',
            'avatar.image'      => 'Avatar phải là ảnh',
            'avatar.mimes'      => 'Avatar chỉ chấp nhận jpg, jpeg, png',
            'avatar.max'        => 'Avatar không được quá 2MB',
        ];
    }
}
