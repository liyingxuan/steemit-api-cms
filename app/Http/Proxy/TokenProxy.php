<?php
/**
 * Created by PhpStorm.
 *
 * 主要用于前端登陆时，隐藏关键信息做的proxy。
 *
 * User: lyx
 * Date: 2017/12/24
 * Time: 14:53
 */
namespace App\Http\Proxy;

class TokenProxy
{
    protected $http;

    /**
     * TokenProxy constructor.
     * @param \GuzzleHttp\Client $http
     */
    public function __construct(\GuzzleHttp\Client $http)
    {
        $this->http = $http;
    }

    /**
     * User login.
     *
     * @param $name
     * @param $password
     * @return $this|\Illuminate\Http\JsonResponse
     */
    public function login($name, $password)
    {
        if (auth()->attempt(['email' => $name, 'password' => $password, 'is_active' => 1])) {
            return $this->proxy('password', [
                'username' => $name,
                'password' => $password,
                'scope' => ''
            ]);
        } else {
            return response()->json([
                'status' => false,
                'message' => 'Credentials not match'
            ], 421);
        }
    }

    /**
     * 使用代理来加载敏感信息。
     *
     * @param $grantType
     * @param array $data
     * @return $this
     */
    public function proxy($grantType, array $data = [])
    {
        $data = array_merge($data, [
            'client_id' => env('PASSPORT_CLIENT_ID'),
            'client_secret' => env('PASSPORT_CLIENT_SECRET'),
            'grant_type' => $grantType
        ]);

        $response = $this->http->post(env('MY_API_HTTP_HEAD'). 'oauth/token', [
            'form_params' => $data
        ]);

        $token = json_decode((string)$response->getBody(), true);

        return response()->json([
            'token' => $token['access_token'],
            'expires_in' => $token['expires_in']
        ])->cookie('refreshToken', $token['refresh_token'], 2592000, null, null, false, true);
    }
}
