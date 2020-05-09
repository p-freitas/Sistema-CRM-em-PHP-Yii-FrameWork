<?php

namespace app\models;

use app\behaviors\RelationDeleteBehavior;
use Yii;

/**
 * This is the model class for table "atendimento_anexos".
 *
 * @property int $id
 * @property int $fk_atendimento
 * @property string $anexo
 * @property string $descricao
 */
class AtendimentoAnexos extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'atendimento_anexos';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['atendimentoAnexos']
            ],
        ]);
    }

    public $url;

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
           // [['anexo'], 'required'],
            //[['url'], 'required'],
            [['url'], 'file'],
           // [['anexo'], 'file', 'maxFiles' => 6],
            [['fk_atendimento'], 'integer'],
            [['anexo'], 'string', 'max' => 255],
            [['descricao'], 'string', 'max' => 20],
            [['fk_atendimento'], 'exist', 'skipOnError' => true, 'targetClass' => Atendimento::className(), 'targetAttribute' => ['fk_atendimento' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_atendimento' => 'Fk Atendimento',
            'anexo' => 'Anexo',
            'descricao' => 'Descricao',
        ];
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\AtendimentoAnexosQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\AtendimentoAnexosQuery(get_called_class());
    }
}
