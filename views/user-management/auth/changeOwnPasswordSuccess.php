<?php

use webvimark\modules\UserManagement\UserManagementModule;

/**
 * @var yii\web\View $this
 */

$this->title = UserManagementModule::t('back', 'Change own password');
$this->params['breadcrumbs'][] = $this->title;
?>

<div class="login-box-2">
    <div class="white-box">
        <div class="change-own-password-success">
            <div class="alert alert-success text-center">
                <?= UserManagementModule::t('back', 'Password has been changed') ?>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="text-center"><a href="<?= \yii\helpers\Url::to(['/user-management/auth']) ?>" class="btn btn-default">Voltar
                            a página inicial</a></div>
                </div>
            </div>
        </div>
    </div>
</div>
