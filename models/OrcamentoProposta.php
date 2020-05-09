<?php

namespace app\models;

use Yii;
use app\behaviors\RelationDeleteBehavior;

/**
 * This is the model class for table "orcamento_proposta".
 *
 * @property int $id
 * @property int $fk_cliente
 * @property int $fk_contato_cliente
 * @property string $implantacao_parcela
 * @property string $implantacao_valor
 * @property int $validade
 * @property string $obs
 * @property string $data
 *
 * @property ItensOrcamento[] $itensOrcamentos
 * @property Cliente $fkCliente
 * @property ContatoCliente $fkContatoCliente
 */
class OrcamentoProposta extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'orcamento_proposta';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['itensOrcamentos']
            ],
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_cliente', 'fk_contato_cliente', 'implantacao_parcela', 'implantacao_valor', 'validade', 'data'], 'required'],
            [['fk_cliente', 'fk_contato_cliente', 'validade'], 'integer'],
            [['implantacao_valor'], 'number', 'numberPattern' => '/^\d+(.\d{1,2})?$/'],
            [['obs'], 'string'],
            [['data'], 'safe'],
            [['implantacao_parcela'], 'string', 'max' => 20],
            [['fk_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_cliente' => 'id']],
            [['fk_contato_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => ContatoCliente::className(), 'targetAttribute' => ['fk_contato_cliente' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_cliente' => 'Fk Cliente',
            'fk_contato_cliente' => 'Fk Contato Cliente',
            'implantacao_parcela' => 'Implantacao Parcela',
            'implantacao_valor' => 'Implantacao Valor',
            'validade' => 'Validade',
            'obs' => 'Obs',
            'data' => 'Data',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getItensOrcamentos()
    {
        return $this->hasMany(ItensOrcamento::className(), ['fk_orcamento' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkCliente()
    {
        return $this->hasOne(Cliente::className(), ['id' => 'fk_cliente']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkContatoCliente()
    {
        return $this->hasOne(ContatoCliente::className(), ['id' => 'fk_contato_cliente']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\OrcamentoPropostaQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\OrcamentoPropostaQuery(get_called_class());
    }
}
