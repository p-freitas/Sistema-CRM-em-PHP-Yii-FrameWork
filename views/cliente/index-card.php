<?php
/**
 * Created by PhpStorm.
 * User: Luan
 * Date: 25/09/2018
 * Time: 11:26
 */


use app\models\Bloqueio;
use yii\helpers\Html;
use yii\grid\GridView;
use yii\bootstrap\ActiveForm;
use yii\helpers\arrayHelper;
use yii\helpers\Url;
use yii\bootstrap\ButtonDropdown;
use yii\widgets\Pjax;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\ClienteSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->params['breadcrumbs'][] = 'Clientes';

\app\assets\DatatablesAsset::register($this);
$this->registerJsFile('@web/js/filterClienteCard.js', ['depends' => [\yii\web\JqueryAsset::className()]]);

\app\assets\DatatablesAsset::register($this);
$this->registerJsFile('@web/js/bloqueio.js', ['depends' => [\yii\web\JqueryAsset::className()]]);
?>
<div class="cliente-index">
    <?php Pjax::begin(['id' => 'pjax-cliente']); ?>

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Novo cliente', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">
            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index-card'],
                'method' => 'get',
            ]); ?>
            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip','id' => 'entrada', 'title' => 'Pesquisa por nome'])->label('Pesquisar: ') ?>
            <div>
                <?= Html::a(Html::tag('i', '', ['class' => 'fa fa-th-large']) . ' Ícone ', ['cliente/index-card'], ['class' => 'pull-right', 'style' => ['color' => '#979797']]) ?>
                <?= Html::a(Html::tag('i', '', ['class' => 'fa fa-th-list']) . ' Lista &ensp;&ensp; ', ['cliente/index'], ['class' => 'pull-right', 'style' => ['color' => '#979797']]) ?>
            </div>
            <?php ActiveForm::end(); ?>
        </div>
    </div>

    <div class="container-fluid">


        <div class="row" id="clientes">
            <div class="col-12" id="saida">
                <div class="row">
                    <?php $i = 0;
                    foreach ($clientes

                    as $cliente){
                    $has_bloqueio = Bloqueio::find()->where([Bloqueio::tableName() . '.fk_cliente' => $cliente->id, Bloqueio::tableName() . '.status' => 1])->one(); ?>
                    <?php if ($i % 4 == 0 && $i != 0){ ?>


                </div>
                <br>
                <div class="row">
                    <?php } ?>
                    <div class="col-lg-3 col-md-6" data-cliente="<?= $cliente->nome_fantasia ?>">
                        <input type="hidden" value="<?= $cliente->nome_fantasia ?>">
                        <div class="card">
                            <a href="view?id=<?= $cliente->id ?>"><img class="card-img-top image-responsive"
                                                                       height="200" width="200"
                                                                       src="<?= empty($cliente->brasao) ? \yii\helpers\Url::to('@web/themes/eliteadmin/plugins/images/users/blank-user.jpg', true) : $cliente->brasao ?>"
                                                                       alt="Card image cap"></a>
                            <div class="card-body">
                                <strong>
                                    <h3 class="name_link"><?= Html::a(Yii::t('app', $cliente->nome_fantasia), ['update', 'id' => $cliente->id], ['class' => 'name_link']) ?></h3>
                                </strong>
                                <strong><p class="card-text"><?= $cliente->cpf_cnpj ?></p></strong>
                                <p class="card-text"><?= $cliente->email ?></p>
                                <p class="card-text"><?= $cliente->cidade . ' - ' . $cliente->estado ?></p>

                                <?= ButtonDropdown::widget([
                                    'options' => ['class' => 'btn btn-default btn-sm dropdown-toggle waves-effect', 'data-toggle' => 'dropdown'],
                                    'label' => 'Ações',
                                    'dropdown' => [
                                        'items' => [
                                            ['label' => 'Exibir', 'url' => ['view', 'id' => $cliente->id]],
                                            ['label' => 'Alterar', 'url' => ['update', 'id' => $cliente->id]],
                                            ['label' => 'Excluir', 'url' => ['delete', 'id' => $cliente->id], 'linkOptions' => ['data-method' => 'post', 'data-confirm' => 'Você tem certeza que quer apagar este cliente?']],
                                            ['label' => 'Bloquear', 'url' => '#', 'options' => ['onclick' => 'bloquear(' . $cliente->id . ')']],
                                            ['label' => 'Desbloquar', 'url' => '#', 'options' => ['onclick' => 'desbloquear(' . $cliente->id . ')']],
                                        ],
                                    ],
                                ]) ?>
                                <?= !empty($has_bloqueio) ? '<i class="fa fa-lock"></i>' : '' ?>
                            </div>
                        </div>
                    </div>
                    <?php $i++; ?>
                    <?php } ?>
                </div>
                <div class="hide" id="empty">Nenhum resultado...</div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="bloqueio-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="bloqueio-modal-label" style="color:white">Bloqueio</h4>
            </div>
            <?= $this->render('//bloqueio/_form_modal', ['model' => new \app\models\Bloqueio(), 'modelBloqueioProduto' => new app\models\BloqueioProduto()]); ?>
        </div>
    </div>
</div>

<div class="modal fade" id="desbloqueio-modal" tabindex="-1" role="dialog" aria-labelledby="desbloqueio-modal-label">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="desbloqueio-modal-label" style="color: white">Desbloqueio</h4>
            </div>
            <?= $this->render('//bloqueio/_form_modal_desbloqueio'); ?>
        </div>
    </div>
</div>