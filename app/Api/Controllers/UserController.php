<?php
/**
 * Created by PhpStorm.
 * User: lyx
 * Date: 2017/12/25
 * Time: 10:36
 */
namespace App\Api\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Get logged user info.
     *
     * 使用的Laravel passport验证。
     * 前端使用的vue axios ：config.headers['Authorization'] = 'Bearer' + ' ' + jwtToken.getToken()
     * ！！注意Bearer后需要加一个空格，否则无法通过验证。
     *
     * @return mixed
     */
    public function getAuthenticatedUser(Request $request)
    {
        $user = $request->user();

        return response()->json(compact('user'));
    }
}