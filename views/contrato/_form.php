<?php

use kartik\select2\Select2;
use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

use yii\helpers\arrayHelper;


/* @var $this yii\web\View */
/* @var $model app\models\Contrato */
/* @var $form yii\widgets\ActiveForm */
/* @var $modelProduto \app\models\Produto */


\app\assets\DatatablesAsset::register($this);
$this->registerJsFile('@web/js/produtos.js', ['depends' => [\yii\web\JqueryAsset::className()]]);


\app\assets\DatatablesAsset::register($this);
$this->registerJsFile('@web/js/aditivos.js', ['depends' => [\yii\web\JqueryAsset::className()]]);
?>

<div class="contrato-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <div class="col-md-2">
            <?= $form->field($model, 'numero')->textInput(['maxlength' => true])->label("Número contrato") ?>
        </div>
        <div class="col-md-2">
            <?= $form->field($model, 'fk_modalidade')->widget(\kartik\select2\Select2::className(), [
                'theme' => 'bootstrap',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear' => true],
                'language' => 'pt-BR',
                'data' => \yii\helpers\ArrayHelper::map(\app\models\Modalidade::find()->asArray()->all(), 'id', 'descricao'),
            ])->label('Modalidade') ?>
        </div>
        <div class="col-md-2">
            <?= $form->field($model, 'valor_global')->widget(\yii\widgets\MaskedInput::className(), [
                'clientOptions' => [
                    'alias' => 'decimal',
                    'digits' => 2,
                    'groupSeparator' => '.',
                    'radixPoint' => ',',
                    'autoGroup' => true
                ],
            ]) ?>
        </div>
        <div class="col-md-2">
            <?= $form->field($model, 'data_inicio')->widget(\kartik\daterange\DateRangePicker::className(), [
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
        <div class="col-md-2">
            <?= $form->field($model, 'data_termino')->widget(\kartik\daterange\DateRangePicker::className(), [
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
        <div class="col-md-2">
            <?= $form->field($model, 'valor_mensal')->widget(\yii\widgets\MaskedInput::className(), [
                'clientOptions' => [
                    'alias' => 'decimal',
                    'digits' => 2,
                    'groupSeparator' => '.',
                    'radixPoint' => ',',
                    'autoGroup' => true,
                    'value' => '123'
                ],
            ]) ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <?= $form->field($model, 'fk_cliente')->widget(\kartik\select2\Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear' => true],
                'data' => \app\modules\Helper::map(\app\models\Cliente::find()->findClienteByEntidade()->andFilterWhere(['like', 'fk_tipo_cliente', '2'])->orderBy([\app\models\Cliente::tableName() . '.razao_social' => SORT_ASC])->asArray()->all(), 'id', 'razao_social')
            ])->label('Cliente') ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <?= $form->field($model, 'objeto')->textarea(['rows' => 2])->label('Objeto') ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <?= $form->field($model, 'info_complementar')->textarea(['rows' => 2])->label('Informações complementares') ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'anexo')->widget(\kartik\file\FileInput::classname(), [
                'options' => ['accept' => '*'],
                'language' => 'pt',
                'pluginOptions' => [
                    'showUpload' => false,
                    'showPreview' => false,
                    'showRemove' => true,
                    'browseLabel' => '',
                    'removeLabel' => '',
                    'initialCaption' => empty($model->anexo) ? '' : explode('/', $model->anexo)[7],
                ],
            ]) ?>
        </div>

    </div>
    <br><br>
    <div class="row">
        <fieldset>
            <legend>Produtos contratados</legend>
            <div class="col-md-12">
                <div class="table-responsive">
                    <div class="row">
                        <div class="col-md-4">
                            <?= $form->field($modelProduto, 'produtos_contrato')->widget(\kartik\select2\Select2::classname(), [
                                'theme' => 'bootstrap',
                                'language' => 'pt-BR',
                                'options' => ['placeholder' => 'Selecione'],
                                'pluginOptions' => ['allowClear' => true],
                                'data' => \app\modules\Helper::map(\app\models\Produto::find()->findProdutosByEntidade()->orderBy([\app\models\Produto::tableName() . '.descricao' => SORT_ASC])->asArray()->all(), 'id', 'descricao')
                            ])->label('Produtos') ?>
                        </div>
                        <div class="col-md-2 m-t-15 p-t-15">
                            <?= Html::button('Adicionar Produto', ['class' => 'btn btn-info btn-rounded m-t-10 float-right', 'type' => 'button', 'id' => 'add-produto-btn']) ?>
                        </div>
                    </div>

                    <table class="table gestao table-bordered m-t-30 table-hover contact-list footable footable-5 footable-paging footable-paging-center breakpoint-lg">
                        <thead>
                        <tr>
                            <th style="color: black; vertical-align: middle" class="text-center">Produto</th>
                            <th style="color: black; vertical-align: middle" class="text-center">Ação</th>
                        </tr>
                        </thead>
                        <tbody id="corpo-produtos">
                        <!--Update - Dados vindo do banco -->
                        <?php foreach ($model->contratoProdutos as $index => $produto) { ?>
                            <tr data-produto="<?= $produto->fkProduto->descricao ?>" data-index-produto="<?= $index ?>">
                                <td>
                                    <input type="hidden" name="ContratoProdutos[<?= $index ?>][fk_produto]"
                                           value="<?= $produto->fk_produto ?>"><?= $produto->fkProduto->descricao ?>
                                </td>
                                <td class="text-center">
                                    <button data-toggle="tooltip" data-placement="right" title="Excluir" type="button"
                                            type="button" class="btn btn-rounded btn-danger btn-sm delete-produto"><i
                                                class="fa fa-trash"></i></button>
                                </td>
                            </tr>
                        <?php } ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </fieldset>
    </div>

    <?php $modelsAditivo = $model->aditivos;
    if (!empty($modelsAditivo)) { ?>
        <div class="row m-t-30">
            <fieldset>
                <legend>Aditivos</legend>
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table gestao table-bordered m-t-30 table-hover contact-list footable footable-5 footable-paging footable-paging-center breakpoint-lg">
                            <thead>
                            <tr>
                                <th style="color: black; vertical-align: middle" class="text-center">Número</th>
                                <th style="color: black; vertical-align: middle" class="text-center">Valor</th>
                                <th style="color: black; vertical-align: middle" class="text-center">Data Início</th>
                                <th style="color: black; vertical-align: middle" class="text-center">Data Término</th>
                                <th style="color: black; vertical-align: middle" class="text-center">Justificativa</th>
                                <th style="color: black; vertical-align: middle" class="text-center">Anexo</th>
                                <th style="color: black; vertical-align: middle" class="text-center">Ações</th>
                            </tr>
                            </thead>
                            <tbody id="corpo-aditivos">
                            <!--Update - Dados vindo do banco -->
                            <?php foreach ($modelsAditivo as $index => $modelAditivo) { ?>
                                <tr data-produto="<?= $modelAditivo->numero ?>" data-index-aditivo="<?= $index ?>">
                                    <td>
                                        <input type="hidden" name="Aditivo[<?= $index ?>][numero]"
                                               value="<?= $modelAditivo->numero ?>"><?= $modelAditivo->numero ?>
                                        <input type="hidden" name="Aditivo[<?= $index ?>][id_edit_aditivo]"
                                               value="<?= $modelAditivo->id ?>" id="id_edit_aditivo">
                                    </td>
                                    <td>
                                        <input type="hidden" name="Aditivo[<?= $index ?>][valor]"
                                               value="<?= $modelAditivo->valor ?>"><?= $modelAditivo->valor ?>
                                    </td>
                                    <td>
                                        <input type="hidden" name="Aditivo[<?= $index ?>][data_inicio]"
                                               value="<?= $modelAditivo->data_inicio ?>"><?= $modelAditivo->data_inicio ?>
                                    </td>
                                    <td>
                                        <input type="hidden" name="Aditivo[<?= $index ?>][data_termino]"
                                               value="<?= $modelAditivo->data_termino ?>"><?= $modelAditivo->data_termino ?>
                                    </td>
                                    <td>
                                        <input type="hidden" name="Aditivo[<?= $index ?>][justificativa]"
                                               value="<?= $modelAditivo->justificativa ?>"><?= $modelAditivo->justificativa ?>
                                    </td>
                                    <td class="text-center">
                                        <span onclick="file(this)">
                                            <?= empty($modelAditivo->anexo) ? Html::button('', ['class' => 'btn btn-info btn-rounded fa fa-upload', 'type' => 'button', 'data-toggle' => 'tooltip', 'data-placement' => 'top', 'title' => 'Adicionar']) : Html::button('', ['class' => 'fa fa-arrow-up btn btn-info btn-rounded fa-upload', 'type' => 'button', 'href' => $model->anexo, 'data-toggle' => 'tooltip', 'data-placement' => 'top', 'title' => 'Alterar']) ?>
                                        </span>
                                        <input type="file" class="hide" name="Aditivo[<?= $index ?>][anexo]">
                                    </td>
                                    <td class="text-center">
                                        <button data-toggle="tooltip" data-placement="top" title="Atualizar"
                                                type="button" class="btn btn-rounded btn-primary btn-sm edit-aditivo"><i
                                                    class="fa fa-pencil"></i></button>

                                        <button data-toggle="tooltip" data-placement="top" title="Excluir" type="button"
                                                type="button" class="btn btn-rounded btn-danger btn-sm delete-produto">
                                            <i
                                                    class="fa fa-trash"></i></button>
                                    </td>
                                    </td>
                                </tr>
                            <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </fieldset>
        </div>
    <?php } ?>
    <!-- <hr> -->
    <div class="form-group">
        <?= Html::submitButton(Yii::t('app', 'Save'), ['class' => 'btn btn-success m-t-15']) ?>
    </div>
    <?php ActiveForm::end(); ?>
</div>


<div class="modal fade" id="aditivo-modal" tabindex="-1" role="dialog" aria-labelledby="aditivo-modal-label">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="aditivo-modal-label" style="color: white">Aditivo</h4>
            </div>
            <div id="content-aditivo">

                <?php $form = ActiveForm::begin(['id' => 'aditivo-form']); ?>

                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-12">
                            <?= $form->field($aditivo, 'fk_contrato', ['options' => ['tag' => false]])->hiddenInput(['id' => 'id_contrato'])->label(false) ?>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <?= $form->field($aditivo, 'numero')->textInput(['maxlength' => true]) ?>
                        </div>

                        <div class="col-md-6">
                            <?= $form->field($aditivo, 'valor')->textInput(['maxlength' => true]) ?>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <?= $form->field($aditivo, 'data_inicio')->widget(\kartik\daterange\DateRangePicker::className(), [
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
                        <div class="col-md-6">
                            <?= $form->field($aditivo, 'data_termino')->widget(\kartik\daterange\DateRangePicker::className(), [
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
                        <div class="col-md-12">
                            <?= $form->field($aditivo, 'justificativa')->textarea(['rows' => 3]) ?>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <?= Html::button('Salvar', ['class' => 'btn btn-success waves-effect', 'type' => 'button', 'id' => 'save-aditivo-btn']) ?>
                    <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Fechar</button>
                </div>
                <?php ActiveForm::end(); ?>
            </div>
        </div>
    </div>
</div>