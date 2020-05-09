<?php

use yii\helpers\Html;
use yii\widgets\DetailView;
use kartik\grid\GridView;

use yii\helpers\Url;

/* @var $this yii\web\View */
/* @var $model app\models\Atendimento */

$this->title = 'Visualizar';
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Atendimentos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $model->id;
//$modelsAnexo = \app\modelsx\AtendimentoAnexos::find()->asArray()->where(['fk_atendimento' => $model->id]);
?>
<div class="atendimento-view">

    <p>
        <?= Html::a('Atualizar', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Deletar', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Tem certeza que deseja deletar este item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            [
                'contentOptions' => ['style' => 'width: 80%'],
                'attribute' => 'fk_cliente',
                'label' => 'Cliente',
                'value' => $model->fkCliente->razao_social,
            ],
            [
                'label' => 'Data do atendimento',
                'attribute' => 'data_atendimento'
            ],
            [
                'label' => 'Contato',
                'attribute' => 'fk_contato_cliente',
                'value' => $model->fkContatoCliente->email,
            ],
            [
                'label' => 'Usuario do atendimento',
                'attribute' => 'fk_usuario',
                'value' => $model->fkUsuario->nome_completo,
            ],
            [
                'label' => 'Número do contrato',
                'attribute' => 'fk_contrato',
                'value' => $model->fkContrato->numero,
            ],
            [
                'label' => 'Produto',
                'attribute' => 'fk_produto',
                'value' => $model->fkProduto->descricao,
            ],
            [
                'label' => 'Tipo de atendimento',
                'attribute' => 'fk_tipo_atendimento',
                'value' => $model->fkTipoAtendimento->descricao,
            ],
            [
                'label' => 'Tipo de ocorrência',
                'attribute' => 'fk_tipo_ocorrencia',
                'value' => $model->fkTipoOcorrencia->descricao,
            ],
            [
                'label' => 'Usuário da solução',
                'attribute' => 'fk_usuario_solucao',
                'value' => $model->solucao != null ? $model->fkUsuarioSolucao->username : $model->fk_usuario_solucao,
            ],
            [
                'label' => 'Solicitação',
                'attribute' => 'solicitacao',
            ],
            [
                'label' => 'Data da solução',
                'attribute' => 'data_solucao',
                //'value' => $model->->descricao,
                'visible' => $model->solucao != null,
            ],
            [
                'label' => 'Solução',
                'attribute' => 'solucao',
                'visible' => $model->solucao != null,
            ],
            [
                'label' => 'Número do atendimento',
                'attribute' => 'numero_atendimento',
            ],
            [
                'attribute' => 'status',
                'format' => 'raw',
                'value' => function ($model) {
                    switch ($model->status) {
                        case 0:
                            {
                                $class = 'info';
                                break;
                            }
                        case 1:
                            {
                                $class = 'success';
                                break;
                            }
                        case 2:
                            {
                                $class = 'danger';
                                break;
                            }
                    }

                    return \yii\helpers\Html::tag('span', \app\models\Atendimento::$statusDesc[$model->status], ['class' => 'label label-' . $class]);
                }
            ],
            [
                'label' => 'Usuário do cancelamento',
                'attribute' => 'fk_usuario_cancelamento',
                //   'value' => $model->fkUsuarioCancelamento->username,
                'visible' => $model->motivo != null,
            ],
            [
                'label' => 'Motivo do cancelamento',
                'attribute' => 'motivo',
                'visible' => $model->motivo != null,
            ],
            [
                'label' => 'Data do cancelamento',
                'attribute' => 'data_cancelamento',
                'visible' => $model->motivo != null,
            ],
            [
                'label' => 'Data prevista',
                'attribute' => 'data_prevista',
            ],
        ],
    ]) ?>

    <?php if (!empty($modelsAnexo)) { ?>

        <?= \kartik\detail\DetailView::widget([
            'model' => $model,
            'mode' => 'view',
            'hAlign' => 'rigth',
            'vAlign' => 'middle',
            'panel' => false,
            'attributes' => [
                [
                    'group' => true,
                    'label' => 'Anexos',
                    'groupOptions' => ['class' => 'text-bold text-center'],
                ],
            ]
        ]) ?>

        <div id="table-anexos" class="table-responsive pre-scrollable table-xxs">
            <table class="table table-striped table-bordered toggle-circle table-hover table-xxs">
                <thead>
                <tr>
                    <th class="col-md-2 text-center">Descrição</th>
                    <th class="col-md-2 text-center">Anexo</th>
                </tr>
                </thead>

                <?php foreach ($modelsAnexo as $modelAnexo) { ?>
                    <tr>
                        <td><?= $modelAnexo->descricao ?></td>
                        <td style="text-align: center"><a href='<?= '/web/img/' . $modelAnexo->anexo ?>' download>
                                <button data-toggle="tooltip" data-placement="top" title="Download" type="button"
                                        type="button" class="btn btn-rounded btn-info btn-sm"><i
                                            class="fa fa-arrow-down"></i></button>
                            </a></td>
                    </tr>
                <?php } ?>
            </table>
        </div>
    <?php } ?>
</div>

