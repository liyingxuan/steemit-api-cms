<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Intelligence extends Model
{
    protected $table = "intelligences";

    protected $fillable = [
        'title',
        'focus_img_url',
        'summary',
        'content',
        'author',
        'status'
    ];
}
