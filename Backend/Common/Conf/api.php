<?php
setOption();
$redis->psubscribe(array('__keyevent@0__:expired'), 'psCallback');
// 回调函数,这里写处理逻辑
function psCallback($redis, $pattern, $chan, $msg)
{
    echo "Pattern: $pattern\n";
    echo "Channel: $chan\n";
    echo "Payload: $msg\n\n";
} ?>
