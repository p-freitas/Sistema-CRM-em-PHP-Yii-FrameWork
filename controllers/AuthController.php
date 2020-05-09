<?php

namespace app\controllers;

use app\models\Entidade;
use app\models\forms\CustomRegistrationForm;
use app\models\Secretaria;
use app\models\Usuario;
use webvimark\modules\UserManagement\components\UserAuthEvent;
use webvimark\modules\UserManagement\controllers\AuthController as BaseAuthController;
use app\models\forms\CustomLoginForm;
use webvimark\modules\UserManagement\models\forms\ConfirmEmailForm;
use webvimark\modules\UserManagement\UserManagementModule;
use Yii;
use yii\helpers\Url;
use yii\web\NotFoundHttpException;
use yii\web\Response;
use yii\widgets\ActiveForm;

class AuthController extends BaseAuthController
{
    public $freeAccessActions = ['login', 'logout', 'confirm-registration-email', 'password-recovery'];

    public function actions()
    {
        return [
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'minLength' => 3,
                'maxLength' => 4,
                'offset' => 5
            ],
            'addressSearch' => 'yiibr\correios\CepAction'
        ];
    }

    /**
     * Login form
     *
     * @return string | array
     */
    public function actionLogin()
    {
        if (!Yii::$app->user->isGuest) {
            return $this->redirect(Yii::$app->defaultRoute);
        }

        $model = new CustomLoginForm();

        if (Yii::$app->request->isAjax AND $model->load(Yii::$app->request->post())) {
            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
        }

        if ($model->load(Yii::$app->request->post()) AND $model->login()) {
            return $this->redirect(['//site/index']);
        }

        return $this->renderIsAjax('login', compact('model'));
    }

    public function actionLogout()
    {
        Yii::$app->user->logout();

        return $this->redirect(Url::to(['//user-management/auth/login']));
    }

    public function actionConfirmEmail()
    {
        if (Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $user = Usuario::getCurrentUser();

        if ($user->email_confirmed == 1) {
            return $this->renderIsAjax('//user-management/auth/confirmEmailSuccess', compact('user'));
        }

        $model = new ConfirmEmailForm([
            'email' => $user->email,
            'user' => $user,
        ]);

        if (Yii::$app->request->isAjax AND $model->load(Yii::$app->request->post())) {
            Yii::$app->response->format = Response::FORMAT_JSON;
            return ActiveForm::validate($model);
        }

        if ($model->load(Yii::$app->request->post()) AND $model->validate()) {
            if ($this->triggerModuleEvent(UserAuthEvent::BEFORE_EMAIL_CONFIRMATION_REQUEST, ['model' => $model])) {
                $user->email = $model->email;
                if (UserController::sendEmailConfirmEmail($user)) {
                    if ($this->triggerModuleEvent(UserAuthEvent::AFTER_EMAIL_CONFIRMATION_REQUEST, ['model' => $model])) {
                        return $this->refresh();
                    }
                } else {
                    Yii::$app->session->setFlash('error', UserManagementModule::t('front', "Unable to send message for email provided"));
                }
            }
        }

        return $this->renderIsAjax('//user-management/auth/confirmEmail', compact('model'));
    }

    /**
     * Registration logic
     *
     * @return string
     */
   

    public function actionConfirmRegistrationEmail($token)
    {
        $model = new CustomRegistrationForm();

        $user = $model->checkConfirmationToken($token);

        if ($user) {
            return $this->renderIsAjax('//user-management/auth/confirmEmailSuccess', compact('user'));
        }

        throw new NotFoundHttpException(UserManagementModule::t('front', 'Token not found. It may be expired'));
    }
}
