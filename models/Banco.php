<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "banco".
 *
 * @property int $id
 * @property int $fk_entidade
 * @property int $codigo
 * @property string $descricao
 *
 * @property Entidade $fkEntidade
 * @property Conta[] $contas
 * @property Financeiro[] $financeiros
 */
class Banco extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'banco';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_entidade', 'codigo', 'descricao'], 'required'],
            [['fk_entidade', 'codigo'], 'integer'],
            [['descricao'], 'string', 'max' => 30],
            [['fk_entidade'], 'exist', 'skipOnError' => true, 'targetClass' => Entidade::className(), 'targetAttribute' => ['fk_entidade' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_entidade' => 'Fk Entidade',
            'codigo' => 'Codigo',
            'descricao' => 'Descricao',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkEntidade()
    {
        return $this->hasOne(Entidade::className(), ['id' => 'fk_entidade']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getContas()
    {
        return $this->hasMany(Conta::className(), ['fk_banco' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFinanceiros()
    {
        return $this->hasMany(Financeiro::className(), ['fk_banco_portador' => 'id']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\BancoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\BancoQuery(get_called_class());
    }
}
