<?php

namespace app\models;

use Yii;
use app\behaviors\RelationDeleteBehavior;

/**
 * This is the model class for table "tipo_telefone".
 *
 * @property int $id
 * @property int $fk_entidade
 * @property string $descricao
 *
 * @property Telefone[] $telefones
 * @property Entidade $fkEntidade
 */
class TipoTelefone extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'tipo_telefone';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['telefones']
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
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getTelefones()
    {
        return $this->hasMany(Telefone::className(), ['fk_tipo_telefone' => 'id']);
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
     * @return \app\models\query\TipoTelefoneQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\TipoTelefoneQuery(get_called_class());
    }
}
