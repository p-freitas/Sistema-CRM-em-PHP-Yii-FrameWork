<?php

namespace app\models;

use rafaelrabaco\validator\CnpjValidator;
use rafaelrabaco\validator\CpfValidator;
use Yii;
use app\behaviors\RelationDeleteBehavior;
use app\components\CustomFormatter;

/**
 * This is the model class for table "cliente".
 *
 * @property int $id
 * @property int $fk_entidade
 * @property int $fk_tipo_cliente
 * @property int $fk_tipo_orgao
 * @property int $fk_representante
 * @property string $cpf_cnpj
 * @property string $razao_social
 * @property string $nome_fantasia
 * @property string $email
 * @property string $brasao
 * @property string $cep
 * @property string $estado
 * @property string $cidade
 * @property string $bairro
 * @property string $endereco
 * @property string $complemento
 * @property int $numero
 * @property string $data_situacao
 * @property string $data_cadastro
 * @property int $situacao
 * @property int $qtd_populacao
 * @property int $qtd_eleitor
 * @property string $ano_populacao
 * @property string $fpm
 * @property string $fpm_ano
 *
 * @property AnexosDocumentos[] $anexosDocumentos
 * @property Atendimento[] $atendimentos
 * @property Bloqueio[] $bloqueios
 * @property Entidade $fkEntidade
 * @property Cliente $fkRepresentante
 * @property Cliente[] $clientes
 * @property TipoCliente $fkTipoCliente
 * @property TipoOrgao $fkTipoOrgao
 * @property ContatoCliente[] $contatoClientes
 * @property Contrato[] $contratos
 * @property Financeiro[] $financeiros
 * @property Gestao[] $gestaos
 * @property NotaFiscal[] $notaFiscals
 * @property OrcamentoProposta[] $orcamentoPropostas
 * @property VisitaTecnica[] $visitaTecnicas
 * @property TipoAnexo[] $fkTipoAnexo
 */

