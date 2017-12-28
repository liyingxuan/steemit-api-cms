<?php

namespace App\Api\Controllers;

use App\Api\Common\RetJson;
use App\ArticleTag;
use App\Http\Controllers\Controller;

class TagController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = ArticleTag::orderBy('id', 'desc')->paginate(30);

        return RetJson::format($data);
    }
}
