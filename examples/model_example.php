<?php
namespace app\models;
use nepstor\validators\DateTimeCompareValidator;

class model_example extends MainModel
{
    public function rules()
    {
        return [
            [['NUMERO'], 'unique', 'targetAttribute' => ['NUMERO', 'FK_CONTRATO'], 'message' => 'Existe aditivo cadastrado com este número'], // Unique Composto
            ['DATA', DateTimeCompareValidator::className(), 'compareAttribute' => 'dataContrato', 'format' => 'd/m/Y', 'jsFormat' => 'DD/MM/YYYY', 'operator' => '>=', 'enableClientValidation' => false], // DateCompare
            [['VALOR'], 'number', 'numberPattern' => '/^\$?(([1-9](\d*|\d{0,2}(.\d{3})*))|0)(\,\d{1,2})?$/', 'min' => '0,01'], // Decimal 2 Casas
            [['QUANTIDADE_PEDIDA'], 'number', 'numberPattern' => '/^\$?(([1-9](\d*|\d{0,2}(.\d{3})*))|0)(\,\d{1,3})?$/', 'min' => '0,001'], // Decimal 3 Casas
            [['CNPJ'], 'validaCpfCnpj', 'params' => ['CNPJ' => 'CNPJ']],
        ];
    }

    public function getDataContrato()
    {
        return 'attribute';
    }

    public function beforeValidate()
    {
        // Alterações nos atributos
        return parent::beforeValidate();
    }

    public function beforeSave($insert)
    {
        if (!parent::beforeSave($insert)) {
            return false;
        }

        // Alterações nos atributos
        return true;
    }

    public function afterFind()
    {
        // Alterações nos atributos
        parent::afterFind();
    }
}