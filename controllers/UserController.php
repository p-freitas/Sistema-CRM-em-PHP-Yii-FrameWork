<?php

namespace app\controllers;

use app\models\search\UsuarioSearch;
use app\models\Usuario;
use webvimark\modules\UserManagement\models\forms\ChangeOwnPasswordForm;
use webvimark\modules\UserManagement\controllers\UserController as BaseUserController;
use webvimark\modules\UserManagement\models\UserVisitLog;
use webvimark\modules\UserManagement\UserManagementModule;
use Yii;
use yii\data\ActiveDataProvider;
use yii\helpers\ArrayHelper;
use yii\helpers\Json;
use yii\helpers\Url;
use yii\web\NotFoundHttpException;
use yii\web\Response;
use yii\web\UploadedFile;
use yii\widgets\ActiveForm;


class UserController extends BaseUserController
{
    public $modelClass = 'app\models\Usuario';
    public $modelSearchClass = 'app\models\search\UsuarioSearch';

    public $freeAccessActions = ['report-bug', 'muda-perfil'];

    public function actionChangeOwnEmail()
    {
        $model = new \yii\base\DynamicModel(['email_atual', 'novo_email', 'confirma_email']);
        $model
            ->addRule(['email_atual', 'novo_email', 'confirma_email'], 'string', ['max' => 255])
            ->addRule('confirma_email', 'required')
            ->addRule('novo_email', 'required')
            ->addRule('novo_email', 'email')
            ->addRule('confirma_email', 'email')
            ->addRule('confirma_email', 'compare', ['compareAttribute' => 'novo_email'])
            ->addRule('novo_email', 'compare', ['compareAttribute' => 'email_atual', 'operator' => '!=']);

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            $usuario = Usuario::getCurrentUser();
            $usuario->email = $model->novo_email;
            $usuario->email_confirmed = 0;
            if ($usuario->save()) {
                self::sendEmailConfirmEmail($usuario);
                Yii::$app->session->setFlash('success', 'Email alterado com sucesso. Favor verificar o email para confirmação.');
            } else
                Yii::$app->session->setFlash('error', 'O email não pôde ser alterado');

            return $this->redirect(Url::home());

        } else {
            $model->email_atual = Yii::$app->getUser()->identity->email;
            return $this->render('//user-management/auth/changeOwnEmail', [
                'model' => $model,
            ]);
        }
    }

    public function actionChangeFirstPassword()
    {
        $user = Usuario::getCurrentUser();

        $model = new ChangeOwnPasswordForm(['user' => $user]);
        $model->scenario = 'restoreViaEmail';


        if (Yii::$app->request->isAjax AND $model->load(Yii::$app->request->post())) {
            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
        }

        if ($model->load(Yii::$app->request->post()) AND $model->changePassword()) {
            Yii::$app->session->setFlash('success', 'Senha alterada com sucesso');
            return $this->redirect(Url::home());
        }

        return $this->render('//user-management/auth/changeOwnPasswordFirst', compact('model'));
    }

    public static function actionCheckFirstTime($user_id)
    {

        $logs = UserVisitLog::find()->where(['user_id' => $user_id])->all();

        if (empty($logs)) {
            Yii::$app->response->redirect(['user/change-first-password'])->send();
        }
    }

    public function actionConfirmaCadastro($token)
    {
        $user = self::findByConfirmationToken($token);

        if (!$user) {
            Yii::$app->session->setFlash('error', 'Token não encontrado ou expirado.');
        } else {
            $user->email_confirmed = 1;
            $user->status = Usuario::STATUS_ACTIVE;
            $user->removeConfirmationToken();
            $user->save(false);
            Yii::$app->session->setFlash('success', 'Cadastro finalizado. Você já pode acessar o sistema usando suas credenciais.');
        }

        return $this->redirect(['user-management/auth/login']);

    }

    public static function sendEmailCadastro($user)
    {
        return Yii::$app->mailer->compose('confirm-registration', ['user' => $user])
            ->setFrom('noreply@keepinformatica.com')
            ->setTo($user->email)
            ->setSubject('Confirmação de cadastro')
            ->send();
    }

    public static function sendEmailConfirmEmail(Usuario $usuario)
    {
        $usuario->generateConfirmationToken();
        $usuario->save(false);

        return Yii::$app->mailer->compose('//user-management/mail/emailConfirmationMail', ['user' => $usuario])
            ->setFrom(Yii::$app->getModule('user-management')->mailerOptions['from'])
            ->setTo($usuario->email)
            ->setSubject(UserManagementModule::t('front', 'E-mail confirmation for') . ' ' . Yii::$app->name)
            ->send();
    }

    public static function findByConfirmationToken($token)
    {
        $expire = Yii::$app->getModule('user-management')->confirmationTokenExpire;

        $parts = explode('_', $token);
        $timestamp = (int)end($parts);

        if ($timestamp + $expire < time()) {
            return null;
        }

        return Usuario::findOne([
            Usuario::tableName() . '.confirmation_token' => $token,
            Usuario::tableName() . '.status' => Usuario::STATUS_INACTIVE,
        ]);
    }

    public function actionReportBug()
    {
        if (!empty(Yii::$app->request->post())) {
            $mensagem = $_POST['report'];
            if (!empty($mensagem)) {
                Yii::$app->mailer->compose('report_bug', ['message' => $mensagem, 'user' => Usuario::getCurrentUser()])
                    ->setFrom('noreply@keepinformatica.com')
                    ->setTo('adm@keepinformatica.com')
                    ->setSubject('Error Report [Protocolos]')
                    ->send();

                Yii::$app->session->setFlash('success', 'Obrigado pelo feedback. Estaremos atendendo o quanto antes.');
            }
            return $this->redirect(Url::home());
        } else {
            return $this->renderPartial('//layouts/report');
        }
    }

    public function actionCreate()
    {
        $model = new Usuario(['scenario' => 'newUser']);

        if (!Yii::$app->user->isSuperAdmin)
            $model->fk_entidade = Yii::$app->user->entidade;

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            foreach ($model->role as $role) {
                Usuario::assignRole($model->id, $role);
            }

            return $this->redirect(['index']);
        }

        return $this->renderIsAjax('create', compact('model'));
    }

    public function actionUpdate($id)
    {
        $model = Usuario::find()->entidadeFilter()->lotacaoFilter()->where([Usuario::tableName() . '.id' => $id])->one();

        if (!empty($model)) {
            if ($this->scenarioOnUpdate) {
                $model->scenario = $this->scenarioOnUpdate;
            }

            if ($model->load(Yii::$app->request->post()) AND $model->save()) {
                $prevRoles = $model->getRoles()->all();
                $model->role = array_combine($model->role, $model->role);

                foreach ($prevRoles as $prevRole) {
                    if (!ArrayHelper::keyExists($prevRole->name, $model->role))
                        Usuario::revokeRole($model->id, $prevRole->name);
                    else
                        unset($model->role[$prevRole->name]);
                }

                foreach ($model->role as $role) {
                    Usuario::assignRole($model->id, $role);
                }

                return $this->redirect(['index']);
            }

            return $this->renderIsAjax('update', compact('model'));
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

    public function actionBuscaAjax($q = null, $id = null)
    {
        \Yii::$app->response->format = Response::FORMAT_JSON;
        $out = ['results' => ['id' => '', 'text' => '']];
        if (!is_null($q)) {
            $data = Usuario::find()->select([Usuario::tableName() . '.id', Usuario::tableName() . ".nome_completo AS text"])->where(['like', Usuario::tableName() . '.nome_completo', $q])->entidadeFilter()->asArray()->all();
            $out['results'] = array_values($data);
        } elseif ($id > 0) {
            $usuario = Usuario::findOne([Usuario::tableName() . '.id' => $id]);
            $out['results'] = ['id' => $id, 'text' => $usuario->nome_completo];
        }
        return $out;
    }


    public function actionMudaPerfil()
    {
        $model = Usuario::findOne([Usuario::tableName() . '.id' => Yii::$app->user->id]);

        if (Yii::$app->request->isPost && $model->load(Yii::$app->request->post())) {
            $imagem = UploadedFile::getInstance($model, 'foto');

            if (!is_null($imagem)) {
                $s3 = Yii::$app->get('s3');

                if (!is_null($model->foto_url)) {
                    $nomeArquivo = explode('/', $model->foto_url)[7];
                    if ($s3->exist('crm/images/perfis/' . $nomeArquivo))
                        $s3->delete('crm/images/perfis/' . $nomeArquivo);
                }
                $saved = false;
                while (!$saved) {
                    $nome = rand(0, 9999999);
                    $exist = $s3->exist('crm/images/perfis/' . $nome . '.' . $imagem->extension);

                    if (!$exist) {
                        $result = $s3->upload('crm/images/perfis/' . $nome . '.' . $imagem->extension, $imagem->tempName);
                        $model->foto_url = $result->get('ObjectURL');
                        $saved = true;
                    }
                }

            }
            if ($model->save())
                Yii::$app->session->setFlash('success', 'Perfil alterado com sucesso');
            else
                Yii::$app->session->setFlash('error', 'Houve erro na alteração de perfil');


            return $this->redirect(Yii::$app->request->referrer ?: Yii::$app->homeUrl);
        } else {
            return $this->renderIsAjax('//user-management/user/perfil', compact('model'));
        }
    }

    public function actionIndex()
    {
        $searchModel = new UsuarioSearch();

        return $this->render('//user-management/user/index', [
            'searchModel' => $searchModel,
            'dataProvider' => $searchModel->search(Yii::$app->request->getQueryParams())
        ]);
    }
}