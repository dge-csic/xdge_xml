<?php


class Xdge
{
    public static function tsv_loop()
    {
        $tsv_file = __DIR__ . '/xdge_nome.tsv';
        $handle = fopen($tsv_file, 'r');
        while (($row = fgetcsv($handle, null, "\t")) !== FALSE) {
        }
    }
}