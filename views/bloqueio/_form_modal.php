<?php
/**
 * Created by PhpStorm.
 * User: luanaraujo
 * Date: 19/10/18
 * Time: 16:10
 */

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

?>

<div id="ajax-content-bloqueio">

    <?php $form = ActiveForm::begin(['id' => 'bloqueio-form']); ?>

    <div class="modal-body">
        <?= $form->field($model, 'fk_cliente', ['options' => ['tag' => false]])->hiddenInput()->label(false) ?>

        <div class="row">
            <div class="col-md-6">
                <?= $form->field($model, 'fk_contrato')->widget(\kartik\select2\Select2::className(),[
                    'theme' => 'bootstrap',
                    'language' => 'pt-BR',
                    'pluginOptions'=>['allowClear'=>true],
                    'options' => ['placeholder' => 'Selecione', 'data-url' => Url::to(['contrato/get-contratos-cliente'])],
                    'pluginEvents' => [
                        "change" => "function() { 
                            $('#corpo-produtos').parents('table').DataTable().rows('tr').remove().draw(false);                                
                        }",
                    ],
                ])?>
            </div>
            <div class="col-md-6">
                <?= $form->field($model, 'data_limite')->widget(\kartik\daterange\DateRangePicker::className(), [
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
                    ]
                ]) ?>
            </div>
        </div>

        <div class="row">

            <div class="col-md-6">
                <?= $form->field($modelBloqueioProduto, 'fk_produto')->widget(\kartik\depdrop\DepDrop::classname(), [
                    'type' => \kartik\depdrop\DepDrop::TYPE_SELECT2,
                    'select2Options' => [
                        'theme' => 'bootstrap',
                        'language' => 'pt-BR',
                        'options' => ['placeholder' => 'Selecione'],
                        'pluginOptions'=>['allowClear'=>true],
                    ],
                    'pluginOptions' => [
                        'loadingText' => 'Carregando',
                        'depends' => ['bloqueio-fk_contrato'],
                        'placeholder' => 'Selecione',
                        'url' => \yii\helpers\Url::to(['produto/get-produtos', 'id' => $modelBloqueioProduto->fk_produto]),
                        'initialize' => true,
                        'language' => 'pt',
                    ],
                ]); ?>
            </div>
            <div class="col-md-2 m-t-15 p-t-15">
                <?= Html::button('Adicionar Produto', ['class' => 'btn btn-info btn-rounded m-t-10 float-right', 'type' => 'button', 'id' => 'add-produto-btn']) ?>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table gestao table-bordered m-t-30 table-hover contact-list footable footable-5 footable-paging footable-paging-center breakpoint-lg">
                        <thead>
                        <tr>
                            <th style="color: black; vertical-align: middle" class="text-center">Produto</th>
                            <th style="color: black; vertical-align: middle" class="text-center">Ação</th>
                        </tr>
                        </thead>
                        <tbody id="corpo-produtos">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
    <div class="modal-footer">
        <?php \demogorgorn\ajax\AjaxSubmitButton::begin([
            'label' => 'Salvar',
            'useWithActiveForm' => 'bloqueio-form', //id do form_modal
            'ajaxOptions' => [
                'type' => 'POST',
                'data' => new \yii\web\JsExpression('new FormData($("#bloqueio-form")[0])'),
                'processData' => false,
                'contentType' => false,
                'url' => \yii\helpers\Url::to(['//bloqueio/create-modal']),
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
                                        $("#bloqueio-form input, #bloqueio-form select, #bloqueio-form textarea").val(\'\').trigger("change");
                                        $("#bloqueio-form")[0].reset();
                                        $("#mensagem").parent().addClass("hide");
                                        $("#bloqueio-modal").modal("hide");   
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