<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ArticleHate extends Model
{
    protected $table = "article_hates";

    protected $fillable = [
        'user_id',
        'article_id'
    ];
}
