<?php

use kartik\daterange\DateRangePicker;
use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\select2\Select2;

/* @var $this yii\web\View */
/* @var $model app\models\Financeiro */
/* @var $form yii\widgets\ActiveForm */

if ($model->scenario == 'ContaPagar'){
    $this->title = "Cadastro de conta a pagar";
    $this->params['breadcrumbs'][] = $this->title;
}else{
    $this->title = "Cadastro de conta a receber";
    $this->params['breadcrumbs'][] = $this->title;
}

?>

<div class="financeiro-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'fk_cliente')->widget(Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear'=>true],
                'data' => \yii\helpers\ArrayHelper::map(\app\models\Cliente::find()->asArray()->all(), 'id', 'nome_fantasia'),
            ])->label($model->scenario == 'ContaPagar' ? 'Fornecedor' : 'Cliente')?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'data_emissao')->widget(DateRangePicker::className(), [
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

        <div class="col-md-4">
            <?= $form->field($model, 'vencimento')->widget(DateRangePicker::className(), [
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

            ])->label('Vencimento') ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'fk_tipo_documento')->widget(Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear'=>true],
                'data' => \yii\helpers\ArrayHelper::map(\app\models\TipoDocumento::find()->asArray()->all(), 'id', 'descricao'),
            ])->label('Tipo de documento')?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'numero_titulo')->textInput(['maxlength' => true])->label('Número do título') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'fk_conta_orcamento')->widget(Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear'=>true],
                'data' => \yii\helpers\ArrayHelper::map(\app\models\ContaOrcamento::find()->asArray()->all(), 'id', 'descricao'),
            ])->label('Orçamento')?>
        </div>
    </div>

    <div class="row">

        <div class="col-md-4">
            <?= $form->field($model, 'fk_banco_portador')->widget(Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear'=>true],
                'data' => \yii\helpers\ArrayHelper::map(\app\models\Banco::find()->asArray()->all(), 'id', 'descricao'),
            ])->label('Banco portador')?>
        </div>

        <?php if (!$model->isNewRecord){ ?>
            <div class="col-md-3 text-center">
                <label>Data</label>
                <input type="text" class="form-control text-center" value="<?= $model->data ?>"
                       disabled>
            </div>

            <div class="col-md-2 text-center">
                <?= $form->field($model, 'situacao')->dropDownList([
                    0 => 'Aberto',
                    1 => 'Baixa parcial',
                    2 => 'Liquidado',
                ],
                    ['class' => 'form-control', 'disabled' => true, 'id' => 'situacao-id']
                ) ?>
            </div>

        <?php } ?>
    </div>

    <br>

    <fieldset>
        <legend>Valores</legend>
        <div class="row">
            <div class="col-md-4">
                <?= $form->field($model, 'valor_titulo')->widget(\yii\widgets\MaskedInput::className(), [
                    'clientOptions' => [
                        'alias' => 'decimal',
                        'digits' => 2,
                        'groupSeparator' => '.',
                        'radixPoint' => ',',
                        'autoGroup' => true,
                        'placeholder' => '0.00'
                    ],
                ]) ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'valor_dev')->widget(\yii\widgets\MaskedInput::className(), [
                    'clientOptions' => [
                        'alias' => 'decimal',
                        'digits' => 2,
                        'groupSeparator' => '.',
                        'radixPoint' => ',',
                        'autoGroup' => true,
                        'placeholder' => '0.00'
                    ],
                ]) ?>
            </div>
        </div>
        <div class="row">

            <div class="col-md-4">
                <?= $form->field($model, 'valor_desconto')->widget(\yii\widgets\MaskedInput::className(), [
                    'clientOptions' => [
                        'alias' => 'decimal',
                        'digits' => 2,
                        'groupSeparator' => '.',
                        'radixPoint' => ',',
                        'autoGroup' => true,
                        'placeholder' => '0.00'
                    ],
                ]) ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'data_dev')->widget(\kartik\daterange\DateRangePicker::className(), [
                    'pluginOptions' => [
                        'language' => 'pt-br',
                        'singleDatePicker' => true,
                        'locale' => ['format' => 'DD/MM/YYYY'],
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
            <div class="col-md-4 text-center" >
                <label>Saldo</label>
                <input type="text" class="form-control text-right" value="<?= $model->saldo ?>"
                       disabled>
            </div>
        </div>
    </fieldset>

    <br>

    <?php if (!$model->isNewRecord) { ?>
        <fieldset>
            <legend>Pagamentos</legend>
            <div class="row">

                <div class="col-md-4">
                    <?= $form->field($model, 'valor_pgto')->widget(\yii\widgets\MaskedInput::className(), [
                        'clientOptions' => [
                            'alias' => 'decimal',
                            'digits' => 2,
                            'groupSeparator' => '.',
                            'radixPoint' => ',',
                            'autoGroup' => true,
                            'placeholder' => '0.00'

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
        </fieldset>
    <?php } ?>

    <br>

    <div class="row">
        <div class="col-md-12">
            <?= $form->field($model, 'obs')->textarea(['rows' => 6])->label('Observações') ?>
        </div>
    </div>

    <br>

    <div class="form-group">
        <?= Html::submitButton('Salvar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
