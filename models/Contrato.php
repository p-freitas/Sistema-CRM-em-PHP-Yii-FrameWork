<?php

namespace app\models;

use Yii;
use app\behaviors\RelationDeleteBehavior;

/**
 * This is the model class for table "contrato".
 *
 * @property int $id
 * @property int $fk_cliente
 * @property int $fk_modalidade
 * @property string $data_inicio
 * @property string $data_termino
 * @property string $valor_global
 * @property string $valor_mensal
 * @property string $anexo
 * @property int $status
 * @property string $objeto
 * @property string $numero
 * @property string $info_complementar
 *
 * @property Aditivo[] $aditivos
 * @property Atendimento[] $atendimentos
 * @property Bloqueio[] $bloqueios
 * @property Cliente $fkCliente
 * @property Modalidade $fkModalidade
 * @property ContratoProdutos[] $contratoProdutos
 */
class Contrato extends \app\models\MainModel
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
        return 'contrato';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['aditivos', 'atendimentos', 'bloqueios', 'contratoProdutos']
            ],
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_cliente', 'fk_modalidade', 'data_inicio', 'data_termino', 'valor_global', 'valor_mensal', 'objeto', 'numero'], 'required'],
            [['fk_cliente', 'fk_modalidade', 'status'], 'integer'],
            [['status'], 'default', 'value' => 1],
            [['data_inicio', 'data_termino'], 'safe'],
           // [['valor_global', 'valor_mensal'], 'number', 'numberPattern' => '/^\s*[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?\s*$/'],
            //[['valor_global'], 'number', 'numberPattern' => '/^\s*[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?\s*$/', 'min' => '0,00'],
            [['anexo', 'objeto'], 'string', 'max' => 255],
            [['numero'], 'string', 'max' => 20],
            [['info_complementar'], 'string', 'max' => 100],
            [['fk_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_cliente' => 'id']],
            [['fk_modalidade'], 'exist', 'skipOnError' => true, 'targetClass' => Modalidade::className(), 'targetAttribute' => ['fk_modalidade' => 'id']],
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
            'fk_modalidade' => 'Fk Modalidade',
            'data_inicio' => 'Data Inicio',
            'data_termino' => 'Data Termino',
            'valor_global' => 'Valor Global',
            'valor_mensal' => 'Valor Mensal',
            'anexo' => 'Anexo',
            'status' => 'Status',
            'objeto' => 'Objeto',
            'numero' => 'Numero',
            'info_complementar' => 'Info Complementar',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAditivos()
    {
        return $this->hasMany(Aditivo::className(), ['fk_contrato' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAtendimentos()
    {
        return $this->hasMany(Atendimento::className(), ['fk_contrato' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBloqueios()
    {
        return $this->hasMany(Bloqueio::className(), ['fk_contrato' => 'id']);
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
    public function getFkModalidade()
    {
        return $this->hasOne(Modalidade::className(), ['id' => 'fk_modalidade']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getContratoProdutos()
    {
        return $this->hasMany(ContratoProdutos::className(), ['fk_contrato' => 'id']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\ContratoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\ContratoQuery(get_called_class());
    }
}
