<?php
/**
 * @var $this yii\web\View
 * @var $user webvimark\modules\UserManagement\models\User
 */
use yii\helpers\Html;

?>
<?php
$resetLink = Yii::$app->urlManager->createAbsoluteUrl(['/user-management/auth/confirm-email-receive', 'token' => $user->confirmation_token]);
$usuario = \app\models\Usuario::findOne([\app\models\Usuario::tableName().'.id' => $user->id]);
?>

Olá, <?= Html::encode(explode(' ', $usuario->nome_completo)[0]) ?>,<br>
<?= Html::a('Clique aqui para validar o seu email', $resetLink) ?>