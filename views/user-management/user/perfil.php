<?php

use webvimark\modules\UserManagement\models\User;
use webvimark\modules\UserManagement\UserManagementModule;
use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use webvimark\extensions\BootstrapSwitch\BootstrapSwitch;

/**
 * @var yii\web\View $this
 * @var \app\models\Usuario $model
 * @var yii\bootstrap\ActiveForm $form
 */
?>

<?php $form = ActiveForm::begin([
    'id' => 'user',
    'layout' => 'horizontal',
    'action' => \yii\helpers\Url::to(['user/muda-perfil'])
]); ?>

    <div class="modal-body">
        <?= $form->field($model, 'nome_completo')->textInput(['maxlength' => 100, 'autocomplete' => 'off'])->label('Nome completo') ?>

        <?= $form->field($model, 'foto')->widget(\kartik\file\FileInput::classname(), [
            'options' => ['accept' => 'image/*'],
            'language' => 'pt',
            'pluginOptions' => [
                'showUpload' => false,
                'showRemove' => false,
                'browseLabel' => '',
                'removeLabel' => '',
                'initialPreview' => [
                    empty($model->foto) ? \yii\helpers\Url::to('@web/themes/eliteadmin/plugins/images/users/blank-user.jpg', true) : $model->foto
                ],
                'maxFileSize'=>1024,
                'initialPreviewAsData' => true,
                'allowedFileExtensions' => ['jpg', 'gif', 'png', 'jpeg'],
            ],
        ])->label('Foto') ?>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
        <button type="submit" class="btn btn-primary">Salvar</button>
    </div>

<?php ActiveForm::end(); ?>