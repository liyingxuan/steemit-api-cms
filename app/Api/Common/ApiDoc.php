<?php
/**
 * Created by PhpStorm.
 * User: lyx
 * Date: 16/4/18
 * Time: 下午3:09
 */

namespace App\Api\Common;

use App\Api\Controllers\BaseController;

/**
 * Class HospitalsController
 * @package App\Api\Controllers
 */
class ApiDoc extends BaseController
{
    /**
     * @return \Dingo\Api\Http\Response
     */
    public function index()
    {
        $http = env('MY_API_HTTP_HEAD', 'http://localhost');
        $prefix = 'api/';
        $version = 'v1';
        $url = $http . $prefix . $version;

        $api = [
            '统一说明' => [
                '域名' => $http,
                '数据格式' => 'JSON',
                '数据结构(response字段)' => [
                    'code' => '1000',
                    'info' => '状态信息（success | fail）或报错信息；在HTTP状态码非200时,一般是报错信息',
                    'data' => '数据块',
                    'debug' => '只有内测时某些功能有该字段,用于传递一些非公开数据或调试信息'
                ],
                'url字段' => 'HTTP请求地址; {}表示在链接后直接跟该数据的ID值即可,例:http://api-url/v1/data/77?token=xx,能获取id为77的data信息',
                'method字段' => 'GET / POST',
                'form-data字段' => '表单数据',
                'response字段' => '数据结构',
                'HTTP状态码速记' => [
                    '释义' => 'HTTP状态码有五个不同的类别:',
                    '1xx' => '临时/信息响应',
                    '2xx' => '成功; 200表示成功获取正确的数据; 204表示执行/通讯成功,但是无返回数据',
                    '3xx' => '重定向',
                    '4xx' => '客户端/请求错误; 需检查url拼接和参数; 在我们这会出现可以提示的[message]或需要重新登录获取token的[error]',
                    '5xx' => '服务器错误; 可以提示服务器崩溃/很忙啦~',
                ],
            ],

            '情报信息' => $this->intelligences($url),

            '帮忙文档' => $this->helpDoc($url),

            '获取各种Blog列表' => $this->blogList($url)
        ];

        return response()->json(compact('api'));
    }

    /**
     * 情报信息
     *
     * @param $url
     * @return array
     */
    public function intelligences($url)
    {
        return [
            '最新情报' => [
                '说明' => '倒序获取情报列表，每次最多10条',
                'url' => $url . '/intelligence',
                'method' => 'GET',
                'params' => [],
                'response' => [
                    'code' => '',
                    'info' => '',
                    'data' => [
                        'current_page' => '页数',
                        'data' => '实际数据list',
                        'first_page_url' => '第一页信息',
                        'last_page_url' => '最后一页信息',
                        'next_page_url' => '下一页的调用地址，可以直接赋值到button上'
                    ]
                ]
            ]
        ];
    }

    /**
     * 帮助文档
     *
     * @param $url
     * @return array
     */
    public function helpDoc($url)
    {
        return [
            '帮助文档' => [
                '说明' => '获取帮助文档',
                'url' => $url . '/help-doc',
                'method' => 'GET',
                'params' => [],
                'response' => [
                    'code' => '',
                    'info' => '',
                    'data' => [
                        'current_page' => '页数',
                        'data' => '实际数据list',
                        'first_page_url' => '第一页信息',
                        'last_page_url' => '最后一页信息',
                        'next_page_url' => '下一页的调用地址，可以直接赋值到button上'
                    ]
                ]
            ]
        ];
    }

    /**
     * 获取各种blog列表
     *
     * @param $url
     * @return array
     */
    public function blogList($url)
    {
        return [
            '帮助文档' => [
                '说明' => '获取登录用户的blog列表',
                '获取我的Blog列表url' => $url . '/post/my-blog',
                '获取默认的Blog列表url' => $url . '/post/blogs',
                '获取最新的Blog列表url' => $url . '/post/new-blog',
                '获取最热的Blog列表url' => $url . '/post/hot-blog',
                '获取某一个tag下的Blog列表url' => $url . '/post/tag-blog/{tagName}',
                '获取默认的Blog列表url-未登录' => $url . '/blogs',
                '获取最新的Blog列表url-未登录' => $url . '/new-blog',
                '获取最热的Blog列表url-未登录' => $url . '/hot-blog',
                '获取某一个tag下的Blog列表url-未登录' => $url . '/tag-blog/{tagName}',
                'method' => 'GET',
                'params' => [],
                'response' => [
                    'code' => '',
                    'info' => '',
                    'data' => [
                        'current_page' => '页数',
                        'data' => [
                            'id' => 'post id',
                            'author' => '作者',
                            'author_id' => '作者id',
                            'title' => '标题',
                            'content' => '内容',
                            'content_html' => '内容html化',
                            'first_img_url' => '第一张图片url',
                            'tag' => 'tag list',
                            'starCount' => '赞的数量',
                            'commentCount' => '评论的数量',
                            'txid' => '交易hash',
                            'created_at' => '最初创建时间',
                            'updated_at' => '最后更新时间'
                        ],
                        'first_page_url' => '第一页信息',
                        'last_page_url' => '最后一页信息',
                        'next_page_url' => '下一页的调用地址，可以直接赋值到button上'
                    ]
                ]
            ]
        ];
    }
}
