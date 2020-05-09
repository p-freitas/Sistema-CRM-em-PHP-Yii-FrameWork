<?php
/**
 * @var $this yii\web\View
 * @var $user webvimark\modules\UserManagement\models\User
 */
use yii\helpers\Html;

?>
<?php
$resetLink = Yii::$app->urlManager->createAbsoluteUrl(['/user-management/auth/password-recovery-receive', 'token' => $user->confirmation_token]);
$usuario = \app\models\Usuario::findOne([\app\models\Usuario::tableName().'.id' => $user->id]);
?>

    <h1>Bem vindo(a), <?= Html::encode(explode(' ', $usuario->nome_completo)[0]) ?></h1>

    Clique neste link para resetar sua senha:

<?= Html::a('Redefinir senha', $resetLink) ?>