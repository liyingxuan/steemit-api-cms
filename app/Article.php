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
        'main_tag',
        'tag',
        'author_id'
    ];

    /**
     * 查询blog列表的基础查询语句
     *
     * @return string
     */
    public static function sqlBase()
    {
        return "
            SELECT articles.*, users.name AS author, IFNULL(t_likes.starCount,0) AS starCount, IFNULL(t_comment.commentCount,0) AS commentCount
            FROM articles 
            LEFT JOIN users ON articles.author_id = users.id 
            LEFT JOIN (
                SELECT article_id, count(article_id) AS starCount
                FROM article_likes GROUP BY article_id
            ) t_likes
            ON articles.id = t_likes.article_id
            LEFT JOIN (
                SELECT article_id, count(article_id) AS commentCount
                FROM article_comments GROUP BY article_id
            ) t_comment
            ON articles.id = t_comment.article_id ";
    }

    /**
     * 获取单个的blog列表。
     * 包括点赞和评论计数，还有作者姓名。
     *
     * @param $articleId
     * @return mixed
     */
    public static function getBlog($articleId)
    {
        $sql = self::sqlBase() . "WHERE articles.id = '$articleId';";

        return DB::select(str_replace(PHP_EOL, '', $sql));
    }

    /**
     * 获取用户的blog列表。
     * 包括点赞和评论计数，还有作者姓名。
     *
     * @param $userId
     * @param $page
     * @return mixed
     */
    public static function getMyBlog($userId, $page)
    {
        if (is_null($page)) {
            $limit = 'limit 10 offset 0;';
        } else {
            $limit = 'limit ' . ($page * 10) . ' offset ' . ($page * 10 - 10) . ';';
        }

        $sql = self::sqlBase() . "WHERE articles.author_id = '$userId' ORDER BY articles.id DESC ";
        $sql .= $limit;

        return DB::select(str_replace(PHP_EOL, '', $sql));
    }

    /**
     * 获取置顶blog列表
     *
     * @return mixed
     */
    public static function getTopBlog()
    {
        $sql = self::sqlBase() . 'WHERE articles.is_top = 1;';

        return DB::select(str_replace(PHP_EOL, '', $sql));
    }

    /**
     * 获取标准blog列表
     *
     * @param $page
     * @param null $userId
     * @return mixed
     */
    public static function getBlogList($page, $userId = null)
    {
        if (is_null($page)) {
            $limit = 'limit 10 offset 0;';
        } else {
            $limit = 'limit ' . ($page * 10) . ' offset ' . ($page * 10 - 10) . ';';
        }

        $sql = self::sqlBase() . "WHERE articles.is_top = 0 ORDER BY articles.id DESC ";
        $sql .= $limit;

        return DB::select(str_replace(PHP_EOL, '', $sql));
    }

    /**
     * 获取最新的blog列表
     *
     * @param $page
     * @param null $userId
     * @return mixed
     */
    public static function getNewBlogList($page, $userId = null)
    {
        if (is_null($page)) {
            $limit = 'limit 10 offset 0;';
        } else {
            $limit = 'limit ' . ($page * 10) . ' offset ' . ($page * 10 - 10) . ';';
        }

        $sql = self::sqlBase() . "ORDER BY articles.id DESC ";
        $sql .= $limit;

        return DB::select($sql);
    }

    /**
     * 获取最热的blog列表
     *
     * @param $page
     * @param null $userId
     * @return mixed
     */
    public static function getHotBlogList($page, $userId = null)
    {
        if (is_null($page)) {
            $limit = 'limit 10 offset 0;';
        } else {
            $limit = 'limit ' . ($page * 10) . ' offset ' . ($page * 10 - 10) . ';';
        }

        $sql = self::sqlBase() . "ORDER BY articles.id ASC ";
        $sql .= $limit;

        return DB::select($sql);
    }

    /**
     * 获取某个tag分类下的blog列表
     *
     * @param $tagName
     * @param $page
     * @param null $userId
     * @return mixed
     */
    public static function getTagBlogList($tagName, $page, $userId = null)
    {
        if (is_null($page)) {
            $limit = 'limit 10 offset 0;';
        } else {
            $limit = 'limit ' . ($page * 10) . ' offset ' . ($page * 10 - 10) . ';';
        }

        $sql = self::sqlBase() . "WHERE articles.main_tag = '$tagName' ORDER BY articles.id DESC ";
        $sql .= $limit;

        return DB::select(str_replace(PHP_EOL, '', $sql));
    }
}
