<?php

use webvimark\modules\UserManagement\models\User;
use webvimark\modules\UserManagement\UserManagementModule;
use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use webvimark\extensions\BootstrapSwitch\BootstrapSwitch;
use kartik\file\FileInput;

/**
 * @var yii\web\View $this
 * @var \app\models\Usuario $model
 * @var yii\bootstrap\ActiveForm $form
 */
?>

    <div class="user-form">

        <?php $form = ActiveForm::begin([
            'id' => 'user',

            'validateOnBlur' => false,
        ]); ?>

    <div class="col-md-12 tab-content" role="tabpanel">
        <div role="tabpanel" align="center">
            <div class="col-md-2">
                <div class="row">
                    <div class="col-md-12 m-b-5">
                        <img onclick="openFileInput()" src="<?= !empty($model->foto_url) ? $model->foto_url : \yii\helpers\Url::to('@web/themes/eliteadmin/plugins/images/users/blank-user.jpg', true) ?>" alt="cliente" id="img-cliente" title="Clique para alterar" style="max-width: 100%">
                    </div>
                </div>

                <div class="col-md-12 m-b-5">
                    <?= $form->field($model, 'foto_url')->widget(FileInput::classname(), [
                        'options' => ['accept' => 'image/*'],
                        'language' => 'pt',
                        'pluginOptions' => [
                            'showUpload' => false,
                            'showPreview' => false,
                            'showRemove' => true,
                            'browseLabel' => '',
                            'removeLabel' => '',
                            'initialCaption' => empty($model->foto_url) ? '' : explode('/',$model->foto_url)[7],
                        ],
                    ])->label("") ?>
                </div>
            </div>
        </div>

        <div class="row">

            <div class="col-md-2">
                <?= $form->field($model->loadDefaultValues(), 'status')
                    ->dropDownList(User::getStatusList()) ?>
            </div>

            <div class="col-md-3">
            <?php if (Yii::$app->user->isSuperadmin): ?>
                <?= $form->field($model, 'fk_entidade')->widget(\kartik\select2\Select2::classname(), [
                    'theme' => 'bootstrap',
                    'language' => 'pt-BR',
                    'options' => ['placeholder' => 'Selecione uma entidade'],
                    'value' => $model->fk_entidade,
                    'initValueText' => empty($model->fk_entidade) ? '' : $model->fkEntidade->razao_social,
                    'pluginOptions' => [
                        'allowClear' => true,
                        'minimumInputLength' => 3,
                        'ajax' => [
                            'url' => \yii\helpers\Url::to(['//entidade/busca-ajax']),
                            'dataType' => 'json',
                            'data' => new \yii\web\JsExpression('function(params) { return {q:params.term}; }')
                        ],
                    ],
                ]) ?>
            <?php endif ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'username')->textInput(['maxlength' => 255, 'autocomplete' => 'off']) ?>
            </div>

            <div class="col-md-9">
                <?= $form->field($model, 'nome_completo')->textInput(['maxlength' => 100, 'autocomplete' => 'off']) ?>
            </div>

            <div>
                <?php if ($model->isNewRecord): ?>
                    <div class="col-md-5">
                    <?= $form->field($model, 'password')->passwordInput(['maxlength' => 255, 'autocomplete' => 'off']) ?>
                    </div>

                    <div class="col-md-4">
                    <?= $form->field($model, 'repeat_password')->passwordInput(['maxlength' => 255, 'autocomplete' => 'off']) ?>
                    </div>
                <?php endif; ?>
            </div>
        </div>

        <div>
            <div class="col-md-8">
                <?= $form->field($model, 'email')->textInput(['maxlength' => 255]) ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'email_confirmed')->radioList([0 => 'Não', 1 => 'Sim'], ['item' => function ($index, $label, $name, $checked, $value) {
                    $checked = $checked === true ? 'checked' : '';
                    return '<div class="radio">' . "<input type='radio' name='{$name}' value='{$value}' {$checked}>" . "<label>{$label}</label>" . "</div>";
                }]) ?>
            </div>
        </div>

        <div class="row">
            <?php if (Yii::$app->user->isSuperadmin): ?>
                <?php $model->isNewRecord == 1 ? $model->superadmin = 0 : $model->superadmin; ?>
                <?= $form->field($model, 'superadmin')->radioList([0 => 'Não', 1 => 'Sim'], ['item' => function ($index, $label, $name, $checked, $value) {
                    $checked = $checked === true ? 'checked' : '';
                    return '<div class="radio">' . "<input type='radio' name='{$name}' value='{$value}' {$checked}>" . "<label>{$label}</label>" . "</div>";
                }]) ?>
            <?php endif; ?>

            <?php if ($model->isNewRecord == 0): $model->role = $model->getRoles()->all(); endif; ?>
            <?= $form->field($model, 'role')->checkboxList(\yii\helpers\ArrayHelper::map(\webvimark\modules\UserManagement\models\rbacDB\Role::find()->asArray()->all(), 'name', 'description'), ['item' => function ($index, $label, $name, $checked, $value) {
                $checked = $checked === true ? 'checked' : '';
                return '<div class="checkbox">' . "<input type='checkbox' name='{$name}' value='{$value}' {$checked}>" . "<label>{$label}</label>" . "</div>";
            }])->label('Função') ?>

            <div class="form-group">
                <div class="col-sm-offset-5 col-sm-9">
                    <?php if ($model->isNewRecord): ?>
                        <?= Html::submitButton(
                            '<span class="glyphicon glyphicon-plus-sign"></span> ' . UserManagementModule::t('back', 'Create'),
                            ['class' => 'btn btn-success']
                        ) ?>
                    <?php else: ?>
                        <?= Html::submitButton(
                            '<span class="glyphicon glyphicon-ok"></span> ' . UserManagementModule::t('back', 'Save'),
                            ['class' => 'btn btn-primary']
                        ) ?>
                    <?php endif; ?>
                </div>
            </div>
        </div>



        <?php ActiveForm::end(); ?>
    </div>
    </div>

<?php BootstrapSwitch::widget() ?>