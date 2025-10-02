<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Style;

class StyleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $styles = [
            'Cổ điển',
           'Hiện đại',
           'Yên tĩnh',
           'Sôi động',
           'Thơ mộng',
           'Tình yêu'
        ];

        foreach ($styles as $style) {
            Style::create([
                'style' => $style
            ]);
        }
    }
}
