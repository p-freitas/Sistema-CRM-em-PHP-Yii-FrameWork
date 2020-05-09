<div class="col-md-4 form-group">
    <?= $form->field($model, 'contrato')->widget(\kartik\depdrop\DepDrop::classname(), [
        'options'=>['class'=>'form-control select2'],
        'pluginOptions'=>[
            'depends'=>['relatorioform-licitacao'],
            'placeholder'=>'Selecione o contrato',
            'url'=>\yii\helpers\Url::to(['relatorio/contratos'])
        ]
    ]); ?>
</div>