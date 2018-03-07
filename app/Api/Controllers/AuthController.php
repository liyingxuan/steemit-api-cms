<?php
/**
 * Created by PhpStorm.
 * User: lyx
 * Date: 16/4/18
 * Time: 下午5:45
 */

namespace App\Api\Controllers;

use App\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Api\Common\RetJson;
use Jrean\UserVerification\Traits\VerifiesUsers;
use Jrean\UserVerification\Facades\UserVerification;
use Illuminate\Support\Facades\Mail;

class AuthController extends BaseController
{
    use VerifiesUsers;

    // 验证失败后的跳转地址
    public $redirectIfVerificationFails = '/emails/verification-result/failure';
    // 检测到用户已经验证过后的跳转地址
    public $redirectIfVerified = 'https://forum.nkn.org/#/login';
    // 验证成功后的跳转地址
    public $redirectAfterVerification = 'https://forum.nkn.org/#/login';

    /**
     * @param array $data
     * @return mixed
     */
    protected function validator(array $data)
    {
        return Validator::make($data, [
            'name' => 'required|string|max:255|unique:users',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6'
        ]);
    }

    /**
     * User register.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function register(Request $request)
    {
        $this->validator($request->all())->validate();

        try {
            event(new Registered($user = $this->create($request->all())));

            // 生成用户的验证 token，并将用户的 verified 设置为 0
            UserVerification::generate($user);

            // 给用户发认证邮件
            $params = [
                'link' => url('api/v1/verification', $user->verification_token) . '?email=' . urlencode($user->email),
                'linkName' => 'Click Here'
            ];
            $to = $user->email;
            $subject = 'Welcome to FORTUNE TREE! Confirm Your Email';
            Mail::send(
                'emails.user-verification',
                ['content' => $params],
                function ($message) use ($to, $subject) {
                    $message->to($to)->subject($subject);
                }
            );

            return RetJson::format($user);
        } catch (\Exception $e) {
            return response()->json($e->getMessage());
        }
    }

    /**
     * Create a new user.
     *
     * @param array $data
     * @return mixed
     */
    protected function create(array $data)
    {
        return User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => bcrypt($data['password'])
        ]);
    }

    /**
     * 更新用户注册状态为活跃
     *
     * @param Request $request
     */
    public function updateStatus(Request $request)
    {
        User::where('name', $request->get('name'))->update(['is_active' => 1]);
    }
}
