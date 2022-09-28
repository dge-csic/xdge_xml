<?php

Xdge::tsv_loop();

class Xdge
{
    public static function tsv_loop()
    {
        $tsv_file = __DIR__ . '/xdge_nome.tsv';
        $handle = fopen($tsv_file, 'r');
        $n = 1;
        echo "n°	file	@xml:id	@type	<orth>	\"hex <orth>\nFORM_C\"\n";

        while (($row = fgetcsv($handle, null, "\t")) !== FALSE) {
            $form = $row[3];
            $norm = Normalizer::normalize($form, Normalizer::FORM_C);
            // $norm2 = Normalizer::normalize($form, Normalizer::FORM_KC);
            if ($form != $norm) {
                echo $n."\t".implode("\t", $row) 
                . "\t" . '"' . trim(str_replace('\u', ' ', json_encode($form)), ' "')
                . "\n" . trim(str_replace('\u', ' ', json_encode($norm)), ' "')
                // . "\n" . trim(str_replace('\u', ' ', json_encode($norm2)), ' "') 
                . '"'
                . "\n";
            }
            $n++;
        }
    }


}