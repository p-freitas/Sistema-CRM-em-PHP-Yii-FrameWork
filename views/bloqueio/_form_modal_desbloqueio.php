<?php
/**
 * Created by PhpStorm.
 * User: Luan
 * Date: 23/10/2018
 * Time: 16:37
 */

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

?>

<div id="ajax-content-desbloqueio">

    <?php $form = ActiveForm::begin(['id' => 'desbloqueio-form']); ?>

    <div class="modal-body">
        <input type="hidden" class="form-control"  name="cliente" id="cliente" value="">
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table gestao table-bordered m-t-30 table-hover contact-list footable footable-5 footable-paging footable-paging-center breakpoint-lg">
                        <thead>
                        <tr>
                            <th style="color: black; vertical-align: middle" class="text-center">Contrato</th>
                            <th style="color: black; vertical-align: middle" class="text-center">Produtos</th>
                            <th style="color: black; vertical-align: middle" class="text-center">Data Bloqueio</th>
                            <th style="color: black; vertical-align: middle" class="text-center">Data Limite</th>
                            <th style="color: black; vertical-align: middle" class="text-center">Usuário</th>
                            <th style="color: black; vertical-align: middle" class="text-center">Desbloquear</th>
                        </tr>
                        </thead>
                        <tbody id="corpo-bloqueios">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <?php \demogorgorn\ajax\AjaxSubmitButton::begin([
            'label' => 'Salvar',
            'useWithActiveForm' => 'desbloqueio-form', //id do form_modal
            'ajaxOptions' => [
                'type' => 'POST',
                'data' => new \yii\web\JsExpression('new FormData($("#desbloqueio-form")[0])'),
                'processData' => false,
                'contentType' => false,
                'url' => \yii\helpers\Url::to(['//bloqueio/delete-bloqueio']),
                'beforeSend' => new \yii\web\JsExpression('function(){$(".preloader").fadeIn();}'),
                'success' => new \yii\web\JsExpression('
                                function(data){
                                    var retorno = JSON.parse(data); 
                                    if(retorno.status == 200){
                                        $.toast({
                                            heading: \'Salvo com sucesso\',
                                            text: \'Bloqueio: \'+retorno.text,
                                            position: \'top-right\',
                                            loaderBg:\'#ff6849\',
                                            icon: \'success\',
                                            hideAfter: 10000, 
                                        });
                                        $("#desbloqueio-form input, #desbloqueio-form select, #desbloqueio-form textarea").val(\'\').trigger("change");
                                        $("#desbloqueio-form")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#desbloqueio-modal").modal("hide");   
                                    }
                                    else 
                                        $.toast({
                                            heading: \'Ocorreu um erro, por favor tente novamente.\',
                                            text: \' \'+retorno.text,
                                            position: \'top-right\',
                                            loaderBg:\'#ff0000\',
                                            icon: \'error\',
                                            hideAfter: 10000, 
                                        });
                                        $("#desbloqueio-form input, #desbloqueio-form select, #desbloqueio-form textarea").val(\'\').trigger("change");
                                        $("#desbloqueio-form")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#desbloqueio-modal").modal("hide"); 
                                        
                                    $(".preloader").fadeOut();
                                }'
                ),
            ],
            'options' => ['class' => 'btn btn-success', 'type' => 'submit'],
        ]);
        \demogorgorn\ajax\AjaxSubmitButton::end();
        ?>
        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
    </div>
    <?php ActiveForm::end(); ?>
</div>