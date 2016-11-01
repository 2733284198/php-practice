<?php
header("Content-type:text/html;charset=utf-8");

/**
 * =====================================================================================================================
 * 传递数据以易于阅读的样式格式化后输出
 * @param $data
 * =====================================================================================================================
 */
function homePrint($data)
{
    // 定义样式
    $str = '<pre style="display: block;padding: 9.5px;margin: 44px 0 0 0;font-size: 13px;line-height: 1.42857;color: #333;word-break: break-all;word-wrap: break-word;background-color: #F5F5F5;border: 1px solid #CCC;border-radius: 4px;">';
    // 如果是boolean或者null直接显示文字；否则print
    if (is_bool($data)) {
        $show_data = $data ? 'true' : 'false';
    } elseif (is_null($data)) {
        $show_data = 'null';
    } else {
        $show_data = print_r($data, true);
    }
    $str .= $show_data;
    $str .= '</pre>';
    echo $str;
}

/**
 * php cli模式执行php文件
 * 测试
 */
function cli_test()
{
    $count = 0;
    while(true){
        $count++;
        echo $count."\r\n";
        if($count > 10){
            break;
        }
        sleep(3);
    }
    echo 'done';
}

/**
 * 匿名函数也叫闭包函数（closures允许创建一个没有指定没成的函数，最经常用作回调函数参数的值。
 * 闭包函数没有函数名称，直接在function()传入变量即可 使用时将定义的变量当作函数来处理
 */
function everyFunction(){
    $message = 'hello';
    $example = function() use ($message){
        var_dump($message);
    };
    echo $example();
    $message = 'world';
    //输出hello 因为继承变量的值的时候是函数定义的时候而不是 函数被调用的时候
    echo $example();
    //重置为hello
    $message = 'hello';
    //此处传引用
    $example = function() use(&$message){
        var_dump($message);
    };
    echo $example();
    //输出hello
    $message = 'world';
    echo $example();
    //此处输出world
    //闭包函数也用于正常的传值
    $message = 'hello';
    $example = function ($data) use ($message){
        return "{$data},{$message}";
    };

    echo $example('world');
}



















