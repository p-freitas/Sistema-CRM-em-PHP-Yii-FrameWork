<?php

namespace app\models;

use Yii;
use app\behaviors\RelationDeleteBehavior;

/**
 * This is the model class for table "tipo_orgao".
 *
 * @property int $id
 * @property int $fk_entidade
 * @property string $descricao
 * @property string $sigla
 *
 * @property Cliente[] $clientes
 * @property Entidade $fkEntidade
 */
class TipoOrgao extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'tipo_orgao';
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
            [['descricao'], 'required'],
            [['fk_entidade'], 'integer'],
            [['descricao'], 'string', 'max' => 50],
            [['sigla'], 'string', 'max' => 10],
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
            'sigla' => 'Sigla',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getClientes()
    {
        return $this->hasMany(Cliente::className(), ['fk_tipo_orgao' => 'id']);
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
     * @return \app\models\query\TipoOrgaoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\TipoOrgaoQuery(get_called_class());
    }
}
