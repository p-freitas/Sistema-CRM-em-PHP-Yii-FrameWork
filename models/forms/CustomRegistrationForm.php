<?php
/**
 * Created by PhpStorm.
 * User: wilton
 * Date: 26/10/17
 * Time: 16:24
 */

namespace app\models\forms;


use app\models\Cidade;
use app\models\Entidade;
use app\models\Estado;
use app\models\Requerente;
use app\models\Usuario;
use rafaelrabaco\validator\CnpjValidator;
use rafaelrabaco\validator\CpfValidator;
use webvimark\modules\UserManagement\models\forms\RegistrationForm;
use webvimark\modules\UserManagement\UserManagementModule;
use yii\helpers\ArrayHelper;
use yii\web\User;

class CustomRegistrationForm extends RegistrationForm
{
    public $email;
    public $tipo_doc;
    public $estado;
    public $cidade;
    public $numero;
    public $nome_razao;
    public $fk_entidade;
    public $fk_lotacao;
    public $telefone;
    public $cep;
    public $endereco;
    public $bairro;
    public $complemento;
    public $responsavel_requerente;

    public function rules()
    {
        return [
            ['captcha', 'captcha', 'captchaAction' => '/auth/captcha'],
            [['username', 'password', 'repeat_password', 'captcha', 'fk_entidade', 'nome_razao', 'cep', 'bairro', 'endereco', 'tipo_doc', 'email', 'captcha', 'estado', 'cidade', 'numero'], 'required'],

            [['username'], 'validaCpfCnpj', 'params' => ['attribute' => 'username']],
            ['username', 'unique', 'targetClass' => 'app\models\Usuario', 'targetAttribute' => ['username', 'fk_entidade'], 'message' => 'Este doc. de identificação já foi cadastrado para a entidade selecionada.'],
            ['username', 'purgeXSS'],

            [['responsavel_requerente'], 'required', 'when' => function ($model) {
                return ($model->tipo_doc === 'cnpj');
            }, 'whenClient' => "function (attribute, value) {
                return $('input[name=\"CustomRegistrationForm[tipo_doc]\"]:checked').val() == 'cnpj';
            }"],

            [['username', 'password', 'repeat_password'], 'trim'],

            [['email'], 'unique', 'targetClass' => 'app\models\Usuario', 'targetAttribute' => 'email'],

            ['password', 'string', 'max' => 255],
            ['repeat_password', 'compare', 'compareAttribute' => 'password'],

            [['fk_entidade'], 'exist', 'skipOnError' => true, 'targetClass' => Entidade::className(), 'targetAttribute' => ['fk_entidade' => 'id']],
            [['cep'], 'validaCep', 'params' => ['estado' => 'estado', 'cidade' => 'cidade']],
            [['username'], 'string', 'max' => 18],
            [['cep'], 'string', 'max' => 9],
            [['telefone'], 'string', 'max' => 20],
            [['nome_razao', 'endereco', 'bairro', 'complemento', 'email', 'responsavel_requerente', 'estado', 'cidade', 'numero'], 'string', 'max' => 100],
        ];
    }

    public function beforeValidate()
    {
        $this->username = \Yii::$app->formatter->removeCharactersNonNumeric($this->username);
        $this->cep = \Yii::$app->formatter->removeCharactersNonNumeric($this->cep);
        $this->telefone = \Yii::$app->formatter->removeCharactersNonNumeric($this->telefone);
        return parent::beforeValidate();
    }

    public function attributeLabels()
    {
        return [
            'username' => 'Doc. de identificação',
            'password' => UserManagementModule::t('front', 'Password'),
            'repeat_password' => UserManagementModule::t('front', 'Repeat password'),
            'captcha' => UserManagementModule::t('front', 'Captcha'),
            'fk_entidade' => \Yii::t('app', 'Entidade'),
            'tipo_doc' => \Yii::t('app', 'Tipo Doc'),
            'nome_razao' => \Yii::t('app', 'Nome Razao'),
            'endereco' => \Yii::t('app', 'Endereco'),
            'bairro' => \Yii::t('app', 'Bairro'),
            'cep' => \Yii::t('app', 'Cep'),
            'complemento' => \Yii::t('app', 'Complemento'),
            'email' => \Yii::t('app', 'Email'),
            'responsavel_requerente' => \Yii::t('app', 'Responsavel Requerente'),
            'telefone' => \Yii::t('app', 'Telefone'),
        ];
    }

