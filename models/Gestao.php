<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "gestao".
 *
 * @property int $id
 * @property int $fk_cliente
 * @property string $periodo
 * @property string $prefeito
 * @property string $data_nascimento
 * @property string $vice_prefeito
 *
 * @property Cliente $fkCliente
 */
class Gestao extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'gestao';
    }

    public $from;
    public $to;
    public $id_edit_gestao;
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_cliente', 'periodo', 'prefeito', 'vice_prefeito'], 'required', 'whenClient' => "function(){
                return ($('#cliente-fk_tipo_orgao').find('option:selected').text().toLowerCase() == 'prefeitura' && $('#cliente-fk_tipo_cliente').find('option:selected').text().toLowerCase() == 'cliente');
            }"],
            [['fk_cliente', 'id_edit_gestao'], 'integer'],
            [['data_nascimento', 'from', 'to'], 'safe'],
            [['periodo'], 'string'],
            [['prefeito', 'vice_prefeito'], 'string', 'max' => 200],
            [['fk_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_cliente' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_cliente' => 'Cliente',
            'periodo' => 'Período',
            'prefeito' => 'Prefeito',
            'data_nascimento' => 'Data Nascimento',
            'vice_prefeito' => 'Vice Prefeito',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkCliente()
    {
        return $this->hasOne(Cliente::className(), ['id' => 'fk_cliente']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\GestaoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\GestaoQuery(get_called_class());
    }
}
