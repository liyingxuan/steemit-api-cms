<?php
/**
 * Created by PhpStorm.
 * User: lyx
 * Date: 2017/12/27
 * Time: 18:36
 */

namespace App\Api\Helper;

class GetImg
{
    /**
     * 提取第一张图片
     *
     * @param $html
     * @return string
     */
    public function extractImgUrl($html)
    {
        preg_match('/<\s*img\s+[^>]*?src\s*=\s*(\'|\")(.*?)\\1[^>]*?\/?\s*>/i', $html, $matches);

        if (count($matches) > 1) {
            return $matches[2];
        } else {
            return '';
        }
    }
}
