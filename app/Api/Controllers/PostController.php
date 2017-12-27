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

        $data = [
            'title' => $request->get('title'),
            'content' => $request->get('content'),
            'content_html' => $request->get('contentHtml'),
            'first_img_url' => $firstImgUrl,
            'tag' => $request->get('tags'),
            'author_id' => $user->id
        ];
        $articles = Article::create($data);

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
}
