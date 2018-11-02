<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Spatie\Permission\Traits\HasRoles;
use Spatie\Permission\Models\Role;

class User extends Authenticatable
{
    use Notifiable, HasRoles;

    protected $fillable = [
        'name', 'email', 'admin' ,'password',
    ];

    protected $hidden = [
        'password', 'remember_token',
    ];

    public function tasks() {
        return $this->hasMany('App\Task') ;
    }

}
