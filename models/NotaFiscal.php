<?php

namespace app\models;

use Yii;
use app\behaviors\RelationDeleteBehavior;

/**
 * This is the model class for table "nota_fiscal".
 *
 * @property int $id
 * @property int $fk_cliente
 * @property int $fk_usuario
 * @property string $numero_nota
 * @property string $data_emissao
 * @property string $competencia
 * @property string $descricao_servico
 * @property string $valor
 * @property string $aliquota_iss
 * @property string $valor_iss
 * @property string $condicao_pagamento
 * @property string $info_complementar
 * @property string $rastreamento
 * @property string $data_entrega
 * @property int $situacao
 *
 * @property Financeiro[] $financeiros
 * @property Cliente $fkCliente
 * @property Usuario $fkUsuario
 */
class NotaFiscal extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static $descStatus = [
        1 => "Ativo",
        0 => "Inativo"
    ];

    public static function tableName()
    {
        return 'nota_fiscal';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['financeiros']
            ],
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_cliente', 'fk_usuario', 'numero_nota', 'data_emissao', 'competencia', 'descricao_servico', 'valor', 'aliquota_iss', 'valor_iss'], 'required'],
            [['fk_cliente', 'fk_usuario', 'situacao', 'numero_nota'], 'integer'],
            [['data_emissao', 'competencia', 'data_entrega'], 'safe'],
            [['descricao_servico'], 'string'],
            [['situacao'], 'default', 'value' => 1],
            [['valor', 'aliquota_iss', 'valor_iss'], 'number', 'numberPattern' => '/^\d+(.\d{1,2})?$/'],
            [['numero_nota', 'rastreamento'], 'string', 'max' => 20],
            [['condicao_pagamento'], 'string', 'max' => 50],
            [['info_complementar'], 'string', 'max' => 255],
            [['fk_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_cliente' => 'id']],
            [['fk_usuario'], 'exist', 'skipOnError' => true, 'targetClass' => Usuario::className(), 'targetAttribute' => ['fk_usuario' => 'id']],
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
            'fk_usuario' => 'Fk Usuario',
            'numero_nota' => 'Numero Nota',
            'data_emissao' => 'Data Emissao',
            'competencia' => 'Competencia',
            'descricao_servico' => 'Descricao Servico',
            'valor' => 'Valor',
            'aliquota_iss' => 'Aliquota Iss',
            'valor_iss' => 'Valor Iss',
            'condicao_pagamento' => 'Condicao Pagamento',
            'info_complementar' => 'Info Complementar',
            'rastreamento' => 'Rastreamento',
            'data_entrega' => 'Data Entrega',
            'situacao' => 'Situacao',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFinanceiros()
    {
        return $this->hasMany(Financeiro::className(), ['fk_nota_fiscal' => 'id']);
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
    public function getFkUsuario()
    {
        return $this->hasOne(Usuario::className(), ['id' => 'fk_usuario']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\NotaFiscalQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\NotaFiscalQuery(get_called_class());
    }
}
