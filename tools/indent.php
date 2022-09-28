<?php

$src_file = $argv[1];
$xml = file_get_contents($src_file);
$re_indent = array(
    // multi saut de ligne
    '/( *\n)+/' => "\n",
    // Non xr peut être très mêlé
    // '/([^\n]) *(<(xr)>)/' => "$1\n$2",
    
    // <biblScope>313.38G.</biblScope></bibl></form>
    '/([^ \n]) *(<(cit|dictScrap|form|sense)>)/' => "$1\n$2",
    // indenter </{bloc}}
    '/([^ \n]) *(<\/(cit|dictScrap|form|sense)>)/' => "$1\n$2",
    // indenter </{bloc}} x2 </sense> et </cit>
    '/(<\/(cit|sense)>) *(<\/(cit|sense)>)/' => "$1\n$3",
    // préfixe identifiant <bibl>
    '/(<bibl xml:id=")(\d+)/' => '$1bibl$2',
    // restaurer une espace significative dans <bibl>
    '/([^\.]<\/author>)(<title>)/' => '$1 $2',
    // restaurer une espace significative dans <bibl>
    '/([^\.]<\/title>)(<biblScope>)/' => '$1 $2',
    // simple, basic 
    '/<hi rend="roman">/' => '<hi>',
    // simple, basic 
    '/<hi rend="italic">/' => '<hi>',
    '/\n +/' => "\n",
    // <sense> puce
    '/<num>;<\/num>/' => "<pc>;</pc>",
    // Remonter les ponctuations de fin de </cit>
    '/(\s+)(<\/cit>)([^\n<]+) */' => '$3$1$2',
    // Les gras dans les <ref> sont des <num>
    '/<hi rend="bold">([^<]+)<\/hi>/' => "<num>$1</num>",
    // typer les <sense> a numéro pour le stylage XML direct
    '/<sense>(\s+<num>)/' => "<sense rend=\"num\">$1",
    // des <bibl> démultipliés, après bibl/bibl
    // '/(<\/bibl>) \+\s*(<bibl)/' => '$1 + $2',
    // bibl dans bibl, normaliser l’espacement
    '/ (en|y|cf\.)(<bibl)/' => ' $1 $2',
    //  bibl/note[bibl], à restaurer
    '/(<bibl [^>]+>.*?)(<note>.*?<bibl [^>]+>.*?<\/bibl>.*?<\/note>)/' => "$1\n£££$2",
    // bibl + bibl 
    '/(<\/bibl>) \+\s*(<bibl)/' => "$1 \n£££+ $2",
    // bibl/bibl[1,2], supprimer
    '/(<bibl [^>]+>.*?)<bibl [^>]+>(.*?)<\/bibl>(.*?)<bibl [^>]+>(.*?)<\/bibl>(.*?<\/bibl>)/' => '$1$2$3$4$5',
    // bibl/bibl[1], (si 1 ou 3 initialement)
    '/(<bibl [^>]+>.*?)<bibl [^>]+>(.*?)<\/bibl>(.*?<\/bibl>)/' => '$1$2$3',
    // restaurer bibl/note et bibl + bibl
    '/\n£££/' => "",
    // restaurer <bibl type="equiv">
    '/\s*\(=(<(author|title)>[^)]+?)\)<\/bibl>/' => '</bibl> (=<bibl type="equiv">$1</bibl>)',
    // dédoubler les @xml:id
);

$re_more = array(
);

// étape suivante, les chevauchement
$re_overlap = array(
    // <biblScope>3.<addEnd/>192</biblScope>
    '/<biblScope>([^<]+)<addEnd\/>/' => '<addEnd/><num resp="xdge">$1</num>',

);
$dst_file = $src_file;
// TODO 8
// $xml = preg_replace(array_keys($re_indent), array_values($re_indent), $xml);
$xml = indent($xml);
file_put_contents($dst_file, $xml);

/**
 * Automate spécifique pour indenter le dge, attention, pas très robuste
 * selon les sauts de lign
 */
function indent($xml)
{
    $lines = [];
    // if win "\r\n"
    $separator = "\n";
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
    return implode("\n", $lines);
}
