<?php

namespace App\Api\Controllers;

use App\Api\Common\RetJson;
use App\ArticleComment;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class CommentController extends Controller
{
    /**
     * 获取某一篇文章下的评论列表
     *
     * @param $articleId
     * @return \Illuminate\Http\JsonResponse
     */
    public function index($articleId)
    {
        $retData = ArticleComment::getComments($articleId);

        return RetJson::format($retData);
    }

    /**
     * 用户发表评论
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function create(Request $request)
    {
        $user = $request->user();
        $data = [
            'author_id' => $user->id,
            'content' => $request->get('content'),
            'article_id' => $request->get('articleId')
        ];
        $retData = ArticleComment::create($data);

        return RetJson::format($retData);
    }
}
