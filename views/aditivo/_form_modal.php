<?php
/**
 * Created by PhpStorm.
 * User: Luan
 * Date: 18/10/2018
 * Time: 10:40
 */

use yii\helpers\Html;
use yii\widgets\ActiveForm;

?>

<div id="ajax-content-aditivo">

    <?php $form = ActiveForm::begin(['id' => 'aditivo-form']); ?>
    <div class="modal-body">
        <div class="row">
            <div class="col-md-12">
                <?= $form->field($model, 'fk_contrato', ['options' => ['tag' => false]])->hiddenInput(['id' => 'id_contrato'])->label(false) ?>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <?= $form->field($model, 'numero')->textInput(['maxlength' => true]) ?>
            </div>
            <div class="col-md-6">
                <?= $form->field($model, 'valor')->textInput(['maxlength' => true]) ?>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <?= $form->field($model, 'data_inicio')->widget(\kartik\daterange\DateRangePicker::className(), [
                    'pluginOptions' => [
                        'language'=>'pt-br',
                        'singleDatePicker' => true,
                        'locale'=>['format' => 'DD/MM/YYYY'],
                        'showDropdowns' => true
                    ]
                ])->widget(\yii\widgets\MaskedInput::className(), [
                    'clientOptions' => [
                        'alias' => 'date',
                        'clearIncomplete' => true,
                        'placeholder' => '__/__/____'
                    ],

                ]) ?>
            </div>
            <div class="col-md-6">
                <?= $form->field($model, 'data_termino')->widget(\kartik\daterange\DateRangePicker::className(), [
                    'pluginOptions' => [
                        'language'=>'pt-br',
                        'singleDatePicker' => true,
                        'locale'=>['format' => 'DD/MM/YYYY'],
                        'showDropdowns' => true
                    ]
                ])->widget(\yii\widgets\MaskedInput::className(), [
                    'clientOptions' => [
                        'alias' => 'date',
                        'clearIncomplete' => true,
                        'placeholder' => '__/__/____'
                    ],

                ]) ?>
            </div>
        </div>

        <div class="row">
            <div clasl="col-md-12">
                <?= $form->field($model, 'justificativa')->textarea(['rows' => 3]) ?>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <?= $form->field($model, 'anexo')->widget(\kartik\file\FileInput::classname(), [
                    'options' => ['accept' => '*'],
                    'language' => 'pt',
                    'pluginOptions' => [
                        'showUpload' => false,
                        'showPreview' => false,
                        'showRemove' => true,
                        'browseLabel' => '',
                        'removeLabel' => '',
                        'initialCaption' => empty($model->anexo) ? '' : explode('/',$model->anexo)[7],
                    ],
                ]) ?>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <?php \demogorgorn\ajax\AjaxSubmitButton::begin([
            'label' => 'Salvar',
            'useWithActiveForm' => 'aditivo-form', //id do form_modal
            'ajaxOptions' => [
                'type' => 'POST',
                'data' => new \yii\web\JsExpression('new FormData($("#aditivo-form")[0])'),
                'processData' => false,
                'contentType' => false,
                'url' => \yii\helpers\Url::to(['//aditivo/create-modal']),
                'beforeSend' => new \yii\web\JsExpression('function(){$(".preloader").fadeIn();}'),
                'success' => new \yii\web\JsExpression('
                                function(data){
                                    var retorno = JSON.parse(data); 
                                    if(retorno.status == 200){
                                        $.toast({
                                            heading: \'Salvo com sucesso\',
                                            text: \'Aditivo: \'+retorno.text,
                                            position: \'top-right\',
                                            loaderBg:\'#ff6849\',
                                            icon: \'success\',
                                            hideAfter: 10000, 
                                        });
                                        
                                    }
                                    else 
                                        $.toast({
                                            heading: \'Já existe um aditivo ativo neste contrato\',
                                            text: \' \'+retorno.text,
                                            position: \'top-right\',
                                            loaderBg:\'#ff0000\',
                                            icon: \'error\',
                                            hideAfter: 10000, 
                                        });
                                        $("#aditivo-form input, #aditivo-form select, #aditivo-form textarea").val(\'\').trigger("change");
                                        $("#aditivo-form")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#aditivo-modal").modal("hide"); 
                                        
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