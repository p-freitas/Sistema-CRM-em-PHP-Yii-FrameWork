<?php

use yii\helpers\Html;
use kartik\detail\DetailView;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Cliente */

$this->title = 'Visualizar';
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Clientes'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $model->razao_social;

\app\assets\DatatablesAsset::register($this);
$this->registerJsFile('@web/js/contato.js', ['depends' => [\yii\web\JqueryAsset::className()]]);

?>
<div class="cliente-view">


    <p>
        <?= Html::a(Yii::t('app', 'Atualizar'), ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a(Yii::t('app', 'Deletar'), ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => Yii::t('app', 'Are you sure you want to delete this item?'),
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'krajeeDialogSettings' => ['overrideYiiConfirm' => false],
        'hAlign' => 'rigth',
        'vAlign' => 'middle',
        'panel' => false,
        'attributes' => [
            [
                'group' => true,
                'label' => 'Entidade',
                'groupOptions' => ['class' => 'text-bold text-center'],
            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Empresa',
                            'value' => $model->fkEntidade->razao_social,
                            'visible' => \Yii::$app->user->isSuperadmin,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 80%'],
                        ],
                    ]

            ],
            [
                'columns' =>
                    [

                        [
                            'label' => 'CPF/CNPJ',
                            'attribute' => 'cpf_cnpj',
                            'value' => $model->cpf_cnpj,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                        [
                            'label' => 'Razão Social',
                            'attribute' => 'razao_social',
                            'value' => $model->razao_social,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]

            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'E-mail',
                            'value' => $model->email,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 80%'],
                        ],
                    ]

            ],
            [
                'columns' =>
                    [

                        [
                            'label' => 'CEP',
                            'attribute' => 'cep',
                            'value' => $model->cep,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                        [
                            'label' => 'Estado',
                            'attribute' => 'estado',
                            'value' => $model->estado,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],

                    ]

            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Cidade',
                            'attribute' => 'cidade',
                            'value' => $model->cidade,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Bairro',
                            'attribute' => 'bairro',
                            'value' => $model->bairro,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],

                    ]

            ],

            [
                'columns' =>
                    [

                        [
                            'label' => 'Endereço',
                            'attribute' => 'endereco',
                            'value' => $model->endereco,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                        [
                            'label' => 'Complemento',
                            'attribute' => 'complemento',
                            'value' => $model->complemento,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]

            ],

            [
                'columns' =>
                    [

                        [
                            'label' => 'Tipo orgão',
                            'attribute' => 'fkTipoOrgao',
                            'value' => $model->fkTipoOrgao->descricao,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                        [
                            'label' => 'Tipo entidade',
                            'attribute' => 'fkTipoCliente',
                            'value' => $model->fkTipoCliente->descricao,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]

            ],

            [
                'columns' =>
                    [

                        [
                            'label' => 'Data Cadastro',
                            'attribute' => 'data_cadastro',
                            'value' => $model->data_cadastro,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 15%'],
                        ],
                        [
                            'label' => 'Data Situação',
                            'attribute' => 'data_situacao',
                            'value' => $model->data_situacao,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 20%'],
                        ],
                        [
                            'label' => 'Situação',
                            'attribute' => 'situacao',
                            'value' => $model->situacao == 1 ? 'Ativo' : 'Inativo',
                            'labelColOptions' => ['style' => 'width: 15%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 20%'],
                        ],
                    ]

            ],

            [
                'columns' =>
                    [

                        [
                            'label' => 'Habitantes',
                            'attribute' => 'qtd_populacao',
                            'visible' => (strtolower($model->fkTipoCliente->descricao) == 'cliente' && strtolower($model->fkTipoOrgao->descricao) == 'prefeitura' ) ? true : false,
                            'value' => $model->qtd_populacao,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 15%'],
                        ],
                        [
                            'label' => 'Eleitores',
                            'attribute' => 'qtd_eleitor',
                            'visible' => (strtolower($model->fkTipoCliente->descricao) == 'cliente' && strtolower($model->fkTipoOrgao->descricao) == 'prefeitura' ) ? true : false,
                            'value' => $model->qtd_eleitor,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 20%'],
                        ],
                        [
                            'label' => 'Ano população',
                            'attribute' => 'ano_populacao',
                            'visible' => (strtolower($model->fkTipoCliente->descricao) == 'cliente' && strtolower($model->fkTipoOrgao->descricao) == 'prefeitura' ) ? true : false,
                            'value' => $model->ano_populacao,
                            'labelColOptions' => ['style' => 'width: 15%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 20%'],
                        ],
                    ]

            ],

            [
                'columns' =>
                    [

                        [
                            'label' => 'Índice FPM',
                            'attribute' => 'fpm',
                            'visible' => (strtolower($model->fkTipoCliente->descricao) == 'cliente' && strtolower($model->fkTipoOrgao->descricao) == 'prefeitura' ) ? true : false,
                            'value' => $model->fpm,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                        [
                            'label' => 'Ano FPM',
                            'attribute' => 'fpm_ano',
                            'visible' => (strtolower($model->fkTipoCliente->descricao) == 'cliente' && strtolower($model->fkTipoOrgao->descricao) == 'prefeitura' ) ? true : false,
                            'value' => $model->fpm_ano,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],

                        ],
                    ]

            ],
            [
                'columns' =>
                    [

                        [
                            'label' => 'Anexos',
                            'format' => 'raw',
                            'visible' => ($model->anexosDocumentos) ? true : false,
                            'value' => function ($form, $widget) {
                                $model = $widget->model;
                                $anexos = $model->anexosDocumentos;
                                $anexo_list = null;
                                foreach ($anexos as $anexo) {
                                    $anexo_list .= '<a href=' . $anexo->anexo . ' target="blank" ><li>' . $anexo->fkTipoDocumento->descricao . '</li></a>';
                                }
                                return $anexo_list;
                            },
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 80%; padding-left:20px']
                        ],
                    ]
            ],
        ],
    ]) ?>

    <br>
    <br>
        <?php $contatos = $model->contatoClientes;
        if (!empty($contatos)) { ?>
            <?= DetailView::widget([
                'model' => $model,
                'krajeeDialogSettings' => ['overrideYiiConfirm' => false],
                'mode' => 'view',
                'hAlign' => 'rigth',
                'vAlign' => 'middle',
                'panel' => false,
                'attributes' => [
                    [
                        'group' => true,
                        'label' => 'Contatos',
                        'groupOptions' => ['class' => 'text-bold text-center'],
                    ],
                ]

            ]) ?>

            <div class="row">
                <div class="col-md-12">
                    <div id="table-contatos" class="table-responsive pre-scrollable table-xxs">
                        <table style="margin-top: 0px;" class="table table-bordered table-hover contact-list footable footable-5 footable-paging footable-paging-center breakpoint-lg table-hover table-xxs">
                            <thead>
                            <tr>
                                <th style="color: black" class="text-center">
                                    <input type="text" class="form-control" placeholder="Nome"/>
                                </th>
                                <th style="color: black; vertical-align: middle" class="text-center">E-mail
                                </th>
                                <th style="color: black; vertical-align: middle" class="text-center">Telefones
                                </th>
                                <th style="color: black; vertical-align: middle" class="text-center">Cargo
                                </th>
                                <th style="color: black; vertical-align: middle" class="text-center">Departamento
                                </th>
                            </tr>
                            </thead>
                            <tbody id="corpo-contatos">
                            <?php $index_telefone = 0;
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
                                             <img src="<?= $foto ?>" alt="user-img"
                                                  class="img-circle"> <?= $contato->nome ?>
                                        </span>
                                    </td>
                                    <td>
                                        <?= $contato->email ?>
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
                                                <li style="list-style-type:none;"><i class="<?= $icon ?>"></i>
                                                    <?= $telefoneContato->telefone ?>
                                                </li> <?php $index_telefone++; ?>
                                            <?php } ?>
                                        </ul>
                                    </td>
                                    <td style="text-align: center">
                                        <?= $contato->fkCargo->descricao ?>
                                    </td>
                                    <td style="text-align: center">
                                        <?= $contato->fkDepartamento->descricao ?>
                                    </td>
                                </tr>

                            <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        <?php } ?>



    <br>
    <br>
    <?php $gestoes = $model->gestaos;
    if (!empty($gestoes)) { ?>
        <?= DetailView::widget([
            'model' => $model,
            'mode' => 'view',
            'hAlign' => 'rigth',
            'vAlign' => 'middle',
            'panel' => false,
            'attributes' => [
                [
                    'group' => true,
                    'label' => 'Gestão',
                    'groupOptions' => ['class' => 'text-bold text-center'],
                ],
            ]

        ]) ?>

        <div class="row">
            <div class="col-md-12">
                <div id="table-contatos" class="table-responsive pre-scrollable table-xxs">
                    <table style="margin-top: 0px;" class="table table-bordered table-hover contact-list footable footable-5 footable-paging footable-paging-center breakpoint-lg table-hover table-xxs">
                        <thead>
                        <tr>
                            <th style="color: black; vertical-align: middle; text-align: center" class="text-center">
                                Período
                                da
                                Gestão
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
                        </tr>
                        </thead>
                        <tbody id="corpo-gestoes">
                        <!--Se o formulário voltar na validação, carrega todos os contatos e telefones -->
                        <?php if (!is_null($gestoes)) {
                            foreach ($gestoes as $index => $gestao) { ?>
                                <tr data-gestao="<?= $gestao->prefeito ?>"
                                    data-index-gestao="<?= $index ?>">
                                    <td style="text-align: center">
                                        <input type="hidden" name="Gestao[<?= $index ?>][periodo]"
                                               value="<?= $gestao->periodo ?>"><?= $gestao->periodo ?>
                                        <input type="hidden"
                                               name="Gestao[<?= $index ?>][id_edit_gestao]"
                                               value="<?= $gestao->id ?>" id="id_edit_gestao">
                                    </td>
                                    <td style="text-align: center">
                                        <input type="hidden" name="Gestao[<?= $index ?>][prefeito]"
                                               value="<?= $gestao->prefeito ?>"><?= $gestao->prefeito ?>
                                    </td>
                                    <td style="text-align: center">
                                        <input type="hidden"
                                               name="Gestao[<?= $index ?>][data_nascimento]"
                                               value="<?= $gestao->data_nascimento ?>"><?= $gestao->data_nascimento ?>
                                    </td>
                                    <td style="text-align: center">
                                        <input type="hidden" name="Gestao[<?= $index ?>][vice_prefeito]"
                                               value="<?= $gestao->vice_prefeito ?>"><?= $gestao->vice_prefeito ?>
                                    </td>
                                </tr>
                            <?php }
                        } ?>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    <?php } ?>


</div>
