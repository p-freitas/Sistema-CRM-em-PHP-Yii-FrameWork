<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "telefone".
 *
 * @property int $id
 * @property int $fk_contato_cliente
 * @property int $fk_tipo_telefone
 * @property string $telefone
 *
 * @property ContatoCliente $fkContatoCliente
 * @property TipoTelefone $fkTipoTelefone
 */
class Telefone extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'telefone';
    }

    /**
     * {@inheritdoc}
     */

    public $contato_index;

    public function rules()
    {
        return [
            [['telefone', 'fk_contato_cliente', 'fk_tipo_telefone'], 'required', 'enableClientValidation' => false],
            [['fk_contato_cliente', 'fk_tipo_telefone', 'contato_index'], 'integer'],
            [['telefone'], 'string', 'max' => 20],
            [['fk_contato_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => ContatoCliente::className(), 'targetAttribute' => ['fk_contato_cliente' => 'id']],
            [['fk_tipo_telefone'], 'exist', 'skipOnError' => true, 'targetClass' => TipoTelefone::className(), 'targetAttribute' => ['fk_tipo_telefone' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_contato_cliente' => 'Contato Cliente',
            'fk_tipo_telefone' => 'Tipo Telefone',
            'telefone' => 'Telefone',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkContatoCliente()
    {
        return $this->hasOne(ContatoCliente::className(), ['id' => 'fk_contato_cliente']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkTipoTelefone()
    {
        return $this->hasOne(TipoTelefone::className(), ['id' => 'fk_tipo_telefone']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\TelefoneQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\TelefoneQuery(get_called_class());
    }

    public function beforeValidate()
    {
        $this->telefone = Yii::$app->formatter->removeCharactersNonNumeric($this->telefone);
        return parent::beforeValidate();
    }

    public function afterFind()
    {

        if (!empty($this->telefone))
            $this->telefone = Yii::$app->formatter->asPhoneDDD($this->telefone);

    }
}
