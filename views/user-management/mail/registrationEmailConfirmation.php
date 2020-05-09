<?php
/**
 * @var $this yii\web\View
 * @var $user webvimark\modules\UserManagement\models\User
 */
use yii\helpers\Html;

?>
<?php
$returnUrl = Yii::$app->user->returnUrl == Yii::$app->homeUrl ? null : rtrim(Yii::$app->homeUrl, '/') . Yii::$app->user->returnUrl;

$confirmLink = Yii::$app->urlManager->createAbsoluteUrl(['/auth/confirm-registration-email', 'token' => $user->confirmation_token, 'returnUrl'=>$returnUrl]);
$usuario = \app\models\Usuario::findOne([\app\models\Usuario::tableName().'.id' => $user->id]);
?>

Olá, <?=explode(' ', $usuario->nome_completo)[0]?><br>Você se registrou no sistema de Protocolos.

<br/><br/>
Siga o link para validar seu usuário e email:

<?= Html::a('Confirmar cadastro', $confirmLink) ?>