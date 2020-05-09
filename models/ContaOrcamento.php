<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "conta_orcamento".
 *
 * @property int $id
 * @property int $fk_entidade
 * @property string $numero
 * @property string $codigo
 * @property string $descricao
 * @property string $tipo
 * @property string $tipo_lancamento
 *
 * @property Entidade $fkEntidade
 * @property Financeiro[] $financeiros
 */
class ContaOrcamento extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'conta_orcamento';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_entidade', 'numero', 'codigo', 'descricao', 'tipo', 'tipo_lancamento'], 'required'],
            [['fk_entidade'], 'integer'],
            [['numero', 'codigo'], 'string', 'max' => 20],
            [['descricao'], 'string', 'max' => 45],
            [['tipo', 'tipo_lancamento'], 'string', 'max' => 1],
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
            'numero' => 'Numero',
            'codigo' => 'Codigo',
            'descricao' => 'Descricao',
            'tipo' => 'Tipo',
            'tipo_lancamento' => 'Tipo Lancamento',
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
    public function getFinanceiros()
    {
        return $this->hasMany(Financeiro::className(), ['fk_conta_orcamento' => 'id']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\ContaOrcamentoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\ContaOrcamentoQuery(get_called_class());
    }
}
