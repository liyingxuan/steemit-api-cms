<?php
/**
 * Created by PhpStorm.
 * User: lyx
 * Date: 2017/12/25
 * Time: 10:36
 */
namespace App\Api\Controllers;

use App\Http\Controllers\Controller;
use App\User;
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

    /**
     * 查询姓名是否已存在
     *
     * @param Request $request
     * @return mixed
     */
    public function verifyName(Request $request)
    {
        $name = User::where('name', $request->get('name'))->first();
        if (is_null($name)) {
            $data = true;
        } else {
            $data = false;
        }

        return response()->json(compact('data'));
    }

    /**
     * 获取私钥验证密码
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function verifyPassword(Request $request)
    {
        $user = $request->user();
        $info = User::where('name', $user->name)->first();
        if (is_null($info)) {
            $old_password = '';
        } else {
            $old_password = $info->password;
        }
        $data = \Hash::check($request->get('password'), $old_password);

        return response()->json(compact('data'));
    }
}
