<?php

namespace app\models;

use Yii;
use app\behaviors\RelationDeleteBehavior;

/**
 * This is the model class for table "tipo_anexo".
 *
 * @property int $id
 * @property int $fk_entidade
 * @property string $descricao
 * @property AnexosDocumentos[] $anexosDocumentos
 * @property Entidade $fkEntidade
 */
class TipoAnexo extends \app\models\MainModel
{
    public $tipo_anexo;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'tipo_anexo';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['anexosDocumentos']
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
    public function getAnexosDocumentos()
    {
        return $this->hasMany(AnexosDocumentos::className(), ['fk_tipo_documento' => 'id']);
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
     * @return \app\models\query\TipoAnexoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\TipoAnexoQuery(get_called_class());
    }
}
