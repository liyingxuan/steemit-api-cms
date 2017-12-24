<?php
/**
 * Created by PhpStorm.
 * User: lyx
 * Date: 2017/12/24
 * Time: 09:33
 */
namespace App\Api\Common;

class RetJson
{
    public static function format($data)
    {
        return response()->json([
            'code' => 1000,
            'info' => 'success',
            'data' => $data
        ]);
    }
}
