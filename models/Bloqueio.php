<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "bloqueio".
 *
 * @property int $id
 * @property int $fk_cliente
 * @property int $fk_contrato
 * @property int $fk_usuario
 * @property string $data_bloqueio
 * @property string $data_limite
 * @property int $status
 *
 * @property Cliente $fkCliente
 * @property Contrato $fkContrato
 * @property User $fkUsuario
 * @property BloqueioProduto[] $bloqueioProdutos
 */
class Bloqueio extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'bloqueio';
    }

    /**
     * {@inheritdoc}
     */

    public $bloqueio_id;

    public function rules()
    {
        return [
            [['fk_cliente'], 'required'],
            ['fk_usuario', 'default', 'value' => Yii::$app->user->id],
            [['fk_cliente', 'fk_contrato', 'fk_usuario', 'status', 'bloqueio_id'], 'integer'],
            ['data_bloqueio', 'default', 'value' => date("d/m/Y")],
            [['status'], 'default', 'value' => 1],
            [['data_bloqueio', 'data_limite'], 'safe'],
            [['fk_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_cliente' => 'id']],
            [['fk_contrato'], 'exist', 'skipOnError' => true, 'targetClass' => Contrato::className(), 'targetAttribute' => ['fk_contrato' => 'id']],
            [['fk_usuario'], 'exist', 'skipOnError' => true, 'targetClass' => Usuario::className(), 'targetAttribute' => ['fk_usuario' => 'id']],
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
            'fk_contrato' => 'Contrato',
            'fk_usuario' => 'Usuario',
            'data_bloqueio' => 'Data Bloqueio',
            'data_limite' => 'Data Limite',
            'status' => 'Status',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBloqueioProdutos()
    {
        return $this->hasMany(BloqueioProduto::className(), ['fk_bloqueio' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkCliente()
    {
        return $this->hasOne(Cliente::className(), ['id' => 'fk_cliente']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkContrato()
    {
        return $this->hasOne(Contrato::className(), ['id' => 'fk_contrato']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkUsuario()
    {
        return $this->hasOne(Usuario::className(), ['id' => 'fk_usuario']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\BloqueioQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\BloqueioQuery(get_called_class());
    }
}
