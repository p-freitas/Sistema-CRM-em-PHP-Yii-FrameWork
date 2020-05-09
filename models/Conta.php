<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "conta".
 *
 * @property int $id
 * @property int $fk_banco
 * @property string $numero
 * @property string $agencia
 * @property string $descricao
 *
 * @property Banco $fkBanco
 * @property Financeiro[] $financeiros
 */
class Conta extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'conta';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_banco', 'numero', 'agencia', 'descricao'], 'required'],
            [['fk_banco'], 'integer'],
            [['numero', 'agencia'], 'string', 'max' => 20],
            [['descricao'], 'string', 'max' => 30],
            [['fk_banco'], 'exist', 'skipOnError' => true, 'targetClass' => Banco::className(), 'targetAttribute' => ['fk_banco' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_banco' => 'Fk Banco',
            'numero' => 'Numero',
            'agencia' => 'Agencia',
            'descricao' => 'Descricao',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkBanco()
    {
        return $this->hasOne(Banco::className(), ['id' => 'fk_banco']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFinanceiros()
    {
        return $this->hasMany(Financeiro::className(), ['fk_conta' => 'id']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\ContaQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\ContaQuery(get_called_class());
    }
}
