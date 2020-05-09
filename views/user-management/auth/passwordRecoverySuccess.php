<?php

use webvimark\modules\UserManagement\UserManagementModule;

/**
 * @var yii\web\View $this
 */

$this->title = UserManagementModule::t('front', 'Password recovery');
$this->params['breadcrumbs'][] = $this->title;
?>

<div class="login-box">
    <div class="login-box-body">
        <div class="password-recovery-success">
            <div class="row">
                <div class="col-md-12">
                    <div class="alert alert-success text-center">
                        <?= UserManagementModule::t('front', 'Check your E-mail for further instructions') ?>
                    </div>
                </div>
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

