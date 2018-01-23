<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SubscribeEmail extends Model
{
    protected $table = "subscribe_emails";

    protected $fillable = [
        'email',
        'content'
    ];
}
