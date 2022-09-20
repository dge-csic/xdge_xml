<?php

$src_file = $argv[1];
$xml = file_get_contents($src_file);
$re_indent = array(
    // multi saut de ligne
    '/( *\n)+/' => "\n",
    // Non xr peut être tr^s mêlé
    // '/([^\n]) *(<(xr)>)/' => "$1\n$2",
    // <biblScope>313.38G.</biblScope></bibl></form>
    '/([^ \n]) *(<(cit|dictScrap|form|sense)>)/' => "$1\n$2",
    '/([^ \n]) *(<\/(cit|dictScrap|form|sense)>)/' => "$1\n$2",
    '/(<\/(cit|sense)>) *(<\/(cit|sense)>)/' => "$1\n$3",
    '/(<bibl xml:id=")(\d+)/' => '$1bibl$2',
    '/([^\.]<\/author>)(<title>)/' => '$1 $2',
    '/([^\.]<\/title>)(<biblScope>)/' => '$1 $2',
    '/<hi rend="roman">/' => '<hi>', 
    '/<hi rend="italic">/' => '<hi>', 
    '/(<\/bibl>) \+\s*(<bibl)/' => '$1 + $2',
    '/\n +/' => "\n",
    '/<num>;<\/num>/' => "<pc>;</pc>",
    '/(\s+)(<\/cit>)([^\n<]+) */' => '$3$1$2',
);

$re_more = array(
    '/<hi rend="bold">([^<]+)<\/hi>/' => "<num>$1</num>",
);

// étape suivante, les chevauchement
$re_overlap = array(
    // <biblScope>3.<addEnd/>192</biblScope>
    '/<biblScope>([^<]+)<addEnd\/>/' => '<addEnd/><num resp="xdge">$1</num>',

);
$dst_file = $src_file;
$xml = preg_replace(array_keys($re_more), array_values($re_more), $xml);
file_put_contents($dst_file, $xml);

/**
 * Automate spécifique pour indenter le dge, attention, pas très robuste
 * selon les sauts de lign
 */
function indent($xml)
{
    $lines = [];
    $separator = "\r\n";
    $l = strtok($xml, $separator);
    
    $tags = array(
        'body' => true,
        'cit' => true,
        'dictScrap' => true,
        'entry' => true,
        'form' => true,
        'sense' => true,
        'TEI' => true,
        'teiHeader' => true,
        'text' => true,
    );
    
    $indent = 0;
    while ($l !== false) {
        preg_match('/^ *<(\/?)([a-z]+)/i', $l, $matches);
        $tag = null;
        if(!isset($matches[2])) {
            echo $l . "\n";
        }
        else {
            $tag = isset($tags[$matches[2]]);
        }
        if ($tag && $matches[1]) $indent--;
    
        $lines[] = substr("                                ", 0, $indent * 2) 
        . trim($l);
        $l = strtok( $separator );
    
        if ($tag && !$matches[1]) $indent++;
    }
    return $lines;
}
