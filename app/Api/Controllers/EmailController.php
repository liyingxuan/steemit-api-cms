<?php
/**
 * Created by PhpStorm.
 * User: lyx
 * Date: 2017/12/25
 * Time: 10:36
 */
namespace App\Api\Controllers;

use App\Http\Controllers\Controller;
use App\SubscribeEmail;
use Illuminate\Http\Request;

class EmailController extends Controller
{
    public function insert(Request $request)
    {
        return SubscribeEmail::create($request->all());
    }
}
