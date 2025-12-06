<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DiscountSeeder extends Seeder
{
    public function run()
    {
        DB::table('discounts')->insert([
            [
                "title" => "Ưu đãi cuối tuần",
                "code" => "WEEKEND15",
                "value" => "15%",
                "minOrder" => 1500000,
                "maxDiscount" => 500000,
                "image" => "/assets/images/discount/discount-2.jpg",
                "isActive" => true,
                "expiryDate" => "2025-12-31",
                "created_at" => now(),
                "updated_at" => now(),
            ],
            [
                "title" => "Mã siêu sale 11/11",
                "code" => "SALE1111",
                "value" => "30%",
                "minOrder" => 3000000,
                "maxDiscount" => 1500000,
                "image" => "/assets/images/discount/discount-3.jpg",
                "isActive" => true,
                "expiryDate" => "2025-11-11",
                "created_at" => now(),
                "updated_at" => now(),
            ],
            [
                "title" => "Giảm giá Tết Nguyên Đán",
                "code" => "TET2025",
                "value" => "25%",
                "minOrder" => 2500000,
                "maxDiscount" => 1200000,
                "image" => "/assets/images/discount/discount-4.jpg",
                "isActive" => true,
                "expiryDate" => "2026-02-01",
                "created_at" => now(),
                "updated_at" => now(),
            ],
            [
                "title" => "Ưu đãi khách hàng mới",
                "code" => "NEWUSER10",
                "value" => "10%",
                "minOrder" => 500000,
                "maxDiscount" => 200000,
                "image" => "/assets/images/discount/discount-5.jpg",
                "isActive" => true,
                "expiryDate" => "2027-01-01",
                "created_at" => now(),
                "updated_at" => now(),
            ],
            [
                "title" => "Flash Sale Giữa Tuần",
                "code" => "MIDWEEK12",
                "value" => "12%",
                "minOrder" => 1000000,
                "maxDiscount" => 300000,
                "image" => "/assets/images/discount/discount-6.jpg",
                "isActive" => true,
                "expiryDate" => "2026-06-30",
                "created_at" => now(),
                "updated_at" => now(),
            ],
            [
                "title" => "Ưu đãi mùa đông",
                "code" => "WINTER20",
                "value" => "20%",
                "minOrder" => 2000000,
                "maxDiscount" => 800000,
                "image" => "/assets/images/discount/discount-7.jpg",
                "isActive" => true,
                "expiryDate" => "2026-12-31",
                "created_at" => now(),
                "updated_at" => now(),
            ],
            [
                "title" => "Giảm giá lễ 30/4",
                "code" => "HOLIDAY304",
                "value" => "18%",
                "minOrder" => 1800000,
                "maxDiscount" => 700000,
                "image" => "/assets/images/discount/discount-8.jpg",
                "isActive" => true,
                "expiryDate" => "2026-04-30",
                "created_at" => now(),
                "updated_at" => now(),
            ],
            [
                "title" => "Ưu đãi Black Friday",
                "code" => "BLACKFRIDAY50",
                "value" => "50%",
                "minOrder" => 4000000,
                "maxDiscount" => 2000000,
                "image" => "/assets/images/discount/discount-9.jpg",
                "isActive" => true,
                "expiryDate" => "2025-11-29",
                "created_at" => now(),
                "updated_at" => now(),
            ],
        ]);
    }
}
