<?php

namespace app\modules;

use app\models\Entidade;
use yii\helpers\BaseArrayHelper;

class Helper
{
    public static function map($array, $from, $to, $group = null)
    {
        $result = [];
        foreach ($array as $element) {
            $key = BaseArrayHelper::getValue($element, $from);
            $value = '';
            if (is_array($to)) {
                foreach ($to as $index) {
                    if (!empty($value))
                        $value .= ' - ' . BaseArrayHelper::getValue($element, $index);
                    else
                        $value = BaseArrayHelper::getValue($element, $index);
                }
            } else {
                $value = BaseArrayHelper::getValue($element, $to);
            }

            if ($group !== null) {
                $result[BaseArrayHelper::getValue($element, $group)][$key] = $value;
            } else {
                $result[$key] = $value;
            }
        }

        return $result;
    }

    public static function compareFloatNumbers($float1, $float2, $operator = '=')
    {
        $epsilon = 0.00001;

        $float1 = (float)$float1;
        $float2 = (float)$float2;

        switch ($operator) {
            case "=":
                {
                    if (abs($float1 - $float2) < $epsilon) {
                        return true;
                    }
                    break;
                }
            case "<":
                {
                    if (abs($float1 - $float2) < $epsilon) {
                        return false;
                    } else {
                        if ($float1 < $float2) {
                            return true;
                        }
                    }
                    break;
                }
            case "<=":
                {
                    if (self::compareFloatNumbers($float1, $float2, '<') || self::compareFloatNumbers($float1, $float2, '=')) {
                        return true;
                    }
                    break;
                }
            case ">":
                {
                    if (abs($float1 - $float2) < $epsilon) {
                        return false;
                    } else {
                        if ($float1 > $float2) {
                            return true;
                        }
                    }
                    break;
                }
            case ">=":
                {
                    if (self::compareFloatNumbers($float1, $float2, '>') || self::compareFloatNumbers($float1, $float2, '=')) {
                        return true;
                    }
                    break;
                }
            case "<>":
            case "!=":
                {
                    if (abs($float1 - $float2) > $epsilon) {
                        return true;
                    }
                    break;
                }
        }

        return false;
    }

    public static function sigaCabecalho($tipo, $entidade)
    {
        $cabecalho = '0';
        $cabecalho .= str_pad($tipo, 15, ' ', STR_PAD_RIGHT);
        $cabecalho .= date('d/m/YH:i:s');
        $cabecalho .= str_pad('1', 4, ' ', STR_PAD_LEFT);
        $cabecalho .= str_pad('SIGA', 10, ' ', STR_PAD_RIGHT);
        $cabecalho .= str_pad($entidade->unidade_gestora, 4, ' ', STR_PAD_LEFT);
        $cabecalho .= str_pad($entidade->nome, 100, ' ', STR_PAD_RIGHT);
        $cabecalho .= str_pad("1", 10, ' ', STR_PAD_LEFT);
        $cabecalho .= "\n";

        return $cabecalho;
    }

    public static function xml_attribute($object, $attribute)
    {
        if (isset($object[$attribute]))
            return (string)$object[$attribute];
        return false;
    }
}
