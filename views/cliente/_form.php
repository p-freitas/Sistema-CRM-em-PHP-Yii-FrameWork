<?php

use kartik\file\FileInput;
use kartik\number\NumberControl;
use kartik\select2\Select2;
use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;
use yii\helpers\arrayHelper;
use kartik\daterange\DateRangePicker;
use kartik\date\DatePicker;
use wbraganca\dynamicform\DynamicFormWidget;
use app\components\CustomMaskedInput;
use etsoft\widgets\YearSelectbox;


/* @var $this yii\web\View */
/* @var $model app\models\Cliente */
/* @var $form yii\widgets\ActiveForm */
/* @var $modelContato app\models\ContatoCliente */
/* @var $modelTelefone \app\models\Telefone */
/* @var $modelGestao \app\models\Gestao */

$this->registerJs(
    "
    
    $('#cliente-cep').popover({
            content: 'Digite o CEP e depois clique na lupa para buscar o endereço.',
            placement: 'top',
            trigger: 'focus'
        });",
    \yii\web\View::POS_READY,
    'popover_cep'
);

$this->registerJs("
        
    $('#modal-add-cargo').on('show.bs.modal', function(){
        $('#contatocliente-fk_cargo').select2('close');
    });
    
        
    $('#modal-add-departamento').on('show.bs.modal', function(){
        $('#contatocliente-fk_departamento').select2('close');
    });
    
    $('#close-cargo').on('click', function(){
        $('#contato-modal').modal('show'); 
    });
    
    $('#close-departamento').on('click', function(){
        $('#contato-modal').modal('show'); 
    });
    
    
    $('#close').on('click', function(){
        $('#contato-modal').modal('show'); 
    });
    
    $('#modal-add-cargo').on('submit', function(){
        e.preventDefault();

        $.get('//cargo/create', $(this).serialize(), function(response) {
            $('#dialog').html(response);
            $('#dialog').modal('show');
        });
    });
    
    $('#add-telefone-btn').on('submit', function(){
        $('#telefone-modal').modal('hide'); 
    });
    
    $('#nome-form').on('beforeSubmit', function(e){
        e.stopImmediatePropagation();
    });
    
    $('#save-contato-btn').on('submit', function(){
        $(\"#contato-modal\").modal(\"hide\");
    });
    
");

$this->registerJs(
    "function showFieldsOrg(org) {
         if($('#cliente-fk_tipo_orgao').find('option:selected').text().toLowerCase() == 'prefeitura %' && $('#cliente-fk_tipo_cliente').find('option:selected').text().toLowerCase() == 'cliente'){
            $('#fpm').removeClass('hide');
            $('#gestao').removeClass('hide');
            $('#perfil').removeClass('hide');
            $('#w1').prop('required',true); 
            $('#w1-2').prop('required',true); 
            
        }else{
            $('#fpm').addClass('hide');
            $('#perfil').addClass('hide');
            $('#cliente-qtd_populacao').val('');
            $('#cliente-qtd_eleitor').val('');
            $('#cliente-ano_populacao').val('');
            $('#cliente-fpm').val('');
            $('#cliente-fpm_ano').val('');
            $('#gestao').addClass('hide');
            $('#gestao-fk_cliente').val('').change();
            $('#gestao-periodo').val('');
            $('#gestao-prefeito').val('');
            $('#gestao-data_nascimento').val('');
            $('#gestao-vice_prefeito').val('');
            $('#w1').prop('required',false); 
            $('#w1-2').prop('required',false);        
        }
    }",
    \yii\web\View::POS_HEAD
);

$this->registerJs(
    "function showFieldsCli(rep) {
        if($(rep).val() != null) {
            $.ajax({
            type: 'get',
            url: $(rep).data('url'),
            data: {'id': $(rep).val()},
            beforeSend: function () {
                $($('#representante').find('input')[0]).val('');
                $('#representante').addClass('hide');
            }
        }).done(function (data) {
                var retorno = JSON.parse(data);                                 
                if( retorno.rep.toLowerCase() == 'cliente'){
                   $('#representante').removeClass('hide');
                   $('#representantes').val('').trigger('change');
                   
                }else{
                    $('#representante').setAttribute('disabled', true);
                }
                if(retorno.rep.toLowerCase() == 'cliente' && $('#cliente-fk_tipo_orgao').find('option:selected').text().toLowerCase() == 'prefeitura' ){
                    $('#fpm').removeClass('hide');
                    $('#gestao').removeClass('hide');
                    $('#perfil').removeClass('hide');
                    $('#w1').prop('required',true); 
                    $('#w1-2').prop('required',true);
                }else{
                    $('#fpm').addClass('hide');
                    $('#cliente-qtd_populacao').val('');
                    $('#cliente-qtd_eleitor').val('');
                    $('#cliente-ano_populacao').val('');
                    $('#cliente-fpm').val('');
                    $('#cliente-fpm_ano').val('');
                    $('#gestao').addClass('hide');
                    $('#gestao-fk_cliente').val('').change();
                    $('#gestao-periodo').val('');
                    $('#gestao-prefeito').val('');
                    $('#gestao-data_nascimento').val('');
                    $('#gestao-vice_prefeito').val('');
                    $('#w1').prop('required',false); 
                    $('#w1-2').prop('required',false);
                }
            });
        }
    }",
    \yii\web\View::POS_HEAD
);

$this->registerJs(
    "function mudaLabel(cnpj_cpf){
        if($(cnpj_cpf).val().length < 15){
            $('#razao_social').text('Nome');
            $('#nome_fantasia').text('Apelido');
        }else{
            $('#razao_social').text('Razão Social');
            $('#nome_fantasia').text('Nome Fantasia');
        }
    }",
    \yii\web\View::POS_HEAD
);


\app\assets\DatatablesAsset::register($this);
$this->registerJsFile('@web/js/contato.js', ['depends' => [\yii\web\JqueryAsset::className()]]);

\app\assets\DatatablesAsset::register($this);
$this->registerJsFile('@web/js/gestao.js', ['depends' => [\yii\web\JqueryAsset::className()]]);

