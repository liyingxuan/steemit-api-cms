<?php

namespace App\Admin\Controllers;

use App\HelpDoc;

use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Layout\Content;
use App\Http\Controllers\Controller;
use Encore\Admin\Controllers\ModelForm;

class HelpDocController extends Controller
{
    use ModelForm;

    /**
     * Index interface.
     *
     * @return Content
     */
    public function index()
    {
        return Admin::content(function (Content $content) {
            $content->header('帮助文档');
            $content->description('用来给用户提供钱包使用帮忙的');

            $content->body($this->grid());
        });
    }

    /**
     * Edit interface.
     *
     * @param $id
     * @return Content
     */
    public function edit($id)
    {
        return Admin::content(function (Content $content) use ($id) {
            $content->header('修改文档');
            $content->description('修改帮助文档的内容，启用的将会暴露到钱包网站上，停用的可以备用');

            $content->body($this->form()->edit($id));
        });
    }

    /**
     * Create interface.
     *
     * @return Content
     */
    public function create()
    {
        return Admin::content(function (Content $content) {
            $content->header('新建帮助');
            $content->description('新建的帮助文档(状态：启用)，会通过API直接暴露到调用了接口的web钱包公告列表中。');

            $content->body($this->form());
        });
    }

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        return Admin::grid(HelpDoc::class, function (Grid $grid) {
            $grid->id('ID')->sortable();

            $grid->column('title', '标题');
            $grid->column('summary', '摘要');
            $grid->column('status', '状态');

            $grid->created_at();
            $grid->updated_at();

            $grid->actions(function ($actions) {
                $actions->disableDelete();
            });
        });
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        return Admin::form(HelpDoc::class, function (Form $form) {
            $form->display('id', 'ID');

            $form->text('title', '标题');
            $form->textarea('summary', '摘要');
            $form->editor('content', '内容');
            $form->select('status', '状态')->options([
                '启用' => '启用',
                '停用' => '停用'
            ])->default('启用');

            $form->display('created_at', '创建时间');
            $form->display('updated_at', '更新时间');
        });
    }
}
