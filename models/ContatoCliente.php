<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "contato_cliente".
 *
 * @property int $id
 * @property int $fk_cliente
 * @property int $fk_departamento
 * @property int $fk_cargo
 * @property string $nome
 * @property string $email
 * @property string $foto
 * @property int $situacao
 *
 * @property Atendimento[] $atendimentos
 * @property Cargo $fkCargo
 * @property Cliente $fkCliente
 * @property Departamento $fkDepartamento
 * @property OrcamentoProposta[] $orcamentoPropostas
 * @property Telefone[] $telefones
 */
class ContatoCliente extends \app\models\MainModel
{
    public $id_edit;
    public $departamento;
    public $cargo;

    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'contato_cliente';
    }


    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_departamento', 'fk_cargo', 'nome'], 'required', 'whenClient' => "function(){
                return $($('#corpo-contatos').find('tr').find('td')).length <= 1;
            }"],
            [['fk_cliente', 'id_edit'], 'integer'],
            [['nome', 'departamento', 'cargo'], 'string', 'max' => 100],
            [['situacao'], 'default', 'value' => 1],
            [['email'], 'email'],
            [['foto'], 'string', 'max' => 255],
            [['data_nascimento'], 'safe'],
            [['fk_cargo'], 'exist', 'skipOnError' => true, 'targetClass' => Cargo::className(), 'targetAttribute' => ['fk_cargo' => 'id']],
            [['fk_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_cliente' => 'id']],
            [['fk_departamento'], 'exist', 'skipOnError' => true, 'targetClass' => Departamento::className(), 'targetAttribute' => ['fk_departamento' => 'id']],
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
            'fk_departamento' => 'Departamento',
            'fk_cargo' => 'Cargo',
            'nome' => 'Nome',
            'data_nascimento' => 'Data Nascimento',
            'email' => 'Email',
            'foto' => 'Foto',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAtendimentos()
    {
        return $this->hasMany(Atendimento::className(), ['fk_contato_cliente' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkCargo()
    {
        return $this->hasOne(Cargo::className(), ['id' => 'fk_cargo']);
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
    public function getFkDepartamento()
    {
        return $this->hasOne(Departamento::className(), ['id' => 'fk_departamento']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOrcamentoPropostas()
    {
        return $this->hasMany(OrcamentoProposta::className(), ['fk_contato_cliente' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getTelefones()
    {
        return $this->hasMany(Telefone::className(), ['fk_contato_cliente' => 'id']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\ContatoClienteQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\ContatoClienteQuery(get_called_class());
    }


}
