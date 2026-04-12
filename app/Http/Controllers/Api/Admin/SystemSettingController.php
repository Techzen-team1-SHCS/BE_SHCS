<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\SystemSetting;

class SystemSettingController extends Controller
{
    public function toggle()
    {
        $setting = SystemSetting::firstOrCreate(
            ['setting_key' => 'is_maintenance'],
            ['setting_value' => '0']
        );

        // Toggle value
        $newValue = $setting->setting_value == '1' ? '0' : '1';
        $setting->update(['setting_value' => $newValue]);

        return response()->json([
            'message' => $newValue == '1' ? 'Đã bật chế độ bảo trì.' : 'Đã tắt chế độ bảo trì.',
            'is_maintenance' => $newValue == '1'
        ]);
    }

    public function getStatus()
    {
        $setting = SystemSetting::where('setting_key', 'is_maintenance')->first();
        return response()->json([
            'is_maintenance' => $setting ? $setting->setting_value == '1' : false
        ]);
    }
}
