<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "tipo_atendimento".
 *
 * @property int $id
 * @property int $fk_entidade
 * @property string $descricao
 *
 * @property Atendimento[] $atendimentos
 * @property Entidade $fkEntidade
 */
class TipoAtendimento extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'tipo_atendimento';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_entidade', 'descricao'], 'required'],
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
            'fk_entidade' => 'Fk Entidade',
            'descricao' => 'Descricao',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAtendimentos()
    {
        return $this->hasMany(Atendimento::className(), ['fk_tipo_atendimento' => 'id']);
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
     * @return \app\models\query\TipoAtendimentoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\TipoAtendimentoQuery(get_called_class());
    }
}
