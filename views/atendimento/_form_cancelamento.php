<?php


use yii\helpers\Html;
use yii\widgets\ActiveForm;
use app\models\Atendimento;


?>

<div id="ajax-content-aditivo">

    <?php $form = ActiveForm::begin(['id' => 'form-cancelar']); ?>

    <div class="modal-body">
        <div class="row">
            <div class="col-md-12">
                <?= $form->field($model, 'id', ['options' => ['tag' => false]])->hiddenInput(['id' => 'id_atendimento'])->label(false) ?>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <?= $form->field($model, 'motivo')->textarea(['rows' => 3])->label("Motivo") ?>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <?php

            \demogorgorn\ajax\AjaxSubmitButton::begin([
            'label' => 'Salvar',
            'useWithActiveForm' => 'form-cancelar', //id do form_modal
            'ajaxOptions' => [
                'type' => 'POST',
                'data' => new \yii\web\JsExpression('new FormData($("#form-cancelar")[0])'),
                'processData' => false,
                'contentType' => false,
                'url' => \yii\helpers\Url::to(['//atendimento/cancela-atendimento']),
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
                                        $("#form-cancelar input, #form-cancelar select, #form-cancelar textarea").val(\'\').trigger("change");
                                        $("#form-cancelar")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#form-cancelar").modal("hide");   
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
                                        $("#form-cancelar input, #form-cancelar select, #form-cancelar textarea").val(\'\').trigger("change");
                                        $("#form-cancelar")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#form-cancelar").modal("hide"); 
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