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
     * User logout.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        // 获取登录用户信息
        $user = auth()->guard('api')->user();
        $accessToken = $user->token();

        // 注销access_token和refresh token
        app('db')->table('oauth_refresh_tokens')
            ->where('access_token_id', $accessToken->id)
            ->update([
                'revoked' => true
            ]);

        // 删除cookie
        app('cookie')->forget('refreshToken');

        // 取消验证
        $accessToken->revoke();

        return response()->json(['message' => 'Logout!'], 204);
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

        // 注意这里的cookie的生命期单位是分钟，43200代表30天；对应了：./app/Providers/AuthServiceProvider.php中的时间
        return response()->json([
            'token' => $token['access_token'],
            'expires_in' => $token['expires_in']
        ])->cookie('refreshToken', $token['refresh_token'], 43200, null, null, false, true);
    }
}
