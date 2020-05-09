<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "anexos_documentos".
 *
 * @property int $id
 * @property int $fk_tipo_documento
 * @property int $fk_cliente
 * @property string $anexo
 *
 * @property Cliente $fkCliente
 * @property TipoAnexo $fkTipoDocumento
 */
class AnexosDocumentos extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'anexos_documentos';
    }

    /**
     * {@inheritdoc}
     */

    public function rules()
    {
        return [
            [['fk_tipo_documento'], 'integer'],
            [['anexo'], 'string', 'max' => 255],
            [['fk_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_cliente' => 'id']],
            [['fk_tipo_documento'], 'exist', 'skipOnError' => true, 'targetClass' => TipoAnexo::className(), 'targetAttribute' => ['fk_tipo_documento' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_tipo_documento' => 'Fk Tipo Documento',
            'fk_cliente' => 'Fk Cliente',
            'anexo' => 'Anexos',
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
     * @return \yii\db\ActiveQuery
     */
    public function getFkTipoDocumento()
    {
        return $this->hasOne(TipoAnexo::className(), ['id' => 'fk_tipo_documento']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\AnexosDocumentosQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\AnexosDocumentosQuery(get_called_class());
    }
}
