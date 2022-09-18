<?php

$file = $argv[1];
$xml = file_get_contents($file);
$re_indent = array(
    // multi saut de ligne
    '/( *\n)+/' => "\n",
    // <biblScope>313.38G.</biblScope></bibl></form>
    '/([^ \n]) *(<\/(cit|sense)>)/' => "$1\n$2",
    '/(<\/(bibl|cit|sense)>) *(<\/(bibl|cit|sense)>)/' => "$1\n$3",
    // *2
    // '/([^ \n]) *(<\/(cit|form|sense)>)/' => "$1\n$2",
    // *3
    // '/([^ \n]) *(<\/(cit|form|sense)>)/' => "$1\n$2",
    // <bibl>\n<author>
    '/(<\/title>) *\n *(<biblScope>)/' => "$1 $2",
    '/(<bibl[^>]*>)\s+/' => '$1',
    '/\s+(<\/bibl>)\s+/' => '$1',
    // tenter de l’indentation propre
    '/([^ ])(<\/sense>)(\n( +)<sense>)/' => '$1$4$2$3',
    '/([^ ])(<\/sense>)(\n( *)<\/entry>)/' => '$1$4  $2$3',
    '/\n(<\/sense>)((\n +)<\/sense>)/' => "$3  $1$2",
    // \n</bibl>,\n    <bibl
    '/\n(<\/(bibl|cit|form)>[^\n]*)(\n +)(<\2)/' => "$3$1$3$4",
    // \n</cit>\n        </sense>
    '/\n(<\/(bibl|cit|form)>[^\n]*)(\n +)(<\/sense>)/' => "$3  $1$3$4",
    // '/([^ ]<\/sense>)(\n( *)<sense>)/' => '$3$1$2',
    // <bibl xml:id="400089"> => <bibl xml:id="bibl400089">
    '/(<bibl xml:id=")(\d+)/' => '$1bibl$2',
);
// étape suivante, les chevauchement
$re_overlap = array(
    // <biblScope>3.<addEnd/>192</biblScope>
    '/<biblScope>([^<]+)<addEnd\/>/' => '<addEnd/><num resp="xdge">$1</num>',

);

$xml = preg_replace(array_keys($re_indent), array_values($re_indent), $xml);
file_put_contents($file.'.xml', $xml);