<?php
/**
 * Created by PhpStorm.
 * User: wilton
 * Date: 13/09/17
 * Time: 14:00
 */

namespace app\components;


use SebastianBergmann\GlobalState\RuntimeException;
use yii\i18n\Formatter;

class CustomFormatter extends Formatter
{
    /**
     * Metodo que formata um telefone com DDD e DDI
     * @param $value
     * @return string
     */
    public function asPhoneDDD($value)
    {
        if ($value === null) {
            return $this->nullDisplay;
        }

        $lenght = strlen($value);
        $value = preg_replace('/[^A-Za-z0-9]/', '', $value);
        $ddd = '(' . substr($value, 0, 2) . ') ';
        $ddi = '';

        // DDD + 8 Digitos e DDD + 9 Digitos
        if ($lenght === 10 || $lenght === 11) {

            $ddd = '(' . substr($value, 0, 2) . ') ';

            // DDI + DDD + 8 Digitos e DDI = DDD + 9 Digitos
        } else if ($lenght === 12 || $lenght === 13) {

            $ddi = '+' . substr($value, 0, 2) . ' ';
            $ddd = '(' . substr($value, 2, 2) . ') ';

        }

        $output = $ddi . $ddd . $this->getPhoneText($value);

        return $output;
    }

    /**
     * Metodo que converte uma decimal do formato BR para US
     * @param float $value
     * @return mixed|string
     */
    public function asDecimalUS($value)
    {
        if (empty($value))
            return '0.00';

        $output = str_replace(".", "", $value);
        return str_replace(",", ".", $output);
    }

    /**
     * Metodo que converte uma data no formato BR para US
     * @param string $value
     * @return string
     */
    public function asDateBr($value)
    {
        $explodeData = explode("-", $value);
        return $explodeData[2] . '/' . $explodeData[1] . '/' . $explodeData[0];
    }

    public function asDateUS($value)
    {
        $explodeData = explode("/", $value);
        return $explodeData[2] . '-' . $explodeData[1] . '-' . $explodeData[0];
    }

    public function asDateUsReferencia($value)
    {
        $explodeData = explode("/", $value);
        $explodeData[0] = '01'; 
        return $explodeData[2] . '-' . $explodeData[1] . '-' . $explodeData[0];
    }

     public function asDateUsFormatMY($value)
    {
        $value = date('Y-m-d', strtotime('-1 month', strtotime($value)));
            
        //pega o máximo de dias daquele mês
        $days = date('t', strtotime($value));
        $value = explode("-", $value);
        $value[2] = $days;
        $value = (string)$value[0] . '-' . (string)$value[1] . '-' . (string)$value[2];

            return $value;
    }
    //compara se o mês e ano da data de referencia e da data final são iguais ( bens comprados no mesmo mês e ano não processam)
    public function asDateUsCompare($value1, $value2){
        $explodeData1 = explode("-", $value1);
        $explodeData2 = explode("-", $value2);

        if(($explodeData1[1] == $explodeData2[1]) && ($explodeData1[0] == $explodeData2[0]) ){           
            return -1;
        }else{
            $explodeData1 = (string)$explodeData1[0] . '-' . (string)$explodeData1[1] . '-' . (string)$explodeData1[2];
            return $explodeData1;
        }
    }

    /**
     * Metodo que converte um datetime no formato BR para US
     * @param string $value
     * @return string
     */
    public function asDateTimeUS($value)
    {
        $date = explode(' ', $value);
        $data = explode('/', $date[0]);
        return $data[2] . '-' . $data[1] . '-' . $data[0] . ' ' . $date[1];
    }

    /**
     * Metodo que extrai somente o digitos do telefone, sem DDD e sem DDI
     * @param $value
     * @return string
     */
    private function getPhoneText($value)
    {
        $value = preg_replace('/[^A-Za-z0-9]/', '', $value);
        $length = strlen($value);

        // Telefone 8 Digitos
        if ($length === 8) {

            $first = substr($value, 0, 4);
            $last = substr($value, 4, 4);

            // Telefone 9 Digitos
        } else if ($length === 9) {

            $first = substr($value, 0, 1) . substr($value, 1, 4);
            $last = substr($value, 5, 4);

            // DDD + 8 Digitos
        } else if ($length === 10) {

            $first = substr($value, 2, 4);
            $last = substr($value, 6, 4);

            // DDD + 9 Digitos
        } else if ($length === 11) {

            $first = substr($value, 2, 1) . substr($value, 3, 4);
            $last = substr($value, 7, 4);

            // DDI + DDD + 8 Digitos
        } else if ($length === 12) {

            $first = substr($value, 4, 4);
            $last = substr($value, 8, 4);

            // DDI + DDD + 9 Digitos
        } else if ($length === 13) {

            $first = substr($value, 4, 1) . substr($value, 5, 4);
            $last = substr($value, 9, 4);

        } else {
            throw new RuntimeException('Formato de Telefone inválido.');
        }

        return "{$first}-{$last}";
    }

    /**
     * Remove todos os caracteres não numéricos.
     * @param string $string O valor a ser formatado.
     * @return mixed O valor somente com caracteres numéricos.
     */
    public static function removeCharactersNonNumeric($string)
    {
        return preg_replace('/[^0-9]/', '', $string);
    }

    /**
     * Método que formata um valor para o formato CEP.
     * @param string $string O valor a ser formatado.
     * @return string O valor formatado para CEP.
     */
    public static function asCep($string)
    {
        return substr($string, 0, 5) . '-' . substr($string, 5);
    }


    /**
     * Método que formata um valor para o formato CPF ou CNPJ.
     * @param string $string O valor a ser formatado.
     * @return string O valor formatado para CPF ou CNPJ.
     */
    public static function asCgc($string)
    {
        if (strlen($string) === 11)
            return substr($string, 0, 3) . '.' . substr($string, 3, 3) . '.' . substr($string, 6, 3) . '-' . substr($string, -2);
        else
            return substr($string, 0, 2) . '.' . substr($string, 2, 3) . '.' . substr($string, 5, 3) . '/' . substr($string, 8, 4) . '-' . substr($string, -2);
    }
}