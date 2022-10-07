<?php

Xdge::char_diff(dirname(dirname(__DIR__)).'/xdge_old', dirname(__DIR__));

mb_internal_encoding("UTF-8");
class Xdge
{
    /**
     * A tool to compare chars between 2 files
     */
    public static function char_diff($src_dir, $dst_dir)
    {
        $record = [];
        foreach (glob($src_dir.'/xdge*.xml') as $src_file) {
            $name = basename($src_file);
            $dst_file = $dst_dir . '/' . $name;
            $src_xml = file_get_contents($src_file);
            $dst_xml = file_get_contents($dst_file);
            $src_chars = mb_str_split($src_xml);
            $dst_chars = mb_str_split($dst_xml);
            if (count($src_chars) != count($dst_chars)) {
                fwrite(STDERR,  $src_file." > ".$dst_file."\n");
                for ($pos = 0, $max = count($src_chars); $pos < $max; $pos++) {
                    $c1 = $src_chars[$pos];
                    $c1_norm = Normalizer::normalize($c1, Normalizer::FORM_C);
                    $c2 = $dst_chars[$pos];

                    if ($c1_norm == $c2) continue;
                    echo $pos . "\n";
                    echo mb_substr($src_xml, $pos - 10, 20). "\n";
                    echo mb_substr($dst_xml, $pos - 10, 20). "\n";
                    echo $c1 . 'u' . self::hex4(IntlChar::ord($c1)) 
                    . '  ' . $c2 . 'u' . self::hex4(IntlChar::ord($c2))
                    . "\n";
                    break;
                }
                continue;
            }
            continue;
            for ($pos = 0, $max = count($src_chars); $pos < $max; $pos++) {
                $c1 = $src_chars[$pos];
                $c2 = $dst_chars[$pos];
                if ($c1 == $c2) continue;
                $key = $c1.$c2;
                if (!isset($record[$key])) {
                    $record[$key] = [
                        1, 
                        $c1,
                        self::hex4(IntlChar::ord($c1)),
                        $c2, 
                        self::hex4(IntlChar::ord($c2)),
                    ];
                } 
                else{
                    $record[$key][0]++;
                }
            }
        }
        echo "count\t<orth>\thex\tFORM_C\thex\n";
        foreach ($record as $key => $row) {
            echo implode("\t", $row) . "\n";
        }
    }
    public static function tsv_loop()
    {
        $tsv_file = __DIR__ . '/xdge_nome.tsv';
        $handle = fopen($tsv_file, 'r');
        $n = 0;
        // echo "n°	file	@xml:id	@type	<orth>	\"hex <orth>\nFORM_C\"\n";

        $record = [];
        while (($row = fgetcsv($handle, null, "\t")) !== FALSE) {
            $form = $row[3];
            $norm = Normalizer::normalize($form, Normalizer::FORM_C);
            $n++;
            // $norm2 = Normalizer::normalize($form, Normalizer::FORM_KC);
            if ($form == $norm) continue;
            /*
            echo $n."\t".implode("\t", $row) 
            . "\t" . '"' . trim(str_replace('\u', ' ', json_encode($form)), ' "')
            . "\n" . trim(str_replace('\u', ' ', json_encode($norm)), ' "')
            // . "\n" . trim(str_replace('\u', ' ', json_encode($norm2)), ' "') 
            . '"'
            . "\n";
            */
            $form_chars = mb_str_split($form);
            $norm_chars = mb_str_split($norm);
            for ($i=0, $max=count($form_chars); $i < $max; $i++) {
                $c1 = $form_chars[$i];
                $c2= $norm_chars[$i];
                if ($c1 == $c2) continue;
                $key = $c1.$c2;
                if (!isset($record[$key])) {
                    $record[$key] = [
                        1, 
                        $c1,
                        self::hex4(IntlChar::ord($c1)),
                        $c2, 
                        self::hex4(IntlChar::ord($c2)),
                    ];
                } 
                else{
                    $record[$key][0]++;
                }
            }
        }
        echo "count\t<orth>\thex\tFORM_C\thex\n";
        foreach ($record as $key => $row) {
            echo implode("\t", $row) . "\n";
        }
    }
    public static function hex4($ord)
    {
        return str_pad(dechex($ord), 4, "0", STR_PAD_LEFT);
    }

}