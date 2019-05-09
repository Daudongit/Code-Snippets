<?php

namespace App\Providers;

use App\Channel;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    //Put this in laravel AppServiceProvider or create another service provider
    public function boot(){
        
        if (!app()->environment('testing') && config('app.log_sql')) {
            DB::listen(function ($query) {
                if (preg_match('/^select/', $query->sql)) {
                    Log::info('sql: ' .  $query->sql);
                    // Also available are $query->bindings and $query->time.
                }
            });
        }
    }
}