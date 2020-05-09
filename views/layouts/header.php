<?php

use yii\helpers\Html;

/* @var $this \yii\web\View */
/* @var $content string */

$entidade = \app\models\Entidade::findOne([\app\models\Entidade::tableName() . '.id' => Yii::$app->user->entidade]);
$title = Yii::$app->user->isSuperadmin ? 'CRM' : $entidade->nome_fantasia;
$logo = empty($entidade->logo_marca) ? \yii\helpers\Url::to('@web/themes/eliteadmin', true) . '/plugins/images/eliteadmin-logo.png' : $entidade->logo_marca;
?>

<nav class="navbar navbar-default navbar-static-top m-b-0">
    <div class="navbar-header">
        <div class="top-left-part">
            <div class="text-center">
                <a href="#modal-perfil" data-toggle="modal"
                   style="font-size: 14px; text-transform: none; padding: 3px 20px; vertical-align: middle">
                    <img src="<?= empty($usuario->foto_url) ? \yii\helpers\Url::to('@web/themes/eliteadmin/plugins/images/users/blank-user.jpg', true) : $usuario->foto ?>"
                         alt="user-img" width="58" class="img-circle" style="padding: 10px">Meu perfil
                </a>
            </div>
        </div>

        <ul class="nav navbar-top-links navbar-left hidden-xs" style="padding: 3px">
            <li style="color: white">
                <b>
                    <img src="<?= $logo ?>" alt="home" class="light-logo logotipo">
                </b>
                <span class="hidden-xs" style="text-transform: uppercase; font-size: 18px; vertical-align: middle">
                    <?= $title ?>
                </span>
            </li>
        </ul>

        <ul class="nav navbar-top-links navbar-right pull-right">
            <li class="dropdown">
                <a class="dropdown-toggle waves-effect waves-light" data-toggle="dropdown">
                    <?= !empty($usuario->nome_completo) ? explode(' ', $usuario->nome_completo)[0] : $usuario->username ?></a>
                <ul class="dropdown-menu">
                    <li><a href="#modal-report" data-toggle="modal">Reportar Erro</a></li>
                    <li class="divider"></li>
                    <li><?= Html::a('Sair', ['/auth/logout'], ['data-method' => 'post']) ?></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
