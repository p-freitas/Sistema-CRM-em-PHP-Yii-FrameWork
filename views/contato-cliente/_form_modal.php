<?php

use kartik\select2\Select2;
use yii\helpers\Html;
use yii\web\View;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\ContatoCliente */
/* @var $form yii\widgets\ActiveForm */


?>

<div id="ajax-content-departamento">

    <?php $form = ActiveForm::begin(['id' => 'form-contato']); ?>
    <div class="modal-body">
        <div class="row">
             <div class="col-md-4">
                <?= $form->field($model, 'fk_cliente')->widget(\kartik\select2\Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione', 'id' => 'cliente-contato'],
                'pluginOptions' => ['allowClear' => true],
                'data' => \app\modules\Helper::map(\app\models\Cliente::find()->findClienteByEntidade()->andFilterWhere(['like', 'fk_tipo_cliente', '2'])->orderBy([\app\models\Cliente::tableName() . '.razao_social' => SORT_ASC])->asArray()->all(), 'id', 'razao_social')
            ])->label('Cliente') ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'nome')->textInput()->label('Nome') ?>
            </div>



            <div class="col-md-4">
                <?= $form->field($model, 'email')->textInput()->label('Email') ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'fk_departamento')->widget(\kartik\select2\Select2::className(), [
                    'theme' => 'bootstrap',
                    'language' => 'pt-BR',
                    'data' => \app\modules\Helper::map(\app\models\Departamento::find()->asArray()->all(), 'id', 'descricao'),
                    'options' => ['placeholder' => 'Selecione'],
                    'pluginOptions' => [
                        'allowClear' => true,
                    ],
                ])->label('Departamento') ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'fk_cargo')->widget(\kartik\select2\Select2::className(), [
                    'theme' => 'bootstrap',
                    'language' => 'pt-BR',
                    'data' => \app\modules\Helper::map(\app\models\Cargo::find()->asArray()->all(), 'id', 'descricao'),
                    'options' => ['placeholder' => 'Cargo'],
                    'pluginOptions' => [
                        'allowClear' => true,
                    ]
                ])->label('Cargo') ?>
            </div>
        </div>

    </div>
    <div class="modal-footer">
        <?php \demogorgorn\ajax\AjaxSubmitButton::begin([
            'label' => 'Criar',
            'useWithActiveForm' => 'form-contato', //id do form_modal
            'ajaxOptions' => [
                'type' => 'POST',
                'data' => new \yii\web\JsExpression('new FormData($("#form-contato")[0])'),
                'processData' => false,
                'contentType' => false,
                'url' => \yii\helpers\Url::to(['//contato-cliente/create-modal']),
                'beforeSend' => new \yii\web\JsExpression('function(){$(".preloader").fadeIn();}'),
                'success' => new \yii\web\JsExpression('
                                function(data){
                                    var retorno = JSON.parse(data); 
                                    if(retorno.status == 200){
                                        $.toast({
                                            heading: \'Salvo com sucesso\',
                                            text: \'Contato: \'+retorno.text,
                                            position: \'top-right\',
                                            loaderBg:\'#ff6849\',
                                            icon: \'success\',
                                            hideAfter: 10000, 
                                        });
                                        
                                        $("#contato-cliente").append("<option value=\'"+retorno.id+"\'>"+retorno.text+"</option>").val(retorno.id).trigger("change");
                                        
                                        $("#form-contato input, #form-contato select, #form-contato textarea").val(\'\').trigger("change");
                                        $("#form-contato")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#modal-add-contato").modal("hide");
                                    }else{ 
                                        $("#ajax-content-contato").html(retorno.content);
                                        
                                    }
                                    $(".preloader").fadeOut();
                                }'
                ),
            ],
            'options' => ['class' => 'btn btn-primary', 'type' => 'submit'],
        ]);
        \demogorgorn\ajax\AjaxSubmitButton::end();
        ?>
        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
    </div>
    <?php ActiveForm::end(); ?>
</div>