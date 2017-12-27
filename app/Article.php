<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Article extends Model
{
    protected $table = "articles";

    protected $fillable = [
        'title',
        'content',
        'content_html',
        'first_img_url',
        'tag',
        'author_id'
    ];

    /**
     * 获取用户的blog列表。
     * 包括点赞和评论计数，还有作者姓名。
     *
     * @param $userId
     * @return mixed
     */
    public static function getMyBlog($userId)
    {
        return Article::select(DB::raw(
            'articles.*, users.name AS author, count(article_likes.id) AS starCount, ' .
            'count(article_comments.id) AS commentCount'))
            ->leftJoin('users', 'articles.author_id', '=', 'users.id')
            ->leftJoin('article_likes', 'articles.id', '=', 'article_likes.article_id')
            ->leftJoin('article_comments', 'articles.id', '=', 'article_comments.article_id')
            ->where('articles.author_id', $userId)
            ->groupBy('articles.id')
            ->orderBy('articles.id', 'desc')
            ->paginate(10);
    }
}
