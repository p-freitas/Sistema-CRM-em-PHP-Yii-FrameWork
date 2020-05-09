<?php

namespace app\models;

use DateTime;
use Illuminate\Support\Facades\Date;
use Yii;
use app\behaviors\RelationDeleteBehavior;

/**
 * This is the model class for table "atendimento".
 *
 * @property int $id
 * @property int $fk_cliente
 * @property int $fk_contato_cliente
 * @property int $fk_usuario
 * @property int $fk_usuario_solucao
 * @property int $fk_usuario_cancelamento
 * @property int $fk_atendimento_cancelado
 * @property int $fk_contrato
 * @property int $fk_produto
 * @property int $fk_tipo_atendimento
 * @property int $fk_tipo_ocorrencia
 * @property string $data_atendimento
 * @property int $status
 * @property string $solicitacao
 * @property string $motivo
 * @property string $solucao
 * @property string $data_solucao
 * @property string $data_cancelamento
 * @property string $data_prevista
 * @property string $numero_atendimento
 *
 * @property Cliente $fkCliente
 * @property ContatoCliente $fkContatoCliente
 * @property Contrato $fkContrato
 * @property Produto $fkProduto
 * @property TipoAtendimento $fkTipoAtendimento
 * @property TipoOcorrencia $fkTipoOcorrencia
 * @property Usuario $fkUsuario
 * @property Usuario $fkUsuarioSolucao
 * @property Usuario $fkUsuarioCancelamento
 * @property AtendimentoAnexos[] $AtendimentoAnexos
 * @property AtendimentoAnexos[] $atendimentoAnexos
 * @property ContratoProdutos[] $contratoProdutos
 * @property TipoOcorrencia[] $tipoOcorrencia
 *
 */
