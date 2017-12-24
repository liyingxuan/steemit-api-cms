<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class HelpDoc extends Model
{
    protected $table = "help_docs";

    protected $fillable = [
        'title',
        'focus_img_url',
        'summary',
        'content',
        'author',
        'status'
    ];
}
