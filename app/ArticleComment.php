<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ArticleComment extends Model
{
    protected $table = "article_comments";

    protected $fillable = [
        'content',
        'article_id',
        'author_id'
    ];

    /**
     * Get comment list.
     *
     * @param $articleId
     * @return mixed
     */
    public static function getComments($articleId)
    {
        return ArticleComment::select(DB::raw(
            'article_comments.*, users.name AS author'))
            ->leftJoin('users', 'article_comments.author_id', '=', 'users.id')
            ->where('article_comments.article_id', $articleId)
            ->orderBy('article_comments.created_at', 'desc')
            ->paginate(10);
    }

    /**
     * Get my comments.
     *
     * @param $userId
     * @return mixed
     */
    public static function getMyComments($userId)
    {
        return ArticleComment::select(DB::raw(
            'article_comments.*, users.name AS author, articles.title'))
            ->leftJoin('users', 'article_comments.author_id', '=', 'users.id')
            ->leftJoin('articles', 'article_comments.article_id', '=', 'articles.id')
            ->where('article_comments.author_id', $userId)
            ->orderBy('article_comments.created_at', 'desc')
            ->paginate(10);
    }
}