class Cliente extends \app\models\MainModel
{
    public static $descStatus = [
        1 => "Ativo",
        0 => "Inativo"
    ];

    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'cliente';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['anexosDocumentos', 'atendimentos', 'bloqueios', 'contatoClientes', 'contratos', 'financeiros', 'gestaos', 'notaFiscals', 'orcamentoPropostas', 'visitaTecnicas']
            ],
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_tipo_cliente', 'fk_tipo_orgao', 'cpf_cnpj', 'razao_social', 'nome_fantasia', 'cep', 'estado', 'cidade', 'bairro', 'endereco', 'numero'], 'required'],
            ['fk_entidade', 'required', 'when' => function () {
                return Yii::$app->user->isSuperadmin;
            }],
            ['fk_entidade', 'default', 'value' => Yii::$app->user->entidade, 'when' => function () {
                return !Yii::$app->user->isSuperadmin;
            }],
            [['situacao'], 'default', 'value' => 1],
            ['data_cadastro', 'default', 'value' => date("d/m/Y")],
            [['data_situacao', 'data_cadastro', 'fpm_ano'], 'safe'],
            [['fk_entidade', 'fk_tipo_cliente', 'fk_tipo_orgao', 'fk_representante', 'situacao', 'qtd_populacao', 'qtd_eleitor'], 'integer'],
            [['fpm'], 'number', 'numberPattern' => '/^\s*[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?\s*$/'],
            [['cpf_cnpj'], 'string', 'max' => 18],
            [['razao_social', 'nome_fantasia'], 'string', 'max' => 200],
            [['email', 'complemento'], 'string', 'max' => 100],
            [['cep'], 'string', 'max' => 9],
            [['ano_populacao'], 'safe'],
            [['estado', 'cidade', 'bairro'], 'string', 'max' => 50],
            [['endereco', 'brasao'], 'string', 'max' => 255],
            [['cpf_cnpj'], 'unique', 'targetAttribute' => ['cpf_cnpj', 'fk_entidade'], 'message' => 'Existe Contribuinte cadastrado com este CPF/CPNJ'],
            [['cpf_cnpj'], 'validaCpfCnpj', 'params' => ['attribute' => 'cpf_cnpj']],
            [['cpf_cnpj'], 'validaCpfEntidade','params' => ['attribute' => 'cpf_cnpj']],
            [['fk_entidade'], 'exist', 'skipOnError' => true, 'targetClass' => Entidade::className(), 'targetAttribute' => ['fk_entidade' => 'id']],
            [['fk_representante'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_representante' => 'id']],
            [['fk_tipo_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => TipoCliente::className(), 'targetAttribute' => ['fk_tipo_cliente' => 'id']],
            [['fk_tipo_orgao'], 'exist', 'skipOnError' => true, 'targetClass' => TipoOrgao::className(), 'targetAttribute' => ['fk_tipo_orgao' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_entidade' => 'Empresa',
            'fk_tipo_cliente' => 'Tipo Cliente',
            'fk_tipo_orgao' => 'Tipo Orgao',
            'fk_representante' => 'Representante',
            'cpf_cnpj' => 'Cpf/Cnpj',
            'razao_social' => 'Razão Social',
            'nome_fantasia' => 'Nome Fantasia',
            'email' => 'Email',
            'brasao' => 'Brasão',
            'cep' => 'Cep',
            'estado' => 'Estado',
            'cidade' => 'Cidade',
            'bairro' => 'Bairro',
            'endereco' => 'Endereco',
            'numero' => 'Número',
            'complemento' => 'Complemento',
            'data_situacao' => 'Data Situação',
            'data_cadastro' => 'Data Cadastro',
            'situacao' => 'Situação',
            'qtd_populacao' => 'Qtde. População',
            'qtd_eleitor' => 'Qtde. Eleitor',
            'ano_populacao' => 'Ano População',
            'fpm' => 'Índice FPM',
            'fpm_ano' => 'FPM Ano'
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAnexosDocumentos()
    {
        return $this->hasMany(AnexosDocumentos::className(), ['fk_cliente' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAtendimentos()
    {
        return $this->hasMany(Atendimento::className(), ['fk_cliente' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getBloqueios()
    {
        return $this->hasMany(Bloqueio::className(), ['fk_cliente' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkEntidade()
    {
        return $this->hasOne(Entidade::className(), ['id' => 'fk_entidade']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkRepresentante()
    {
        return $this->hasOne(Cliente::className(), ['id' => 'fk_representante']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getClientes()
    {
        return $this->hasMany(Cliente::className(), ['fk_representante' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkTipoCliente()
    {
        return $this->hasOne(TipoCliente::className(), ['id' => 'fk_tipo_cliente']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkTipoOrgao()
    {
        return $this->hasOne(TipoOrgao::className(), ['id' => 'fk_tipo_orgao']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getContatoClientes()
    {
        return $this->hasMany(ContatoCliente::className(), ['fk_cliente' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getContratos()
    {
        return $this->hasMany(Contrato::className(), ['fk_cliente' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFinanceiros()
    {
        return $this->hasMany(Financeiro::className(), ['fk_cliente' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getNotaFiscals()
    {
        return $this->hasMany(NotaFiscal::className(), ['fk_cliente' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOrcamentoPropostas()
    {
        return $this->hasMany(OrcamentoProposta::className(), ['fk_cliente' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getGestaos()
    {
        return $this->hasMany(Gestao::className(), ['fk_cliente' => 'id']);
    }


    /**
     * @return \yii\db\ActiveQuery
     */
    public function getVisitaTecnicas()
    {
        return $this->hasMany(VisitaTecnica::className(), ['fk_cliente' => 'id']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\ClienteQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\ClienteQuery(get_called_class());
    }

    public function beforeValidate()
    {
        $this->cpf_cnpj = Yii::$app->formatter->removeCharactersNonNumeric($this->cpf_cnpj);
        $this->cep = CustomFormatter::removeCharactersNonNumeric($this->cep);
        return parent::beforeValidate();
    }

    public function afterFind()
    {
        $this->cpf_cnpj = Yii::$app->formatter->asCgc($this->cpf_cnpj);
        $this->cep = Yii::$app->formatter->asCep($this->cep);
        parent::afterFind();
    }

    public function validaCpfEntidade(){
        if(!empty($this->cpf_cnpj)){

            if(Cliente::find()->where(['cpf_cnpj' => $this->cpf_cnpj])->andFilterWhere(['<>', 'id', $this->id])->exists())
                $this->addError('cpf_cnpj', 'CPF já cadastrado para esta entidade');


        }
    }
}
