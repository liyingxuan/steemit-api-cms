<?php

namespace App\Api\Controllers;

use App\Api\Common\RetJson;
use App\ArticleHate;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class HateController extends Controller
{
    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        $user = $request->user();
        $data = [
            'user_id' => $user->id,
            'article_id' => $request->get('articleId')
        ];
        $retData = ArticleHate::create($data);

        return RetJson::format($retData);
    }
}
