<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "tipo_documento".
 *
 * @property int $id
 * @property string $tipo
 * @property string $descricao
 *
 * @property Financeiro[] $financeiros
 */
class TipoDocumento extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'tipo_documento';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['tipo', 'descricao'], 'required'],
            [['tipo'], 'string', 'max' => 3],
            [['descricao'], 'string', 'max' => 20],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'tipo' => 'Tipo',
            'descricao' => 'Descricao',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFinanceiros()
    {
        return $this->hasMany(Financeiro::className(), ['fk_tipo_documento' => 'id']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\TipoDocumentoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\TipoDocumentoQuery(get_called_class());
    }
}
