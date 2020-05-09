<?php

use backend\assets\AppAsset;
use yii\helpers\Html;

/* @var $this \yii\web\View */
/* @var $content string */

dmstr\web\AdminLteAsset::register($this);
\app\assets\MainAsset::register($this);
\app\assets\InitCustomAsset::register($this);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?= Html::csrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
</head>
<body class="login-page">
<?php $this->beginBody() ?>
<div class="preloader">
    <div class="cssload-speeding-wheel"></div>
</div>
<section id="wrapper" class="login-register" style="overflow-y: auto">
    <?= $content ?>
    <footer class="main-login-footer" style="padding: 10px">
        <div class="text-center">
            <strong>&copy; 2018 :: <?= Html::img('@web/img/logo_keep.png', ['style' => '
            height: 30px;
            width: 30px;
            opacity: 0.75']); ?> Keep Informática Ltda</strong> :: TODOS OS DIREITOS RESERVADOS
        </div>
    </footer>
</section>
<?php $this->endBody() ?>
</body>
</html>
<?php $this->endPage() ?>
