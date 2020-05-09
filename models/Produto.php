<?php

namespace app\models;

use Yii;
use app\behaviors\RelationDeleteBehavior;

/**
 * This is the model class for table "produto".
 *
 * @property int $id
 * @property int $fk_entidade
 * @property string $codigo
 * @property string $descricao
 *
 * @property Atendimento[] $atendimentos
 * @property Bloqueio[] $bloqueios
 * @property ContratoProdutos[] $contratoProdutos
 * @property ControleVersao[] $controleVersaos
 * @property ItensOrcamento[] $itensOrcamentos
 * @property Entidade $fkEntidade
 */
class Produto extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'produto';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['atendimentos', 'bloqueios', 'contratoProdutos', 'controleVersaos', 'itensOrcamentos']
            ],
        ]);
    }

    /**
     * {@inheritdoc}
     */

    public $produtos_contrato;

    public function rules()
    {
        return [
            ['fk_entidade', 'required', 'when' => function () {
                return Yii::$app->user->isSuperadmin;
            }],
            ['fk_entidade', 'default', 'value' => Yii::$app->user->entidade, 'when' => function () {
                return !Yii::$app->user->isSuperadmin;
            }],
            [['codigo', 'descricao', 'produtos_contrato'], 'required'],
            ['produtos_contrato', 'each', 'rule' => ['exist', 'skipOnError' => true, 'targetClass' => ContratoProdutos::className(), 'targetAttribute' => ['produtos_contrato' => 'id']], 'except' => 'changePassword'],
            [['fk_entidade'], 'integer'],
            [['codigo'], 'string', 'max' => 20],
            [['descricao'], 'string', 'max' => 200],
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
            'codigo' => 'Código',
            'descricao' => 'Descricao',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAtendimentos()
    {
        return $this->hasMany(Atendimento::className(), ['fk_produto' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBloqueios()
    {
        return $this->hasMany(Bloqueio::className(), ['fk_produto' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getContratoProdutos()
    {
        return $this->hasMany(ContratoProdutos::className(), ['fk_produto' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getControleVersaos()
    {
        return $this->hasMany(ControleVersao::className(), ['fk_produto' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getItensOrcamentos()
    {
        return $this->hasMany(ItensOrcamento::className(), ['fk_produto' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkEntidade()
    {
        return $this->hasOne(Entidade::className(), ['id' => 'fk_entidade']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\ProdutoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\ProdutoQuery(get_called_class());
    }
}
