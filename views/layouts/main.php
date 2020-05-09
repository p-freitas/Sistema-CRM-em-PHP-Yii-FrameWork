<?php

use yii\helpers\Html;

/* @var $this \yii\web\View */
/* @var $content string */
$usuario = Yii::$app->user->identity;
app\assets\AppAsset::register($this);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?= Html::csrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <link rel="shortcut icon" href="<?= \yii\helpers\Url::to('@web') ?>/favicon.ico"/>
    <?php $this->head() ?>
</head>
<body class="fix-header fix-sidebar">
<?php $this->beginBody() ?>
<div class="preloader">
    <div class="cssload-speeding-wheel"></div>
</div>
<div id="wrapper">
    <?= $this->render(
        'header.php', [
            'usuario' => $usuario
        ]
    ) ?>
    <?= $this->render(
        'left.php', [
            'usuario' => $usuario
        ]
    )
    ?>
    <div id="page-wrapper">
        <div class="container-fluid">
            <?= $this->render(
                'content.php',
                ['content' => $content]
            ) ?>
        </div>
        <footer class="footer text-center"><strong>&copy; 2019
                :: <?= \yii\helpers\Html::img('@web/img/logo_keep.png', ['style' => '
            height: 30px;
            width: 30px;
            opacity: 0.75']); ?> Keep Informática Ltda</strong> :: TODOS OS DIREITOS RESERVADOS
        </footer>
    </div>
</div>
<?php $this->endBody() ?>
</body>
</html>
<?php $this->endPage() ?>

