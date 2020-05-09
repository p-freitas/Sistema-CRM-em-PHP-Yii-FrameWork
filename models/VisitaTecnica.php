<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "visita_tecnica".
 *
 * @property int $id
 * @property int $fk_usuario
 * @property int $fk_cliente
 * @property int $fk_produto
 * @property string $data
 * @property string $solicitante
 * @property string $agendamento
 * @property int $situacao
 * @property string $data_situacao
 * @property string $motivo
 * @property string $ocorrencias
 *
 * @property Cliente $fkCliente
 * @property Produto $fkProduto
 * @property Usuario $fkusuario
 * @property VisitatecProduto[] $visitatecProdutos
 */
class VisitaTecnica extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'visita_tecnica';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_usuario', 'fk_cliente', 'fk_produto', 'data', 'solicitante', 'situacao', 'motivo'], 'required'],
            [['fk_usuario', 'fk_cliente', 'fk_produto', 'situacao'], 'integer'],
            [['data', 'agendamento', 'data_situacao'], 'safe'],
            [['motivo', 'ocorrencias'], 'string'],
            [['solicitante'], 'string', 'max' => 50],
            [['fk_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_cliente' => 'id']],
            [['fk_produto'], 'exist', 'skipOnError' => true, 'targetClass' => Produto::className(), 'targetAttribute' => ['fk_produto' => 'id']],
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
            'fk_usuario' => 'Fk Usuario',
            'fk_cliente' => 'Fk Cliente',
            'fk_produto' => 'Fk Produto',
            'data' => 'Data',
            'solicitante' => 'Solicitante',
            'agendamento' => 'Agendamento',
            'situacao' => 'Situacao',
            'data_situacao' => 'Data Situacao',
            'motivo' => 'Motivo',
            'ocorrencias' => 'Ocorrencias',
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
    public function getFkProduto()
    {
        return $this->hasOne(Produto::className(), ['id' => 'fk_produto']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkUsuario()
    {
        return $this->hasOne(Usuario::className(), ['id' => 'fk_usuario']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getVisitatecProdutos()
    {
        return $this->hasMany(VisitatecProduto::className(), ['fk_visita' => 'id']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\VisitaTecnicaQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\VisitaTecnicaQuery(get_called_class());
    }
}
