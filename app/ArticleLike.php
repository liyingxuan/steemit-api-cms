<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ArticleLike extends Model
{
    protected $table = "article_likes";

    protected $fillable = [
        'user_id',
        'article_id'
    ];
}
