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

        $to = 'contact@nkn.org';
        $subject = 'User subscribe';
        Mail::send('emails.subscribe', ['content' => $params], function ($message) use ($to, $subject) {
            $message->to($to)->subject($subject);
        });

        return SubscribeEmail::create($request->all());
    }

    /**
     * Test email
     */
    public function email()
    {
        $params = [
            'link' => url('api/v1/verification', 'test') . '?email=' . urlencode('44600937@qq.com'),
            'linkName' => 'Click Here'
        ];

        $to = '44600937@qq.com';
        $subject = 'Welcome to FORTUNE TREE! Confirm Your Email';
        Mail::send('emails.user-verification', ['content' => $params], function ($message) use ($to, $subject) {
            $message->to($to)->subject($subject);
        });

        dd(Mail::failures());
    }
}
