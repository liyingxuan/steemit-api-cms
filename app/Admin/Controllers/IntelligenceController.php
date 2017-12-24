<?php

namespace App\Admin\Controllers;

use App\Intelligence;

use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Layout\Content;
use App\Http\Controllers\Controller;
use Encore\Admin\Controllers\ModelForm;

class IntelligenceController extends Controller
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

            $content->header('新闻情报');
            $content->description('用来给Web钱包展示新闻/情报/公告等信息');

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

            $content->header('修改情报');
            $content->description('修改情报的内容或状态（停用的情报将不会在钱包显示）');

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

            $content->header('新建情报');
            $content->description('新建的情报(状态：启用)，会通过API直接暴露到调用了接口的web钱包公告列表中。');

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
        return Admin::grid(Intelligence::class, function (Grid $grid) {

            $grid->id('ID')->sortable();

            $grid->column('title', '标题');
            $grid->column('summary', '摘要');
            $grid->column('author', '作者');
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
        return Admin::form(Intelligence::class, function (Form $form) {

            $form->display('id', 'ID');

            $form->text('title', '标题');
            $form->textarea('summary', '摘要');
            $form->editor('content', '内容');
            $form->select('status', '状态')->options([
                '启用' => '启用',
                '停用' => '停用'
            ])->default('启用');

            $form->display('author', '作者')->default(Admin::user()->username);

            $form->display('created_at', '创建时间');
            $form->display('updated_at', '更新时间');
        });
    }
}
