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
use App\ArticleComment;
use App\ArticleHate;
use App\ArticleLike;
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
        if ($tagList !== '') {
            $tagList = array_slice($tagList, 0, 5); // 只保留5个

            // Tag入库，并自动过滤掉已有的
            foreach ($tagList as $tagItem) {
                try {
                    ArticleTag::create(array('name' => $tagItem));
                } catch (\Exception $e) {
                    // 过滤掉错误，不执行任何操作
                }
            }
        } else {
            $tagList = '';
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
     * 插入链上返回的txid
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function insertTxid(Request $request)
    {
        return RetJson::format(Article::where('id', $request->get('id'))->update(['txid' => $request->get('txid')]));
    }

    /**
     * 获得某一篇blog
     *
     * @param $articleId
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function blog(Request $request, $articleId)
    {
        $user = $request->user();
        if (is_null($user)) {
            $articles = Article::getBlog($articleId, $request->get('page'));
        } else {
            $articles = Article::getBlog($articleId, $request->get('page'));

            // 获取是否喜欢，赋予相应的值
            $isLike = ArticleLike::where('user_id', $user->id)->where('article_id', $articleId)->first();
            if (is_null($isLike)) {
                $articles[0]->myStar = false;
            } else {
                $articles[0]->myStar = true;
            }
            // 获取是否评论，赋予相应的值
            $isComment = ArticleComment::where('author_id', $user->id)->where('article_id', $articleId)->first();
            if (is_null($isComment)) {
                $articles[0]->myComment = false;
            } else {
                $articles[0]->myComment = true;
            }
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

        $articles = Article::getMyBlog($user->id, $request->get('page'));

        return RetJson::formatDbSelect($articles, $request);
    }

    /**
     * 设置用户已经点过赞/拍过砖的数据
     *
     * @param $articles
     * @param $userId
     */
    public function setLikesAndComments($articles, $userId)
    {
        // 获取id list
        $articlesIdList = array_pluck($articles, 'id');

        // 查询登录用户like和comment列表
        $myLikeArticleId = ArticleLike::where('user_id', $userId)->whereIn('article_id', $articlesIdList)->get()->pluck('article_id')->toArray();
        $myHateArticleId = ArticleHate::where('user_id', $userId)->whereIn('article_id', $articlesIdList)->get()->pluck('article_id')->toArray();
        $myCommentArticleId = ArticleComment::where('author_id', $userId)->whereIn('article_id', $articlesIdList)->get()->pluck('article_id')->toArray();

        // 重新给返回数据赋值
        foreach ($articles as &$article) {
            if (in_array($article->id, $myLikeArticleId)) {
                $article->myStar = true;
            } else {
                $article->myStar = false;
            }

            if (in_array($article->id, $myHateArticleId)) {
                $article->myHate = true;
            } else {
                $article->myHate = false;
            }

            if (in_array($article->id, $myCommentArticleId)) {
                $article->myComment = true;
            } else {
                $article->myComment = false;
            }
        }
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
            $articles = Article::getBlogList($request->get('page'));
        } else {
            $articles = Article::getBlogList($request->get('page'), $user->id);
            $this->setLikesAndComments($articles, $user->id);
        }

        if (is_null($request->get('page')) || $request->get('page') == 1) {
            $articleTop = Article::getTopBlog();
            if (count($articleTop) !== 0) {
                $articles = array_merge($articleTop, $articles);
            }
        }

        return RetJson::formatDbSelect($articles, $request);
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
            $articles = Article::getNewBlogList($request->get('page'));
        } else {
            $articles = Article::getNewBlogList($request->get('page'), $user->id);
            $this->setLikesAndComments($articles, $user->id);
        }

        return RetJson::formatDbSelect($articles, $request);
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
            $articles = Article::getHotBlogList($request->get('page'));
        } else {
            $articles = Article::getHotBlogList($request->get('page'), $user->id);
            $this->setLikesAndComments($articles, $user->id);
        }

        return RetJson::formatDbSelect($articles, $request);
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
            $articles = Article::getTagBlogList($tagName, $request->get('page'));
        } else {
            $articles = Article::getTagBlogList($tagName, $request->get('page'), $user->id);
            $this->setLikesAndComments($articles, $user->id);
        }

        return RetJson::formatDbSelect($articles, $request);
    }
}
