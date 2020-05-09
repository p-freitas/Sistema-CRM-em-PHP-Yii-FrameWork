<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "aditivo".
 *
 * @property int $id
 * @property int $fk_contrato
 * @property string $numero
 * @property string $data_inicio
 * @property string $data_termino
 * @property string $valor
 * @property string $justificativa
 * @property string $anexo
 *
 * @property Contrato $fkContrato
 */
class Aditivo extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'aditivo';
    }

    /**
     * {@inheritdoc}
     */

    public $id_edit_aditivo;

    public function rules()
    {
        return [
            [['fk_contrato', 'numero', 'data_inicio', 'data_termino', 'valor', 'justificativa'], 'required'],
            [['fk_contrato', 'id_edit_aditivo'], 'integer'],
            [['data_inicio', 'data_termino'], 'safe'],
            [['valor'],  'number', 'numberPattern' => '/^\$?(([1-9](\d*|\d{0,2}(.\d{3})*))|0)(\,\d{1,2})?$/'],
            [['justificativa'], 'string'],
            [['numero'], 'string', 'max' => 20],
            [['anexo'], 'string', 'max' => 255],
            [['fk_contrato'], 'exist', 'skipOnError' => true, 'targetClass' => Contrato::className(), 'targetAttribute' => ['fk_contrato' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_contrato' => 'Contrato',
            'numero' => 'Número',
            'data_inicio' => 'Data Início',
            'data_termino' => 'Data Término',
            'valor' => 'Valor',
            'justificativa' => 'Justificativa',
            'anexo' => 'Anexo',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkContrato()
    {
        return $this->hasOne(Contrato::className(), ['id' => 'fk_contrato']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\AditivoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\AditivoQuery(get_called_class());
    }
}