class Atendimento extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */

    public static $statusDesc = [
        1 => "Concluído",
        0 => "Pendente",
        2 => "Cancelado"
    ];

    public static function tableName()
    {
        return 'atendimento';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['atendimentoAnexos', 'contratoProdutos']
            ],
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_cliente', 'solicitacao', 'fk_tipo_atendimento', 'fk_tipo_ocorrencia'], 'required'],
            [['solucao'], 'required', 'when' => function () {
                return $this->solucao != null;
            }],
            /* [['data_prevista'], 'default', 'value' => function(){
                        $data_prevista = $this->data_prevista;
                        $prazo = $this->fkTipoOcorrencia->prazo;
                        $str = (string)$prazo;
                        $data_atendimento = $this->data_atendimento;
                        $data_atendimento = explode("/", $data_atendimento);

                        return $data_prevista = \date('d/m/Y', strtotime($data_prevista . '+ ' . $prazo . ' days'));
                       // return ($this->data_prevista = date('d/m/Y', strtotime("+" . $prazo . " days", strtotime($data_atendimento))));
            }
            ], */
            [['fk_cliente', 'fk_contato_cliente', 'fk_usuario', 'fk_usuario_solucao', 'fk_contrato', 'fk_produto', 'fk_tipo_atendimento', 'fk_tipo_ocorrencia'], 'integer'],
            [['data_atendimento', 'data_solucao'], 'safe'],
            [['data_atendimento', 'data_solucao'], 'datetime'],
            [['solicitacao', 'solucao'], 'string'],
            [['solucao'], 'string', 'min' => 5],
            [['motivo'], 'string', 'min' => 5],
            [['status'], 'default', 'value' => 0],
            [['fk_usuario'], 'default', 'value' => Yii::$app->getUser()->id],
            [['fk_usuario_solucao'], 'default', 'value' => Yii::$app->getUser()->id, 'when' => function () {
                return ($this->solucao != null);
            }],
            [['fk_usuario_cancelamento'], 'default', 'value' => Yii::$app->getUser()->id, 'when' => function () {
                return ($this->motivo != null);
            }],
            [['data_atendimento'], 'default', 'value' => date('d/m/Y H:i:s')],
            [['data_solucao'], 'default', 'value' => date('d/m/Y H:i:s'), 'when' => function () {
                return ($this->solucao != null);
            }],
            [['data_cancelamento'], 'default', 'value' => date('d/m/Y H:i:s'), 'when' => function () {
                return ($this->motivo != null);
            }],
            [['numero_atendimento'], 'default', 'value' => function () {
                return (intval(Atendimento::find()->count()) + 1) . '/' . date('Y');
            }],
            [['fk_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_cliente' => 'id']],
            [['fk_contato_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => ContatoCliente::className(), 'targetAttribute' => ['fk_contato_cliente' => 'id']],
            [['fk_contrato'], 'exist', 'skipOnError' => true, 'targetClass' => Contrato::className(), 'targetAttribute' => ['fk_contrato' => 'id']],
            [['fk_produto'], 'exist', 'skipOnError' => true, 'targetClass' => Produto::className(), 'targetAttribute' => ['fk_produto' => 'id']],
            [['fk_tipo_atendimento'], 'exist', 'skipOnError' => true, 'targetClass' => TipoAtendimento::className(), 'targetAttribute' => ['fk_tipo_atendimento' => 'id']],
            [['fk_tipo_ocorrencia'], 'exist', 'skipOnError' => true, 'targetClass' => TipoOcorrencia::className(), 'targetAttribute' => ['fk_tipo_ocorrencia' => 'id']],
            [['fk_usuario'], 'exist', 'skipOnError' => true, 'targetClass' => Usuario::className(), 'targetAttribute' => ['fk_usuario' => 'id']],
            [['fk_usuario_solucao'], 'exist', 'skipOnError' => true, 'targetClass' => Usuario::className(), 'targetAttribute' => ['fk_usuario_solucao' => 'id']],
            [['fk_usuario_cancelamento'], 'exist', 'skipOnError' => true, 'targetClass' => Usuario::className(), 'targetAttribute' => ['fk_usuario_cancelamento' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_cliente' => 'Fk Cliente',
            'fk_contato_cliente' => 'Fk Contato Cliente',
            'fk_usuario' => 'Fk Usuario',
            'fk_usuario_solucao' => 'Fk Usuario Solucao',
            'fk_usuario_cancelamento' => 'Fk Usuario Cancelamento',
            'fk_contrato' => 'Fk Contrato',
            'fk_produto' => 'Fk Produto',
            'fk_tipo_atendimento' => 'Fk Tipo Atendimento',
            'fk_tipo_ocorrencia' => 'Fk Tipo Ocorrencia',
            'data_atendimento' => 'Data Atendimento',
            'status' => 'Status',
            'solicitacao' => 'Solicitacao',
            'solucao' => 'Solucao',
            'motivo' => 'Motivo',
            'data_solucao' => 'Data da Solucao',
            'numero_atendimento' => 'Numero Atendimento',
        ];
    }

    /*public function beforeValidate()
    {
        if (!empty($this->data_solucao) ){
            $this->data_solucao.= ':00';
        }
        return parent::beforeValidate(); // TODO: Change the autogenerated stub
    }
    */
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
    public function getFkContatoCliente()
    {
        return $this->hasOne(ContatoCliente::className(), ['id' => 'fk_contato_cliente']);
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
    public function getAtendimentoAnexos()
    {
        return $this->hasMany(AtendimentoAnexos::className(), ['fk_atendimento' => 'id']);
    }

    public function getContratoProdutos()
    {
        return $this->hasMany(ContratoProdutos::className(), ['fk_contrato' => 'id']);
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
    public function getFkTipoAtendimento()
    {
        return $this->hasOne(TipoAtendimento::className(), ['id' => 'fk_tipo_atendimento']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkTipoOcorrencia()
    {
        return $this->hasOne(TipoOcorrencia::className(), ['id' => 'fk_tipo_ocorrencia']);
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
    public function getFkUsuarioSolucao()
    {
        return $this->hasOne(Usuario::className(), ['id' => 'fk_usuario_solucao']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkUsuarioCancelamento()
    {
        return $this->hasOne(Usuario::className(), ['id' => 'fk_usuario_cancelamento']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\AtendimentoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\AtendimentoQuery(get_called_class());
    }
}
