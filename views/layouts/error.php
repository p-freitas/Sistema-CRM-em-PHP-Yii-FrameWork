<?php

use yii\helpers\Html;

/* @var $this \yii\web\View */
/* @var $content string */

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
<body>
<?php $this->beginBody() ?>
<section id="wrapper" class="error-page">
    <div class="error-box">
        <?= $this->render('content-error.php',
            ['content' => $content]
        ) ?>
    </div>
</section>
<?php $this->endBody() ?>
</body>
</html>
<?php $this->endPage() ?>
