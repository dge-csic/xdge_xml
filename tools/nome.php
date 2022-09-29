<?php

// Xdge::tsv_loop();
echo Xdge::hex4(IntlChar::ord(Normalizer::normalize('', Normalizer::FORM_C)));

mb_internal_encoding("UTF-8");
class Xdge
{
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