    protected function saveProfile($user)
    {
        if (empty(Requerente::find()->where([Requerente::tableName() . '.cpf_cnpj' => $this->username])->one())) {
            $model = new Requerente();
            $model->cpf_cnpj = $this->username;
            $model->nome_razao = $this->nome_razao;
            $model->endereco = $this->endereco;
            $model->bairro = $this->bairro;
            $model->cep = $this->cep;
            $model->complemento = $this->complemento;
            $model->email = $this->email;
            $model->responsavel_requerente = $this->responsavel_requerente;
            $model->numero = $this->numero;
            $model->estado = $this->estado;
            $model->cidade = $this->cidade;
            $model->telefone = $this->telefone;
            $model->save(false);
        }
    }

    public function registerUser($performValidation = true)
    {
        if ($performValidation AND !$this->validate()) {
            return false;
        }

        $user = new Usuario();
        $user->password = $this->password;
        $user->username = $this->username;
        $user->fk_entidade = $this->fk_entidade;
        $user->fk_lotacao = $this->fk_lotacao;
        $user->nome_completo = $this->nome_razao;
        $user->email = $this->email;
        $user->status = Usuario::STATUS_INACTIVE;
        $user->generateConfirmationToken();
        $user->save(false);

        $this->saveProfile($user);

        if ($this->sendConfirmationEmail($user)) {
            return $user;
        } else {
            $this->addError('username', UserManagementModule::t('front', 'Could not send confirmation email'));
        }
    }

    public function validaCpfCnpj($attribute, $params)
    {
        $dado = $this->{$params['attribute']};
        if (strlen($dado) > 11) {
            $validator = new CnpjValidator();
        } else {
            $validator = new CpfValidator();
        }

        if ($validator->validate($dado)) {
            return true;
        } else {
            $this->addError($attribute, \Yii::t('app', 'invalid_cgc'));
            return false;
        }
    }

    public function validaCep($attribute, $params)
    {
        $estado_attribute = $this->{$params['estado']};
        $cidade_attribute = $this->{$params['cidade']};

        $estado = Estado::findOne([Estado::tableName() . '.uf' => $estado_attribute]);
        if (empty($estado)) {
            $this->addError($params['estado'], 'Estado inválido');
            return false;
        } else {
            $cidade = Cidade::findOne([Cidade::tableName() . '.fk_estado' => $estado->id, Cidade::tableName() . '.nome' => $cidade_attribute]);
            if (empty($cidade)) {
                $this->addError($params['cidade'], 'Esta cidade não está associada ao estado indicado ou não existe');
                return false;
            } else {
                return true;
            }
        }
    }

    protected function sendConfirmationEmail($user)
    {
        return \Yii::$app->mailer->compose('//user-management/mail/registrationEmailConfirmation', ['user' => $user])
            ->setFrom(\Yii::$app->getModule('user-management')->mailerOptions['from'])
            ->setTo($user->email)
            ->setSubject(UserManagementModule::t('front', 'E-mail confirmation for') . ' ' . \Yii::$app->name)
            ->send();
    }

    public function checkConfirmationToken($token)
    {
        $user = Usuario::findInactiveByConfirmationToken($token);

        if ($user) {
            $user->status = Usuario::STATUS_ACTIVE;
            $user->email_confirmed = 1;
            $user->removeConfirmationToken();
            $user->save(false);

            $roles = (array)\Yii::$app->getModule('user-management')->rolesAfterRegistration;

            foreach ($roles as $role) {
                Usuario::assignRole($user->id, $role);
            }

            \Yii::$app->user->login($user);
            return $user;
        }

        return false;
    }
}