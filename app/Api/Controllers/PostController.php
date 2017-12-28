<?php
/**
 * Created by PhpStorm.
 * User: lyx
 * Date: 2017/12/25
 * Time: 10:36
 */
namespace App\Api\Controllers;

use App\Api\Common\RetJson;
use App\Api\Helper\GetImg;
use App\Article;
use App\ArticleTag;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class PostController extends Controller
{
    /**
     * User submit post.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function create(Request $request)
    {
        $user = $request->user();

        // 获取html代码中第一张图片
        $getImg = new GetImg();
        $firstImgUrl = $getImg->extractImgUrl($request->get('contentHtml'));

        // 获取tag
        $tagList = explode(' ', trim($request->get('tags')));
        $tagList = array_slice($tagList, 0, 5); // 只保留5个

        // Tag入库，并自动过滤掉已有的
        foreach ($tagList as $tagItem) {
            try {
                ArticleTag::create(array('name' => $tagItem));
            } catch (\Exception $e) {
                // 过滤掉错误，不执行任何操作
            }
        }

        $data = [
            'title' => $request->get('title'),
            'content' => $request->get('content'),
            'content_html' => $request->get('contentHtml'),
            'first_img_url' => $firstImgUrl,
            'main_tag' => $tagList[0],
            'tag' => json_encode($tagList),
            'author_id' => $user->id
        ];
        $articles = Article::create($data);

        return RetJson::format($articles);
    }

    /**
     * 获得某一篇blog
     *
     * @param $articleId
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function blog($articleId, Request $request)
    {
        $user = $request->user();
        if (is_null($user)) {
            $articles = Article::getBlog($articleId);
        } else {
            $articles = Article::getBlog($articleId, $user->id);
        }

        return RetJson::format($articles);
    }

    /**
     * Get my blog list.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function myBlog(Request $request)
    {
        $user = $request->user();

        $articles = Article::getMyBlog($user->id);

        return RetJson::format($articles);
    }

    /**
     * 获取常规blog列表
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function blogList(Request $request)
    {
        $user = $request->user();
        if (is_null($user)) {
            $articles = Article::getBlogList();
        } else {
            $articles = Article::getBlogList($user->id);
        }

        return RetJson::format($articles);
    }

    /**
     * 获取最新的blog列表
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function newBlogList(Request $request)
    {
        $user = $request->user();
        if (is_null($user)) {
            $articles = Article::getNewBlogList();
        } else {
            $articles = Article::getNewBlogList($user->id);
        }

        return RetJson::format($articles);
    }

    /**
     * 获取最热门的blog列表
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function hotBlogList(Request $request)
    {
        $user = $request->user();
        if (is_null($user)) {
            $articles = Article::getHotBlogList();
        } else {
            $articles = Article::getHotBlogList($user->id);
        }

        return RetJson::format($articles);
    }

    /**
     * 获得某个tag分类下的
     *
     * @param $tagName
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function tagBlogList($tagName, Request $request)
    {
        $user = $request->user();
        if (is_null($user)) {
            $articles = Article::getTagBlogList($tagName);
        } else {
            $articles = Article::getTagBlogList($tagName, $user->id);
        }

        return RetJson::format($articles);
    }
}
