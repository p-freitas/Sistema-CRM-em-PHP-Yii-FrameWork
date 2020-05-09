<?php
/**
 * Created by PhpStorm.
 * User: Luan
 * Date: 18/10/2018
 * Time: 10:40
 */

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use app\models\Atendimento;

//d($model->getErrors());

?>

<div id="ajax-content-solucao">

    <?php $form = ActiveForm::begin(['id' => 'form-solucao', 'action' => \yii\helpers\Url::to(['//atendimento/solucao-modal'])]); ?>

    <div class="modal-body">
        <div class="row">
            <div class="col-md-12">
                <?= $form->field($model, 'id', ['options' => ['tag' => false]])->hiddenInput(['id' => 'id_solucao'])->label(false) ?>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <?= $form->field($model, 'solucao')->textarea(['rows' => 6])->label('Solução') ?>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <?php \demogorgorn\ajax\AjaxSubmitButton::begin([
            'label' => 'Salvar',
            'useWithActiveForm' => 'form-solucao', //id do form_modal
            'ajaxOptions' => [
                'type' => 'POST',
                'data' => new \yii\web\JsExpression('new FormData($("#form-solucao")[0])'),
                'processData' => false,
                'contentType' => false,
                'url' => \yii\helpers\Url::to(['//atendimento/solucao-modal']),
                'beforeSend' => new \yii\web\JsExpression('function(){$(".preloader").fadeIn();}'),
                'success' => new \yii\web\JsExpression('
                                function(data){
                                    var retorno = JSON.parse(data); 
                                    if(retorno.status == 200){
                                        $.toast({
                                            heading: "Salvo com sucesso",
                                            text: "Local: "+retorno.text,
                                            position: "top-right",
                                            loaderBg:"#ff6849",
                                            icon: "success",
                                            hideAfter: 10000, 
                                        });
                                        $("#form-solucao input, #form-solucao select, #form-solucao textarea").val("").trigger("change");
                                        $("#form-solucao")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#form-solucao").modal("hide");
                                    }
                                    else{
                                        $.toast({
                                            heading: \'Não foi possível salvar\',
                                            text: \' \'+retorno.text,
                                            position: \'top-right\',
                                            loaderBg:\'#ff0000\',
                                            icon: \'error\',
                                            hideAfter: 10000,
                                        });
                                        $("#form-solucao input, #form-solucao select, #form-solucao textarea").val(\'\').trigger("change");
                                        $("#form-solucao")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#form-solucao").modal("hide"); 
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