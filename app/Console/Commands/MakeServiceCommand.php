<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;

class MakeServiceCommand extends Command
{
    protected $signature = 'make:service {name}';
    protected $description = 'Create a new Service class';

    public function handle()
    {
        $name = $this->argument('name');
        $path = app_path("Services/{$name}.php");

        if (File::exists($path)) {
            $this->error("Service {$name} already exists!");
            return;
        }

        $stub = "<?php

namespace App\Services;

class {$name}
{
    //
}
";

        File::ensureDirectoryExists(app_path('Services'));
        File::put($path, $stub);

        $this->info("Service {$name} created successfully.");
    }
}