?>

<div class="cliente-form">

    <?php $form = ActiveForm::begin(['id' => 'form-cliente', 'options' => ['enctype' => 'multipart/form-data']]); ?>

    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="nav-item <?= is_null($view) ? 'active' : '' ?>">
            <a id="cliente-btn"
               href="#cliente"
               class="nav-link <?= is_null($view) ? 'active' : '' ?>"
               role="tab"
               data-toggle="tab">
                <i class="fa fa-child"></i> Cliente</a></li>

        <li role="presentation" class="nav-item <?= is_null($view) ? '' : 'active' ?>">
            <a id="anexo-btn" href="#anexo"
               class="nav-link <?= is_null($view) ? '' : 'active' ?>"
               role="tab"
               data-toggle="tab">
                <i class="fa fa-file"></i> Anexos</a></li>
    </ul>

    <div class="tab-content">


        <div role="tabpanel" class="tab-pane <?= is_null($view) ? 'active' : '' ?>" id="cliente">

            <div class="col-md-2">
                <div class="row">
                    <div class="col-md-12 m-b-5">
                        <img onclick="openFileInput()"
                             src="<?= !empty($model->brasao) ? $model->brasao : \yii\helpers\Url::to('@web/themes/eliteadmin/plugins/images/users/blank-user.jpg', true) ?>"
                             alt="cliente" id="img-cliente" title="Clique para alterar" style="max-width: 100%">
                    </div>
                </div>

                <div class="col-md-12 m-b-5">
                    <?= $form->field($model, 'brasao')->widget(FileInput::classname(), [
                        'options' => ['accept' => 'image/*'],
                        'language' => 'pt',
                        'pluginOptions' => [
                            'showUpload' => false,
                            'showPreview' => false,
                            'showRemove' => true,
                            'browseLabel' => '',
                            'removeLabel' => '',
                            'initialCaption' => empty($model->brasao) ? '' : explode('/', $model->brasao)[7],
                        ],
                    ])->label("") ?>
                </div>
            </div>

            <div class="row">


                <div class="col-md-3">
                    <?= $form->field($model, 'cpf_cnpj')->widget(\yii\widgets\MaskedInput::className(), [
                        'mask' => ['999.999.999-99', '99.999.999/9999-99'],
                        'options' => ['class' => 'form-control', 'onchange' => 'mudaLabel(this)'],
                    ])->label('CPF/CNPJ') ?>
                </div>

                <div class="col-md-6">
                    <?= $form->field($model, 'razao_social')->textInput(['maxlength' => true])->label('Razão Social', ['id' => 'razao_social']) ?>
                </div>

                <div class="col-md-5">
                    <?= $form->field($model, 'nome_fantasia')->textInput(['maxlength' => true])->label('Nome Fantasia', ['id' => 'nome_fantasia']) ?>
                </div>

                <div class="col-md-4">
                    <?= $form->field($model, 'email')->textInput(['maxlength' => true]) ?>
                </div>

                <?php if ((Yii::$app->user->isSuperadmin)) { ?>
                    <div class="col-md-4">
                        <?= $form->field($model, 'fk_entidade')->widget(Select2::classname(), [
                            'theme' => 'bootstrap',
                            'language' => 'pt-BR',
                            'options' => ['placeholder' => 'Selecione'],
                            'pluginOptions' => ['allowClear' => true],
                            'data' => \app\modules\Helper::map(\app\models\Entidade::find()->orderBy([\app\models\Entidade::tableName() . '.nome_fantasia' => SORT_ASC])->asArray()->all(), 'id', 'nome_fantasia')
                        ])->label('Empresa') ?>
                    </div>
                <?php } ?>
            </div>

            <div class="row">

                <div class="col-md-4">
                    <?= $form->field($model, 'fk_tipo_orgao')->widget(Select2::classname(), [
                        'theme' => 'bootstrap',
                        'language' => 'pt-BR',
                        'options' => ['placeholder' => 'Selecione'],
                        'pluginOptions' => ['allowClear' => true],
                        'data' => \app\modules\Helper::map(\app\models\TipoOrgao::find()->findTipoOrgaoByEntidade()->orderBy([\app\models\TipoOrgao::tableName() . '.descricao' => SORT_ASC])->asArray()->all(), 'id', 'descricao'),
                        'pluginEvents' => [
                            "select2:select" => "function(){showFieldsOrg(this);}"
                        ],
                    ])->label("Orgão") ?>
                </div>

                <div class="col-md-4">
                    <?= $form->field($model, 'fk_tipo_cliente')->widget(Select2::classname(), [
                        'theme' => 'bootstrap',
                        'language' => 'pt-BR',
                        'options' => ['placeholder' => 'Selecione', 'data-url' => Url::to(['tipo-cliente/get-tipo-cliente'])],
                        'pluginOptions' => ['allowClear' => true],
                        'data' => \app\modules\Helper::map(\app\models\TipoCliente::find()->findTipoClienteByEntidade()->orderBy([\app\models\TipoCliente::tableName() . '.descricao' => SORT_ASC])->asArray()->all(), 'id', 'descricao'),
                        'pluginEvents' => [
                            "select2:select" => "function(){showFieldsCli(this);}",
                        ]
                    ])->label('Tipo Entidade') ?>
                </div>

                <div class="col-md-4 <?= ($model->fk_tipo_orgao == 3 && $model->fk_tipo_cliente == 2) ? ' ' : 'hide' ?>" id="representante">
                    <?= $form->field($model, 'fk_representante')->widget(Select2::classname(), [
                        'theme' => 'bootstrap',
                        'language' => 'pt-BR',
                        'options' => ['placeholder' => 'Selecione', 'id' => 'representantes'],
                        'pluginOptions' => ['allowClear' => true],
                        'data' => \app\modules\Helper::map(\app\models\Cliente::find()->findClienteByEntidade()->andFilterWhere(['like', 'fk_tipo_cliente', '3'])->orderBy([\app\models\Cliente::tableName() . '.nome_fantasia' => SORT_ASC])->asArray()->all(), 'id', 'nome_fantasia')
                    ]) ?>
                </div>
            </div>

            <div class="row">
                <div class="col-md-2">
                    <?= $form->field($model, 'cep')->widget(\yii\widgets\MaskedInput::className(), [
                        'mask' => '99999-999'
                    ])->widget(\yiibr\correios\CepInput::className(), [
                        'action' => ['//site/addressSearch'],
                        'fields' => [
                            'city' => 'cliente-cidade',
                            'state' => 'cliente-estado',
                            'location' => 'cliente-endereco',
                            'district' => 'cliente-bairro',
                        ],
                    ]) ?>
                </div>
                <div class="col-md-1">
                    <?= $form->field($model, 'estado')->textInput(['maxlength' => true]) ?>
                </div>
                <div class="col-md-3">
                    <?= $form->field($model, 'cidade')->textInput(['maxlength' => true]) ?>
                </div>
                <div class="col-md-4">
                    <?= $form->field($model, 'endereco')->textInput(['maxlength' => true]) ?>
                </div>
                <div class="col-md-2">
                    <?= $form->field($model, 'numero')->textInput(['maxlength' => true]) ?>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <?= $form->field($model, 'bairro')->textInput(['maxlength' => true]) ?>
                </div>

                <div class="col-md-8">
                    <?= $form->field($model, 'complemento')->textInput(['maxlength' => true]) ?>
                </div>
            </div>


            <?php if (!$model->isNewRecord) { ?>
                <div class="row">
                    <div class="col-md-4">
                        <?= $form->field($model, 'data_cadastro')->textInput(['maxlength' => true, 'readonly' => true]) ?>
                    </div>
                    <div class="col-md-4">
                        <?= $form->field($model, 'situacao')->DropDownList([
                            1 => 'Ativo',
                            0 => 'Inativo',],
                            ['class' => 'form-control', 'prompt' => 'Selecione', 'readonly' => true])->label('Situação') ?>
                    </div>
                    <div class="col-md-4">
                        <?= $form->field($model, 'data_situacao')->textInput(['maxlength' => true, 'readonly' => true]) ?>
                    </div>
                </div>
            <?php } ?>

            <br>

            <?php if ($model->isNewRecord) {
                $pefil_municipal_hide = 'hide';
            } else {
                if (strtolower($model->fkTipoCliente->descricao) == 'cliente' && strtolower($model->fkTipoOrgao->descricao) == 'prefeitura') {
                    $pefil_municipal_hide = '';
                } else {
                    $pefil_municipal_hide = 'hide';
                }
            } ?>
            <div id="perfil" class="row <?= $pefil_municipal_hide ?>">
                <div class="col-md-12">
                    <fieldset>
                        <legend>Perfil municipal</legend>
                        <div class="col-md-3">
                            <?= $form->field($model, 'qtd_populacao')->widget(NumberControl::className(), [
                                'maskedInputOptions' => [
                                    'groupSeparator' => '.',
                                    'radixPoint' => ',',
                                    'digits' => 0,
                                    'autoUnmask' => false,
                                    'unmaskAsNumber' => false,
                                ],
                            ])->label('Habitantes') ?>
                        </div>

                        <div class="col-md-3">
                            <?= $form->field($model, 'qtd_eleitor')->widget(NumberControl::className(), [
                                'maskedInputOptions' => [
                                    'groupSeparator' => '.',
                                    'radixPoint' => ',',
                                    'digits' => 0,
                                    'autoUnmask' => false,
                                    'unmaskAsNumber' => false,
                                ],
                            ])->label('Eleitores') ?>
                        </div>

                        <div class="col-md-2">
                            <?= $form->field($model, 'ano_populacao')->widget(YearSelectbox::className(), [
                                'yearStart' => 0,
                                'yearEnd' => -50,
                            ]) ?>
                        </div>

                        <div class="col-md-2">
                            <?= $form->field($model, 'fpm')->DropDownList([
                                0 => "0,4", 1 => "0,6", 2 => "0,8", 3 => "1,0", 4 => "1,2", 5 => "1,4", 6 => "1,6", 7 => "1,8", 8 => "2,0", 9 => "2,2", 10 => "2,4",
                                11 => "2,6", 12 => "2,8", 13 => "3,0", 14 => "3,2", 15 => "3,4", 16 => "3,6", 17 => "3,8", 18 => "4,0",],
                                ['class' => 'form-control', 'prompt' => 'Selecione'])->label('Índice FPM') ?>
                        </div>

                        <div class="col-md-2">
                            <?= $form->field($model, 'fpm_ano')->widget(YearSelectbox::className(), [
                                'yearStart' => 0,
                                'yearEnd' => -50,
                            ]) ?>
                        </div>
                    </fieldset>
                </div>
            </div>
            <br>
            <?php if ($model->isNewRecord) {
                $gestao_hide = 'hide';
            } else {
                if (strtolower($model->fkTipoCliente->descricao) == 'cliente' && strtolower($model->fkTipoOrgao->descricao) == 'prefeitura') {
                    $gestao_hide = '';
                } else {
                    $gestao_hide = 'hide';
                }
            } ?>
            <div class="row <?= $gestao_hide ?>" id="gestao">

                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12">
                            <fieldset>
                                <legend>Gestão</legend>
                                <div class="table-responsive">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <?= Html::button('Adicionar Gestão', ['class' => 'btn btn-info btn-rounded float-right', 'type' => 'button', 'id' => 'add-gestao-btn']) ?>
                                        </div>
                                    </div>


                                    <table class="table gestao table-bordered m-t-30 table-hover contact-list footable footable-5 footable-paging footable-paging-center breakpoint-lg">
                                        <thead>
                                        <tr>
                                            <th style="color: black; vertical-align: middle" class="text-center">Período
                                                da Gestão
                                            </th>
                                            <th style="color: black; vertical-align: middle" class="text-center">
                                                Prefeito
                                            </th>
                                            <th style="color: black; vertical-align: middle" class="text-center">Data
                                                Nascimento
                                            </th>
                                            <th style="color: black; vertical-align: middle" class="text-center">Vice
                                                Prefeito
                                            </th>
                                            <th style="color: black; vertical-align: middle" class="text-center">Ações
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody id="corpo-gestoes">
                                        <!--Update - Dados vindo do banco -->
                                        <?php foreach ($model->gestaos as $index => $gestao) { ?>
                                            <tr data-gestao="<?= $gestao->prefeito ?>"
                                                data-index-gestao="<?= $index ?>">
                                                <td>
                                                    <input type="hidden" name="Gestao[<?= $index ?>][periodo]"
                                                           value="<?= $gestao->periodo ?>"><?= $gestao->periodo ?>
                                                    <input type="hidden" name="Gestao[<?= $index ?>][id_edit_gestao]"
                                                           value="<?= $gestao->id ?>" id="id_edit_gestao">
                                                </td>
                                                <td>
                                                    <input type="hidden" name="Gestao[<?= $index ?>][prefeito]"
                                                           value="<?= $gestao->prefeito ?>"><?= $gestao->prefeito ?>
                                                </td>
                                                <td>
                                                    <input type="hidden" name="Gestao[<?= $index ?>][data_nascimento]"
                                                           value="<?= $gestao->data_nascimento ?>"><?= $gestao->data_nascimento ?>
                                                </td>
                                                <td>
                                                    <input type="hidden" name="Gestao[<?= $index ?>][vice_prefeito]"
                                                           value="<?= $gestao->vice_prefeito ?>"><?= $gestao->vice_prefeito ?>
                                                </td>
                                                <td class="text-center">
                                                    <button data-toggle="tooltip" data-placement="top" title="Editar"
                                                            type="button" type="button"
                                                            class="btn btn-rounded btn-primary btn-sm edit-gestao">
                                                        <i class="fa fa-pencil"></i>
                                                    </button>

                                                    <button data-toggle="tooltip" data-placement="top" title="Excluir"
                                                            type="button"
                                                            class=" btn btn-rounded btn-danger btn-sm delete-gestao">
                                                        <i class="fa fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        <?php } ?>

                                        <!--Se o formulário voltar na validação, carrega todos os contatos e telefones -->
                                        <?php if (!is_null($gestoes)) {
                                            foreach ($gestoes as $index => $gestao) { ?>
                                                <tr data-gestao="<?= $gestao->prefeito ?>"
                                                    data-index-gestao="<?= $index ?>">
                                                    <td>
                                                        <input type="hidden" name="Gestao[<?= $index ?>][periodo]"
                                                               value="<?= $gestao->periodo ?>"><?= $gestao->periodo ?>
                                                        <input type="hidden"
                                                               name="Gestao[<?= $index ?>][id_edit_gestao]"
                                                               value="<?= $gestao->id ?>" id="id_edit_gestao">
                                                    </td>
                                                    <td>
                                                        <input type="hidden" name="Gestao[<?= $index ?>][prefeito]"
                                                               value="<?= $gestao->prefeito ?>"><?= $gestao->prefeito ?>
                                                    </td>
                                                    <td>
                                                        <input type="hidden"
                                                               name="Gestao[<?= $index ?>][data_nascimento]"
                                                               value="<?= $gestao->data_nascimento ?>"><?= $gestao->data_nascimento ?>
                                                    </td>
                                                    <td>
                                                        <input type="hidden" name="Gestao[<?= $index ?>][vice_prefeito]"
                                                               value="<?= $gestao->vice_prefeito ?>"><?= $gestao->vice_prefeito ?>
                                                    </td>
                                                    <td class="text-center">
                                                        <button data-toggle="tooltip" data-placement="top"
                                                                title="Editar" type="button"
                                                                class="btn btn-rounded btn-primary btn-sm edit-gestao">
                                                            <i class="fa fa-pencil"></i></button>

                                                        <button data-toggle="tooltip" data-placement="top"
                                                                title="Excluir" type="button"
                                                                class="tooltip btn btn-rounded btn-danger btn-sm delete-gestao">
                                                            <i class="fa fa-trash tooltiptext"></i></button>
                                                    </td>
                                                </tr>
                                            <?php }
                                        } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>

            <br>
            <div class="col-md-12">
                <br>
                <div class="row">
                    <fieldset>
                        <legend>Contatos</legend>
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <div class="row">
                                    <div class="col-md-4">
                                        <?= Html::button('Adicionar Contato', ['class' => 'btn btn-info btn-rounded float-right', 'type' => 'button', 'id' => 'add-contato-btn']) ?>
                                    </div>
                                </div>
                                <table class="table table-bordered m-t-30 table-hover contact-list footable footable-5 footable-paging footable-paging-center breakpoint-lg">
                                    <thead>
                                    <tr>
                                        <th style="color: black" class="text-center table-xxs">
                                            <input type="text" class="form-control" placeholder="Nome"/>
                                        </th>
                                        <th style="color: black; vertical-align: middle" class="text-center">E-mail</th>
                                        <th style="color: black;padding-right: 60px;padding-left: 60px; vertical-align: middle"
                                            class="text-center">Telefones
                                        </th>
                                        <th style="color: black; vertical-align: middle" class="text-center">Data
                                            Nascimento
                                        </th>
                                        <th style="color: black; vertical-align: middle" class="text-center">Cargo</th>
                                        <th style="color: black; vertical-align: middle" class="text-center">
                                            Departamento
                                        </th>
                                        <th style="color: black; vertical-align: middle" class="text-center">Situação</th>
                                        <th style="color: black; vertical-align: middle" class="text-center">Ações</th>
                                    </tr>
                                    </thead>

                                    <tbody id="corpo-contatos">

                                    <!--Update - Dados vindo do banco -->
                                    <?php $index_telefone = 0;
                                    foreach ($model->contatoClientes as $index => $contato) { ?>
                                        <tr data-contato="<?= $contato->nome ?>" data-index="<?= $index ?>">
                                            <td>
                                            <span class="col-md-12"
                                                  onclick="file(this)">

                                                <?php
                                                $foto = null;

                                                if (is_null($contato->foto)) {
                                                    $foto = \yii\helpers\Url::to('@web/themes/eliteadmin/plugins/images/users/blank-user.jpg', true);
                                                } else {
                                                    $foto = $contato->foto;
                                                }
                                                ?>
                                                <div>
                                                    <div align="center">
                                                        <img src="<?= $foto ?>" alt="user-img" class="img-circle">
                                                    </div>
                                                    <div align="center">
                                                        <?= $contato->nome ?>
                                                    </div>
                                                    </div>
                                            </span>

                                                <input type="hidden" name="ContatoCliente[<?= $index ?>][nome]"
                                                       value="<?= $contato->nome ?>">
                                                <input type="hidden" name="ContatoCliente[<?= $index ?>][id_edit]"
                                                       value="<?= $contato->id ?>" id="id_edit">
                                                <input type="file" class="hide"
                                                       name="ContatoCliente[<?= $index ?>][foto]"
                                                       onchange="previewImage(this)">
                                                <input type="hidden" id="foto" value="<?= $foto ?>">
                                            </td>

                                            <td>
                                                <div align="center">
                                                    <?= $contato->email ?>
                                                </div>
                                                <input type="hidden" name="ContatoCliente[<?= $index ?>][email]"
                                                       value="<?= $contato->email ?>">
                                            </td>

                                            <td>
                                                <ul style="text-align: center; padding-left: 0px;">
                                                    <?php foreach ($contato->telefones as $telefoneContato) { ?>
                                                        <?php
                                                        $icon = null;
                                                        switch ($telefoneContato->fk_tipo_telefone) {
                                                            case 1:
                                                            {
                                                                $icon = 'fa fa-building';
                                                                break;
                                                            }
                                                            case 2:
                                                            {
                                                                $icon = 'fa fa-home';
                                                                break;
                                                            }
                                                            case 3:
                                                            {
                                                                $icon = 'fa fa-mobile';
                                                                break;
                                                            }
                                                            case 4:
                                                            {
                                                                $icon = 'fa fa-whatsapp';
                                                                break;
                                                            }
                                                            default:
                                                            {
                                                                $icon = 'fa fa-building';
                                                            }
                                                        }
                                                        ?>
                                                        <li style="list-style-type:none; padding:3px;"><i
                                                                    class="<?= $icon ?>"></i>
                                                            <?= $telefoneContato->telefone ?>

                                                            <input type="hidden"
                                                                   name="Telefone[<?= $index_telefone ?>][telefone]"
                                                                   value="<?= $telefoneContato->telefone ?>">
                                                            <input type="hidden"
                                                                   name="Telefone[<?= $index_telefone ?>][contato_index]"
                                                                   value="<?= $index ?>">
                                                            <input type="hidden"
                                                                   name="Telefone[<?= $index_telefone ?>][fk_tipo_telefone]"
                                                                   value="<?= $telefoneContato->fk_tipo_telefone ?>">
                                                            <button type="button"
                                                                    class="btn btn-rounded btn-xs delete-phone"><i
                                                                        class="fa fa-minus"></i>
                                                            </button>
                                                        </li> <?php $index_telefone++; ?>
                                                    <?php } ?>
                                                </ul>
                                            </td>
                                            <td>
                                                <?= $contato->data_nascimento ?>
                                                <input type="hidden"
                                                       name="ContatoCliente[<?= $index ?>][data_nascimento]"
                                                       value="<?= $contato->data_nascimento ?>" id="nascimento_id">
                                            </td>
                                            <td>
                                                <?= $contato->fkCargo->descricao ?>
                                                <input type="hidden" name="ContatoCliente[<?= $index ?>][fk_cargo]"
                                                       value="<?= $contato->fk_cargo ?>" id="cargo_id">

                                                <input type="hidden" name="ContatoCliente[<?= $index ?>][cargo]"
                                                       value="<?= $contato->fkCargo->descricao ?>" id="cargo_descricao">
                                            </td>
                                            <td>
                                                <?= $contato->fkDepartamento->descricao ?>
                                                <input type="hidden"
                                                       name="ContatoCliente[<?= $index ?>][fk_departamento]"
                                                       value="<?= $contato->fk_departamento ?>" id="departamento_id">

                                                <input type="hidden" name="ContatoCliente[<?= $index ?>][departamento]"
                                                       value="<?= $contato->fkDepartamento->descricao ?>"
                                                       id="departamento_descricao">
                                            </td>
                                            <td>
                                                <?= $contato->situacao == 1? 'Ativo' : 'Inativo' ?>
                                                <input type="hidden"
                                                       name="ContatoCliente[<?= $index ?>][situacao]"
                                                       value="<?= $contato->situacao ?>" id="situacao_id">
                                                <input type="hidden" name="ContatoCliente[<?= $index ?>][situacao]"
                                                       value="<?= $contato->situacao ?>" id="situacao_descricao">
                                            </td>
                                            <td class="text-center">
                                                <?php if ($contato->situacao == 1) { ?>
                                                    <button data-toggle="tooltip" data-placement="top" title="Editar"
                                                            type="button"
                                                            class="btn btn-rounded btn-primary btn-sm edit-item"><i
                                                                class="fa fa-pencil"></i>
                                                    </button>
                                                    <button data-toggle="tooltip" data-placement="top"
                                                            title="Cadastrar telefone" type="button"
                                                            class="btn btn-rounded btn-success btn-sm phone-item"><i
                                                                class="fa fa-phone"></i>
                                                    </button>
                                                    <button data-toggle="tooltip" data-placement="top" title="Excluir"
                                                            type="button"
                                                            class="btn btn-rounded btn-danger btn-sm delete-item"><i
                                                                class="fa fa-trash"></i>
                                                    </button>
                                                    <button data-toggle="tooltip" data-placement="left" title="Inativar"
                                                            type="button" type="button"
                                                            class="btn btn-rounded btn-secondary btn-sm inativar-item">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                <?php }else{ ?>
                                                    <button data-toggle="tooltip" data-placement="left" title="Reativar"
                                                            type="button" type="button"
                                                            class="btn btn-rounded btn-success btn-sm reativar-item">
                                                        <i class="fa fa-check-circle"></i>
                                                    </button>
                                                <?php } ?>
                                            </td>
                                        </tr>
                                    <?php } ?>

                                    <!--Se o formulário voltar na validação, carrega todos os contatos e telefones -->
                                    <?php $index_telefone = 0;
                                    if (!is_null($contatos)) {
                                        foreach ($contatos as $index => $contato) { ?>
                                            <tr data-contato="<?= $contato->nome ?>"
                                                data-index="<?= $index ?>">
                                                <td>
                                             <span class="col-md-12" onclick="file(this)">
                                                <?php $foto = null;
                                                if (is_null($contato->foto)) {
                                                    $foto = \yii\helpers\Url::to('@web/themes/eliteadmin/plugins/images/users/blank-user.jpg', true);
                                                } else {
                                                    $foto = $contato->foto;
                                                } ?>
                                                 <img src="<?= $foto ?>"
                                                      alt="user-img" class="img-circle"> <?= $contato->nome ?>
                                            </span>

                                                    <input type="hidden" name="ContatoCliente[<?= $index ?>][nome]"
                                                           value="<?= $contato->nome ?>">

                                                    <input type="hidden" name="ContatoCliente[<?= $index ?>][id_edit]"
                                                           value="<?= $contato->id ?>" id="id_edit">
                                                    <input type="file" class="hide"
                                                           name="ContatoCliente[<?= $index ?>][foto]"
                                                           onchange="previewImage(this)">
                                                    <input type="hidden" id="foto" value="<?= $foto ?>">
                                                </td>
                                                <td>
                                                    <?= $contato->email ?>
                                                    <input type="hidden" name="ContatoCliente[<?= $index ?>][email]"
                                                           value="<?= $contato->email ?>">
                                                </td>
                                                <td>
                                                    <ul>
                                                        <?php if (!is_null($telefones)) {
                                                            foreach ($telefones as $telefone) { ?>
                                                                <?php if ($telefone->fk_contato_cliente == $contato->nome) {
                                                                    $icon = null;
                                                                    switch ($telefone->fk_tipo_telefone) {
                                                                        case 1:
                                                                        {
                                                                            $icon = 'fa fa-building';
                                                                            break;
                                                                        }
                                                                        case 2:
                                                                        {
                                                                            $icon = 'fa fa-home';
                                                                            break;
                                                                        }
                                                                        case 3:
                                                                        {
                                                                            $icon = 'fa fa-mobile';
                                                                            break;
                                                                        }
                                                                        case 4:
                                                                        {
                                                                            $icon = 'fa fa-whatsapp';
                                                                            break;
                                                                        }
                                                                        default:
                                                                        {
                                                                            $icon = 'fa fa-building';
                                                                        }
                                                                    }
                                                                    ?>
                                                                    <li style="list-style-type:none;"><i
                                                                                class="<?= $icon ?>"></i>
                                                                        <?= $telefone->telefone ?>
                                                                        <input type="hidden"
                                                                               name="Telefone[<?= $index_telefone ?>][telefone]"
                                                                               value="<?= $telefone->telefone ?>">
                                                                        <input type="hidden"
                                                                               name="Telefone[<?= $index_telefone ?>][contato_index]"
                                                                               value="<?= $index ?>">
                                                                        <input type="hidden"
                                                                               name="Telefone[<?= $index_telefone ?>][fk_tipo_telefone]"
                                                                               value="<?= $telefone->fk_tipo_telefone ?>">
                                                                        <button type="button"
                                                                                class="btn btn-rounded btn-xs delete-phone">
                                                                            <i
                                                                                    class="fa fa-minus"></i>
                                                                        </button>
                                                                    </li> <?php $index_telefone++; ?>
                                                                <?php }
                                                            }
                                                        } ?>
                                                    </ul>
                                                </td>
                                                <td>
                                                    <?= $contato->data_nascimento ?>
                                                    <input type="hidden"
                                                           name="ContatoCliente[<?= $index ?>][data_nascimento]"
                                                           value="<?= $contato->data_nascimento ?>" id="nascimento_id">
                                                </td>
                                                <td>
                                                    <?= $contato->fkCargo->descricao ?>
                                                    <input type="hidden" name="ContatoCliente[<?= $index ?>][fk_cargo]"
                                                           value="<?= $contato->fk_cargo ?>" id="cargo_id">

                                                    <input type="hidden" name="ContatoCliente[<?= $index ?>][cargo]"
                                                           value="<?= $contato->fkCargo->descricao ?>"
                                                           id="cargo_descricao">
                                                </td>
                                                <td>
                                                    <?= $contato->fkDepartamento->descricao ?>
                                                    <input type="hidden"
                                                           name="ContatoCliente[<?= $index ?>][fk_departamento]"
                                                           value="<?= $contato->fk_departamento ?>"
                                                           id="departamento_id">

                                                    <input type="hidden"
                                                           name="ContatoCliente[<?= $index ?>][departamento]"
                                                           value="<?= $contato->fkDepartamento->descricao ?>"
                                                           id="departamento_descricao">
                                                </td>
                                                <td>
                                                    <?= $contato->situacao == 1? 'Ativo' : 'Inativo'?>
                                                    <input type="hidden"
                                                           name="ContatoCliente[<?= $index ?>][situacao]"
                                                           value="<?= $contato->situacao ?>" id="situacao_id">
                                                    <input type="hidden" name="ContatoCliente[<?= $index ?>][situacao]"
                                                           value="<?= $contato->situacao ?>" id="situacao_descricao">
                                                </td>

                                                <td class="text-center">
                                                    <?php if ($contato->situacao == 1) { ?>
                                                    <button data-toggle="tooltip" data-placement="top" title="Editar"
                                                            type="button"
                                                            class="btn btn-rounded btn-primary btn-sm edit-item"><i
                                                                class="fa fa-pencil"></i>
                                                    </button>
                                                    <button data-toggle="tooltip" data-placement="top"
                                                            title="Cadastrar telefone" type="button"
                                                            class="btn btn-rounded btn-success btn-sm phone-item"><i
                                                                class="fa fa-phone"></i>
                                                    </button>
                                                    <button data-toggle="tooltip" data-placement="top" title="Excluir"
                                                            type="button"
                                                            class="btn btn-rounded btn-danger btn-sm delete-item"><i
                                                                class="fa fa-trash"></i>
                                                    </button>
                                                    <button data-toggle="tooltip" data-placement="left" title="Inativar"
                                                            type="button" type="button"
                                                            class="btn btn-rounded btn-secondary btn-sm inativar-item">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                    <?php }else{ ?>
                                                    <button data-toggle="tooltip" data-placement="left" title="Reativar"
                                                            type="button" type="button"
                                                            class="btn btn-rounded btn-success btn-sm reativar-item">
                                                        <i class="fa fa-check-circle"></i>
                                                    </button>
                                                    <?php } ?>
                                                </td>
                                            </tr>
                                        <?php }
                                    } ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>

        <div role="tabpanel" class="tab-pane <?= is_null($view) ? '' : 'active' ?>" id="anexo">
            <div class="row">

                <?php DynamicFormWidget::begin([
                    'widgetContainer' => 'dynamicform_wrapper_anexo', // required: only alphanumeric characters plus "_" [A-Za-z0-9_]
                    'widgetBody' => '.container-anexo', // required: css class selector
                    'widgetItem' => '.anexo', // required: css class
                    'limit' => 10, // the maximum times, an element can be cloned (default 999)
                    'min' => 0, // 0 or 1 (default 1)
                    'insertButton' => '.add-anexo', // css class
                    'deleteButton' => '.remove-anexo', // css class
                    'model' => $modelsAnexoDocumento[0],
                    'formId' => 'form-cliente',
                    'formFields' => [
                        'fk_tipo_anexo',
                        'anexo',
                    ],
                ]); ?>

                <div class="container-anexo"><!-- widgetContainer -->
                    <?= Html::button('Adicionar', ['class' => 'add-anexo btn btn-sm btn-info btn-rounded m-t-10 float-right', 'type' => 'button']) ?>
                    <hr>
                    <?php foreach ($modelsAnexoDocumento as $i => $modelAnexoDocumento): ?>
                        <div class="anexo panel panel-default"><!-- widgetBody -->
                            <?php
                            // necessary for update action.
                            if (!$modelAnexoDocumento->isNewRecord) {
                                echo Html::activeHiddenInput($modelAnexoDocumento, "[{$i}]id");
                            }
                            ?>
                            <div class="row">
                                <div class="col-sm-3">
                                    <?= $form->field($modelAnexoDocumento, "[{$i}]fk_tipo_documento")->widget(\kartik\select2\Select2::className(), [
                                        'theme' => 'bootstrap',
                                        'options' => ['placeholder' => 'Selecione'],
                                        'pluginOptions' => ['allowClear' => true],
                                        'language' => 'pt-BR',
                                        'data' => \yii\helpers\ArrayHelper::map(\app\models\TipoAnexo::find()->findTipoAnexoByEntidade()->orderBy([\app\models\TipoAnexo::tableName() . '.descricao' => SORT_ASC])->asArray()->all(), 'id', 'descricao'),
                                    ])->label('Tipo Anexo') ?>
                                </div>

                                <div class="col-md-3">
                                    <?= $form->field($modelAnexoDocumento, "[{$i}]anexo")->widget(FileInput::classname(), [
                                        'options' => ['multiple' => true],
                                        'language' => 'pt',
                                        'pluginOptions' => [
                                            'showUpload' => false,
                                            'showPreview' => false,
                                            'showRemove' => true,
                                            'browseLabel' => '',
                                            'removeLabel' => '',
                                            'initialCaption' => empty($modelAnexoDocumento->anexo) ? '' : explode('/', $modelAnexoDocumento->anexo)[7],
                                        ],
                                    ]) ?>
                                </div>

                                <div class="col-md-3">
                                    <?= Html::button('Remover', ['class' => 'remove-anexo btn btn-sm btn-danger btn-rounded m-t-30 float-right', 'type' => 'button']) ?>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
                <?php DynamicFormWidget::end(); ?>
            </div>
        </div>

        <div class="form-group">
            <?= Html::submitButton(Yii::t('app', 'Salvar'), ['class' => 'btn btn-success button-margin margin-top']) ?>
        </div>
        <?php ActiveForm::end(); ?>
    </div>
</div>

<div class="modal fade" id="telefone-modal" tabindex="-1" role="dialog" aria-labelledby="telefone-modal-label">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="telefone-modal-label" style="color:white">Cadastrar Telefone</h4>
            </div>
            <div id="content-telefone">

                <?php $form = ActiveForm::begin(['id' => 'telefone-form']); ?>

                <div class="modal-body">
                    <?= $form->field($modelTelefone, 'fk_contato_cliente')->textInput(['maxlength' => true, 'class' => 'hidden', 'name' => ''])->label(false) ?>

                    <div class="row">
                        <div class="col-md-12">
                            <?= $form->field($modelTelefone, 'fk_tipo_telefone')->widget(Select2::classname(), [
                                'theme' => 'bootstrap',
                                'language' => 'pt-BR',
                                'options' => ['placeholder' => 'Selecione', 'name' => ''],
                                'data' => \app\modules\Helper::map(\app\models\TipoTelefone::find()->findTipoTelefoneByEntidade()->asArray()->all(), 'id', 'descricao')
                            ]); ?>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <?= $form->field($modelTelefone, 'telefone')->widget(\yii\widgets\MaskedInput::className(), [
                                'mask' => ['(99) 9999-9999', '(99) 99999-9999']
                            ]) ?>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">

                    <?= Html::button('Adicionar', ['class' => 'btn btn-success waves-effect', 'type' => 'button', 'id' => 'add-telefone-btn']) ?>
                    <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Fechar</button>
                </div>
                <?php ActiveForm::end(); ?>
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="contato-modal" tabindex="-1" role="dialog" aria-labelledby="contato-modal-label">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="contato-modal-label" style="color: white">Contato</h4>
            </div>
            <div id="content-telefone">

                <?php $form = ActiveForm::begin(['id' => 'contato-form']); ?>

                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <?= $form->field($model, 'situacao')->DropDownList([
                                1 => 'Ativo',
                                0 => 'Inativo',],
                                ['class' => 'form-control hide', 'prompt' => 'Selecione', 'id' => 'id-situacao-select'])->label(false) ?>
                        </div>
                        <div class="col-md-12">
                            <?= $form->field($modelContato, 'nome')->textInput(['maxlength' => true, 'name' => '']) ?>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <?= $form->field($modelContato, 'email')->textInput(['maxlength' => true, 'name' => '']) ?>
                        </div>
                        <div class="col-md-6">
                            <?= $form->field($modelContato, 'data_nascimento')->widget(\kartik\daterange\DateRangePicker::className(), [
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
                        <div class="col-md-6">
                            <?= $form->field($modelContato, 'fk_cargo')->widget(\kartik\select2\Select2::className(), [
                                'theme' => 'bootstrap',
                                'language' => 'pt-BR',
                                'data' => \app\modules\Helper::map(\app\models\Cargo::find()->asArray()->all(), 'id', 'descricao'),
                                'options' => ['placeholder' => $modelContato->cargo],
                                'pluginOptions' => [
                                    'allowClear' => true,
                                ],
                                'pluginEvents' => [
                                    "select2:open" => "function() { 
                                if($(\"#new-cargo\").length === 0){ 
                                    $(\".select2-results\").find('button').remove();
                                    $(\".select2-results:not(:has(a))\").append('<button class=\"btn btn-success pull-right\" id=\"new-cargo\" data-target=\"#modal-add-cargo\" data-toggle=\"modal\"><i class=\"fa fa-plus\"></i> Criar novo cargo</button>'); 
                                }else{
                                    $(\".select2-results\").find('button:not(#new-cargo)').remove();
                                }
                            }",
                                ]
                            ])->label('Cargo') ?>
                        </div>
                        <div class="col-md-6">
                            <?= $form->field($modelContato, 'fk_departamento')->widget(\kartik\select2\Select2::className(), [
                                'theme' => 'bootstrap',
                                'language' => 'pt-BR',
                                'data' => \app\modules\Helper::map(\app\models\Departamento::find()->asArray()->all(), 'id', 'descricao'),
                                'options' => ['placeholder' => $modelContato->departamento],
                                'pluginOptions' => [
                                    'allowClear' => true,
                                ],
                                'pluginEvents' => [
                                    "select2:open" => "function() { 
                                if($(\"#new-departamento\").length === 0){ 
                                    $(\".select2-results\").find('button').remove();
                                    $(\".select2-results:not(:has(a))\").append('<button class=\"btn btn-success pull-right\" id=\"new-departamento\" data-target=\"#modal-add-departamento\" data-toggle=\"modal\"><i class=\"fa fa-plus\"></i> Criar novo departamento</button>'); 
                                }else{
                                    $(\".select2-results\").find('button:not(#new-departamento)').remove();
                                }
                               }",
                                ]
                            ])->label('Departamento') ?>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Fechar</button>
                    <?= Html::button('Adicionar', ['class' => 'btn btn-success waves-effect', 'type' => 'button', 'id' => 'save-contato-btn']) ?>
                </div>
                <?php ActiveForm::end(); ?>
            </div>

        </div>
    </div>
</div>

<div class="modal" id="modal-add-cargo">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Adicionar Cargo</h4>
            </div>
            <div class="modal-ajax">
                <?= $this->render('//cargo/_form_modal', [
                    'model' => new \app\models\Cargo()
                ]) ?>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="modal-add-departamento">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Adicionar departamento</h4>
            </div>
            <div class="modal-ajax">
                <?= $this->render('//Departamento/_form_modal', [
                    'model' => new \app\models\Departamento()
                ]) ?>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="gestao-modal" tabindex="-1" role="dialog" aria-labelledby="gestao-modal-label">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="gestao-modal-label" style="color: white">Gestão</h4>
            </div>
            <div id="content-gestao">

                <?php $form = ActiveForm::begin(['id' => 'gestao-form']); ?>

                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <?= $form->field($modelGestao, 'from')->widget(\kartik\daterange\DateRangePicker::className(), [
                                'options' => ['name' => ''],
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
                            ])->label('Período: De') ?>
                        </div>

                        <div class="col-md-6">
                            <?= $form->field($modelGestao, 'to')->widget(\kartik\daterange\DateRangePicker::className(), [
                                'options' => ['name' => ''],
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

                            ])->label('à') ?>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8">
                            <?= $form->field($modelGestao, 'prefeito')->textInput(['maxlength' => true, 'name' => '']) ?>
                        </div>
                        <div class="col-md-4">
                            <?= $form->field($modelGestao, 'data_nascimento')->widget(\kartik\daterange\DateRangePicker::className(), [
                                'options' => ['name' => ''],
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
                            <?= $form->field($modelGestao, 'vice_prefeito')->textInput(['maxlength' => true, 'name' => '']) ?>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <?= Html::button('Adicionar', ['class' => 'btn btn-success waves-effect', 'type' => 'button', 'id' => 'save-gestao-btn']) ?>
                    <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Fechar</button>
                </div>
                <?php ActiveForm::end(); ?>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="modal-form">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
        </div>
    </div>
</div>

<div class="modal" id="modal-list">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
        </div>
    </div>
</div>

<div class="modal" id="modal-view">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
        </div>
    </div>
</div>
