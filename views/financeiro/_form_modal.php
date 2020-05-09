<?php


use kartik\daterange\DateRangePicker;
use kartik\select2\Select2;
use yii\helpers\Html;
use yii\widgets\ActiveForm;
use app\models\Financeiro;


?>

<div id="ajax-content-aditivo">

    <?php $form = ActiveForm::begin(['id' => 'form-baixa']); ?>

    <div class="modal-body">
        <div class="row">
            <div class="col-md-12">
                <?= $form->field($model, 'id', ['options' => ['tag' => false]])->hiddenInput(['id' => 'id_baixa'])->label(false) ?>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4">
                <?= $form->field($model, 'valor_pgto')->widget(\yii\widgets\MaskedInput::className(), [
                    'clientOptions' => [
                        'alias' => 'decimal',
                        'digits' => 2,
                        'groupSeparator' => '.',
                        'radixPoint' => ',',
                        'autoGroup' => true
                    ],
                ]) ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'data_pgto')->widget(DateRangePicker::className(), [
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

                ])->label('Data do pagamento') ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'fk_conta')->widget(Select2::classname(), [
                    'theme' => 'bootstrap',
                    'language' => 'pt-BR',
                    'options' => ['placeholder' => 'Selecione'],
                    'pluginOptions' => ['allowClear'=>true],
                    'data' => \yii\helpers\ArrayHelper::map(\app\models\Conta::find()->asArray()->all(), 'id', 'descricao'),
                ])->label('Conta')?>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <?php

        \demogorgorn\ajax\AjaxSubmitButton::begin([
            'label' => 'Adicionar baixa',
            'useWithActiveForm' => 'form-baixa', //id do form_modal
            'ajaxOptions' => [
                'type' => 'POST',
                'data' => new \yii\web\JsExpression('new FormData($("#form-baixa")[0])'),
                'processData' => false,
                'contentType' => false,
                'url' => \yii\helpers\Url::to(['//financeiro/baixa']),
                'beforeSend' => new \yii\web\JsExpression('function(){$(".preloader").fadeIn();}'),
                'success' => new \yii\web\JsExpression('
                                function(data){
                                    var retorno = JSON.parse(data); 
                                    if(retorno.status == 200){
                                        $.toast({
                                            heading: \'Salvo com sucesso\',
                                            text: \' \'+retorno.text,
                                            position: \'top-right\',
                                            loaderBg:\'#ff6849\',
                                            icon: \'success\',
                                            hideAfter: 10000, 
                                        });
                                        $("#form-baixa input, #form-baixa select, #form-baixa textarea").val(\'\').trigger("change");
                                        $("#form-baixa")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#form-baixa").modal("hide");   
                                    }
                                    else{
                                        $.toast({
                                            heading: \'Nõ foi possível salvar\',
                                            text: \' \'+retorno.text,
                                            position: \'top-right\',
                                            loaderBg:\'#ff0000\',
                                            icon: \'error\',
                                            hideAfter: 10000, 
                                        });
                                        $("#form-baixa input, #form-baixa select, #form-baixa textarea").val(\'\').trigger("change");
                                        $("#form-baixa")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#form-baixa").modal("hide"); 
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