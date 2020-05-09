<?php
/**
 * Created by PhpStorm.
 * User: keep-to
 * Date: 13/11/17
 * Time: 10:05
 */

namespace app\modules;


use app\models\Protocolo;
use app\models\Usuario;
use yii\helpers\Html;

class ButtonsHelper
{
    public static function buttonsMovimentacao($model)
    {
        $ultima_movimentacao = $model->ultimaMovimentacao;

        if ($ultima_movimentacao->fk_responsavel_destino || (is_null($ultima_movimentacao->fk_responsavel_destino) && $ultima_movimentacao->fk_lotacao_destino === \Yii::$app->user->lotacao)) {
            return \yii\bootstrap\ButtonDropdown::widget([
                'encodeLabel' => false,
                'label' => 'Ações ' . Html::tag('span', '', ['class' => 'caret m-l-5', 'style' => 'display:inline-block']),
                'dropdown' => [
                    'encodeLabels' => false,
                    'items' => [
                        [
                            'label' => '<i class="fa fa-thumbs-up"></i> Deferir',
                            'url' => '#modal-movimentacao',
                            'linkOptions' => [
                                'onclick' => 'clickMovimentacao(this)',
                                'data' => [
                                    'action' => 'deferir',
                                    'id' => $model->id
                                ]
                            ],
                            'visible' => $model->status === Protocolo::STATUS_ANDAMENTO
                        ],
                        [
                            'label' => '<i class="fa fa-thumbs-down"></i> Indeferir',
                            'url' => '#modal-movimentacao',
                            'linkOptions' => [
                                'onclick' => 'clickMovimentacao(this)',
                                'data' => [
                                    'action' => 'indeferir',
                                    'id' => $model->id
                                ]
                            ],
                            'visible' => $model->status === Protocolo::STATUS_ANDAMENTO
                        ],
                        [
                            'label' => '<i class="fa fa-exchange"></i> Encaminhar',
                            'url' => '#modal-movimentacao',
                            'linkOptions' => [
                                'onclick' => 'clickMovimentacao(this)',
                                'data' => [
                                    'action' => 'encaminhar',
                                    'id' => $model->id
                                ]
                            ],
                            'visible' => $model->status === Protocolo::STATUS_ANDAMENTO
                        ],
                        [
                            'label' => '<i class="fa fa-ban"></i> Recusar',
                            'url' => '#modal-movimentacao',
                            'linkOptions' => [
                                'onclick' => 'clickMovimentacao(this)',
                                'data' => [
                                    'action' => 'recusar',
                                    'id' => $model->id
                                ]
                            ],
                            'visible' => $model->status === Protocolo::STATUS_ANDAMENTO
                        ],
                        [
                            'label' => '<i class="fa fa-clock-o"></i> Agendar',
                            'url' => '#modal-movimentacao',
                            'linkOptions' => [
                                'onclick' => 'clickMovimentacao(this)',
                                'data' => [
                                    'action' => 'agendar',
                                    'id' => $model->id
                                ]
                            ],
                            'visible' => $model->status === Protocolo::STATUS_ANDAMENTO
                        ],
                        [
                            'label' => '<i class="fa fa-unlock-alt"></i> Reabrir',
                            'url' => '#modal-movimentacao',
                            'linkOptions' => [
                                'onclick' => 'clickMovimentacao(this)',
                                'data' => [
                                    'action' => 'reabrir',
                                    'id' => $model->id
                                ]
                            ],
                            'visible' => $model->status === Protocolo::STATUS_ARQUIVADO
                        ],
                        [
                            'label' => '<i class="fa fa-times"></i> Cancelar',
                            'url' => '#modal-movimentacao',
                            'linkOptions' => [
                                'onclick' => 'clickMovimentacao(this)',
                                'data' => [
                                    'action' => 'cancelar',
                                    'id' => $model->id
                                ]
                            ],
                            'visible' => Usuario::hasRole(['usuarioProtocolador', 'adminLotacao']) && $model->fk_lotacao_origem === \Yii::$app->user->lotacao
                                && ($model->status !== Protocolo::STATUS_DEFERIDO && $model->status !== Protocolo::STATUS_INDEFERIDO
                                    && $model->status !== Protocolo::STATUS_CANCELADO)
                        ],
                        [
                            'label' => '<i class="fa fa-check"></i> Resolver Pendências',
                            'url' => '#modal-movimentacao',
                            'linkOptions' => [
                                'onclick' => 'clickMovimentacao(this)',
                                'data' => [
                                    'action' => 'resolver',
                                    'id' => $model->id
                                ]
                            ],
                            'visible' => $model->status === Protocolo::STATUS_PENDENTE
                        ],
                        [
                            'label' => '<i class="fa fa-archive"></i> Arquivar',
                            'url' => '#modal-movimentacao',
                            'linkOptions' => [
                                'onclick' => 'clickMovimentacao(this)',
                                'data' => [
                                    'action' => 'arquivar',
                                    'id' => $model->id
                                ]
                            ],
                            'visible' => $model->status === Protocolo::STATUS_ANDAMENTO || $model->status === Protocolo::STATUS_PENDENTE
                        ],
                        [
                            'label' => '<i class="fa fa-flag"></i> Pendente',
                            'url' => '#modal-movimentacao',
                            'linkOptions' => [
                                'onclick' => 'clickMovimentacao(this)',
                                'data' => [
                                    'action' => 'pendente',
                                    'id' => $model->id
                                ]
                            ],
                            'visible' => $model->status === Protocolo::STATUS_ANDAMENTO
                        ]
                    ],
                ],
                'options' => [
                    'class' => 'btn-primary',
                ]
            ]);
        } else {
            return '';
        }
    }
}