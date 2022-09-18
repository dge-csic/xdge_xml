<?php

$file = $argv[1];
$xml = file_get_contents($file);
$re = array(
    '/ +\n/' => "\n",
    '/(<\/sense>)(\n( *)<\/entry>)/' => '$3  $1$2',
    '/(<\/sense>)(\n( *)<sense>)/' => '$3$1$2',
);
$xml = preg_replace(array_keys($re), array_values($re), $xml);
file_put_contents($file.'.xml', $xml);