<?php

namespace app\models;

use Yii;
use app\behaviors\RelationDeleteBehavior;

/**
 * This is the model class for table "tipo_cliente".
 *
 * @property int $id
 * @property int $fk_entidade
 * @property string $descricao
 * @property int $codigo
 *
 * @property Cliente[] $clientes
 * @property Entidade $fkEntidade
 */
class TipoCliente extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'tipo_cliente';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['clientes']
            ],
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            ['fk_entidade', 'required', 'when' => function(){return Yii::$app->user->isSuperadmin;}],
            ['fk_entidade', 'default', 'value' => Yii::$app->user->entidade, 'when' => function(){return !Yii::$app->user->isSuperadmin;}],
            [['descricao', 'codigo'], 'required'],
            [['fk_entidade', 'codigo'], 'integer'],
            [['descricao'], 'string', 'max' => 45],
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
            'fk_entidade' => 'Empresa',
            'descricao' => 'Descrição',
            'codigo' => 'Código',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getClientes()
    {
        return $this->hasMany(Cliente::className(), ['fk_tipo_cliente' => 'id']);
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
     * @return \app\models\query\TipoClienteQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\TipoClienteQuery(get_called_class());
    }
}
