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
use Illuminate\Support\Facades\Mail;

class EmailController extends Controller
{
    public function insert(Request $request)
    {
        $params = [
            'email' => $request->get('email'),
            'message' => $request->get('content')
        ];

        Mail::send('emails.subscribe', ['content' => $params], function ($message) {
            $to = 'contact@nkn.org';
            $message->to($to)->subject('NKN user subscribe');
        });

        return SubscribeEmail::create($request->all());
    }

    /**
     * Test email
     */
    public function email()
    {
        $params = [
            'email' => 'test@test.com',
            'message' => 'test message'
        ];

        Mail::send('emails.subscribe', ['content' => $params], function ($message) {
            $to = 'mvp_xuan@163.com';
            $message->to($to)->subject('测试邮件');
        });

        dd(Mail::failures());
    }
}
