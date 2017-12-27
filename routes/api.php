<?php
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/**
 * Api Doc
 */
Route::get('/doc', '\App\Api\Common\ApiDoc@index');

$api = app('Dingo\Api\Routing\Router');
$api->version('v1', function ($api) {
    $api->group(['namespace' => 'App\Api\Controllers'], function ($api) {
        $api->get('intelligence', 'IntelligenceController@index');
        $api->get('help-doc', 'HelpDocController@index');

        $api->post('register', 'AuthController@register');
        $api->post('login', 'LoginController@login');
        $api->post('token/refresh', 'LoginController@refresh');
        $api->post('logout', 'LoginController@logout');
    });

    /**
     * Token Auth
     */
    $api->group(['namespace' => 'App\Api\Controllers', 'middleware' => 'auth:api'], function ($api) {
        // User
        $api->group(['prefix' => 'user'], function ($api) {
            $api->get('profile', 'UserController@getAuthenticatedUser');
        });

        // Post
        $api->group(['prefix' => 'post'], function ($api) {
            $api->post('create', 'PostController@create');
            $api->get('my-blog', 'PostController@myBlog');
        });
    });
});
