<?php

namespace app\models;

use Yii;
use app\behaviors\RelationDeleteBehavior;
use app\components\CustomFormatter;
use rafaelrabaco\validator\CnpjValidator;
use yii\web\UploadedFile;

/**
 * This is the model class for table "entidade".
 *
 * @property int $id
 * @property string $cnpj
 * @property string $razao_social
 * @property string $nome_fantasia
 * @property string $insc_municipal
 * @property string $logo_marca
 * @property string $cep
 * @property string $estado
 * @property string $cidade
 * @property string $bairro
 * @property string $endereco
 * @property string $complemento
 *
 * @property Cliente[] $clientes
 * @property Produto[] $produtos
 * @property User[] $users
 */
class Entidade extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'entidade';
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            [
                'class' => RelationDeleteBehavior::className(),
                'relations' => ['clientes', 'produtos', 'users']
            ],
        ]);
    }

    public $logo_marca;

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['cnpj', 'razao_social', 'nome_fantasia', 'insc_municipal', 'cep', 'estado', 'cidade', 'bairro', 'endereco'], 'required'],
            [['cnpj'], 'string', 'max' => 18],
            [['cnpj'], CnpjValidator::className()],
            [['razao_social'], 'string', 'max' => 200],
            [['nome_fantasia', 'complemento'], 'string', 'max' => 100],
            [['insc_municipal'], 'string', 'max' => 30],
            [['logo_marca', 'endereco'], 'string', 'max' => 255],
            [['cep'], 'string', 'max' => 9],
            [['estado', 'cidade', 'bairro'], 'string', 'max' => 50],
            [['logo_marca'], 'file', 'extensions' => 'jpg, gif, jpeg'],
            [['cnpj'], 'unique'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'cnpj' => 'Cnpj',
            'razao_social' => 'Razao Social',
            'nome_fantasia' => 'Nome Fantasia',
            'insc_municipal' => 'Insc Municipal',
            'logo_marca' => 'Logo Marca',
            'cep' => 'Cep',
            'estado' => 'Estado',
            'cidade' => 'Cidade',
            'bairro' => 'Bairro',
            'endereco' => 'Endereco',
            'complemento' => 'Complemento',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getClientes()
    {
        return $this->hasMany(Cliente::className(), ['fk_entidade' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProdutos()
    {
        return $this->hasMany(Produto::className(), ['fk_entidade' => 'id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getContaOrcamento()
    {
        return $this->hasMany(ContaOrcamento::className(), ['fk_entidade' => 'id']);
    }
    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUsers()
    {
        return $this->hasMany(User::className(), ['fk_entidade' => 'id']);
    }

     public function getUsuarios()
    {
        return $this->hasMany(Usuario::className(), ['fk_entidade' => 'id']);
    }

    public function beforeValidate()
    {
        $this->cnpj = CustomFormatter::removeCharactersNonNumeric($this->cnpj);

        return parent::beforeValidate();
    }

    public function afterFind()
    {
        $this->cnpj = Yii::$app->formatter->asCgc($this->cnpj);
        parent::afterFind();
    }

    /**
     * {@inheritdoc}
     * @return \app\query\models\EntidadeQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\EntidadeQuery(get_called_class());
    }
}
