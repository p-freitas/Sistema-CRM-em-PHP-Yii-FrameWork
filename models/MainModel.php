<?php

namespace app\models;

use app\behaviors\DbFormatBehavior;
use app\behaviors\LogBehavior;
use rafaelrabaco\validator\CnpjValidator;
use rafaelrabaco\validator\CpfValidator;
use yii\db\ActiveRecord;

class MainModel extends ActiveRecord
{
    public function behaviors()
    {
        return [
            LogBehavior::className(),
            DbFormatBehavior::className()
        ];
    }

    public function validaCpfCnpj($attribute, $params)
    {
        $dado = $this->{$params['attribute']};
        if (strlen($dado) > 11) {
            $validator = new CnpjValidator();
        } else {
            $validator = new CpfValidator();
        }

        if ($validator->validate($dado)) {
            return true;
        } else {
            $this->addError($attribute, \Yii::t('app', 'invalid_cgc'));
            return false;
        }
    }

    public function validaCep($attribute, $params)
    {
        $estado_attribute = $this->{$params['estado']};
        $cidade_attribute = $this->{$params['cidade']};

        $estado = Estado::findOne([Estado::tableName() . '.uf' => $estado_attribute]);
        if (empty($estado)) {
            $this->addError($attribute, 'Foram encontrados erros em um dos campos de endereço.');
            $this->addError($params['estado'], 'Estado inválido');
            return false;
        } else {
            $cidade = Cidade::findOne([Cidade::tableName() . '.fk_estado' => $estado->id, Cidade::tableName() . '.nome' => $cidade_attribute]);
            if (empty($cidade)) {
                $this->addError($attribute, 'Foram encontrados erros em um dos campos de endereço.');
                $this->addError($params['cidade'], 'Esta cidade não está associada ao estado indica ou não existe');
                return false;
            } else {
                return true;
            }
        }
    }
}