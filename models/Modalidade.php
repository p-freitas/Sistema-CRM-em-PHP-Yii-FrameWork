<?php

namespace app\models;

use Yii;
use app\behaviors\RelationDeleteBehavior;

/**
 * This is the model class for table "modalidade".
 *
 * @property int $id
 * @property string $descricao
 *
 * @property Contrato[] $contratos
 */
class Modalidade extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'modalidade';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['contratos']
            ],
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['descricao'], 'required'],
            [['descricao'], 'string', 'max' => 50],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'descricao' => 'Descrição',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getContratos()
    {
        return $this->hasMany(Contrato::className(), ['fk_modalidade' => 'id']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\ModalidadeQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\ModalidadeQuery(get_called_class());
    }
}
