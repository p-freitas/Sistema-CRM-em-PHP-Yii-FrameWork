<?php

use webvimark\modules\UserManagement\UserManagementModule;

/**
 * @var yii\web\View $this
 * @var webvimark\modules\UserManagement\models\User $user
 */

$this->title = UserManagementModule::t('front', 'Registration - confirm your e-mail');
$this->params['breadcrumbs'][] = $this->title;
?>

<div class="login-box">
    <div class="white-box">
        <div class="registration-wait-for-confirmation">

            <div class="alert alert-info text-center">
                <?= UserManagementModule::t('front', 'Check your e-mail {email} for instructions to activate account', [
                    'email' => '<b>' . $user->email . '</b>'
                ]) ?>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="text-center"><a href="<?= \yii\helpers\Url::to(['/user-management/auth/login']) ?>" class="btn btn-default">Voltar
                            a página inicial</a></div>
                </div>
            </div>
        </div>
    </div>
</div>
