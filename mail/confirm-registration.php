<?php
use yii\helpers\Html;
use yii\helpers\Url;

?>

<h1>Bem vindo(a) ao <?=Yii::$app->name?>,</h1>
<?= Html::a('Clique aqui para validar o seu cadastro e começar o uso do sistema', Url::to(['user/confirma-cadastro', 'token' => $user->confirmation_token], true)) ?>
<p>Seu dados de acesso são:</p>
<p><strong>Usuario:</strong> <?=$user->username?></p>
<p><strong>Senha:</strong> <?=$user->password?></p>
