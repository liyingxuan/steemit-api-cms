<?php
/**
 * Created by PhpStorm.
 * User: lyx
 * Date: 2017/11/21
 * Time: 17:32
 */
namespace App\Admin\Extensions;

use Encore\Admin\Form\Field;

/**
 * 百度编辑器
 * Class uEditor
 * @package App\Admin\Extensions
 */
class uEditor extends Field
{
    // 定义视图
    protected $view = 'admin.uEditor';

    // css资源
    protected static $css = [];

    // js资源
    protected static $js = [
        '/laravel-u-editor/ueditor.config.js',
        '/laravel-u-editor/ueditor.all.min.js',
        '/laravel-u-editor/lang/zh-cn/zh-cn.js'
    ];

    public function render()
    {
        $this->script = <<<EOT
        UE.delEditor('ueditor'); // 解决初次刷新无法加载编辑器的bug
        var ue = UE.getEditor('ueditor'); // 默认id是ueditor
        ue.ready(function () {
            ue.execCommand('serverparam', '_token', '{{ csrf_token() }}');
        });
EOT;
        return parent::render();
    }
}