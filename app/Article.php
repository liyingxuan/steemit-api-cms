<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    protected $table = "articles";

    protected $fillable = [
        'title',
        'content',
        'content_html',
        'tag',
        'author_id'
    ];
}
