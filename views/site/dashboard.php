<?php

use app\modules\GraphHelper;
use kartik\grid\GridView;
use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use app\models\Usuario;
use app\models\CompraBem;
use app\models\Bem;
use app\models\ContaContabil;

/* @var $this yii\web\View */
/* @var $topo array */
/* @var $esquerda array */
/* @var $direita array */

$this->title = 'Dashboard';
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Bems'), 'url' => ['bem/index']];
$this->params['breadcrumbs'][] = $this->title;
?>

<div class="row form-group">
    <div class="col-md-12 col-lg-12 col-sm-12">
        <div class="row row-in">
            <div class="col-lg-3 col-sm-6 row-in-br">
                <div class="col-in row">
                    <div class="col-md-3 col-sm-3 col-xs-3"><i data-icon=";" class="linea-icon linea-ecommerce"></i>
                        <h5 class="text-muted vb">Bens</h5>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <h3 class="counter text-right m-t-15 text-primary"><?= $topo[0] ?></h3>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-sm-6 row-in-br  b-r-none">
                <div class="col-in row">
                    <div class="col-md-3 col-sm-3 col-xs-3"><i class="linea-icon linea-aerrow" data-icon="&#xe008;"></i>
                        <h5 class="text-muted vb">Baixados</h5>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <h3 class="counter text-right m-t-15 text-danger"><?= $topo[1] ?></h3>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-sm-6 row-in-br  b-r-none">
                <div class="col-in row">
                    <div class="col-md-3 col-sm-3 col-xs-3"><i class="linea-icon linea-aerrow" data-icon="&#xe006;"></i>
                        <h5 class="text-muted vb">Total</h5>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <h3 class="counter text-right m-t-15 text-info"><?= $topo[0] + $topo[1]  ?></h3>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-sm-6 row-in-br  b-r-none">
                <div class="col-in row">
                    <div class="col-md-3 col-sm-3 col-xs-3"><i class="linea-icon linea-basic" data-icon="E"></i>
                        <h5 class="text-muted vb">Usuários</h5>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <h3 class="counter text-right m-t-15 text-megna"><?= $topo[2] ?></h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php if (Yii::$app->user->isSuperadmin){ ?>
    <?= GridView::widget([
        'dataProvider' => $tabelas['visitas'],
        'toolbar' => false,
        'summary' => false,
        'showPageSummary' => false,
        'condensed' => true,
        'striped' => true,
        'bordered' => true,
        'responsive' => false,
        'hover' => false,
        'moduleId' => 'gridviewKrajee',
        'panel' => [
            'type' => GridView::TYPE_INFO,
            'heading' => '<span style="color:white; !important; font-weight:bold">Quantidade de Visitas</span> ',
            'footer' => false,
            'after' => false,
        ],
        'columns' => [
            [
                'attribute' => 'name',
                'label' => 'Entidade',
            ],
            [
                'attribute' => 'y',
                'label' => 'Qtde Visitas',
            ],
        ]
    ]); ?>
<?php }else{ ?>
    <?= GridView::widget([
        'dataProvider' => $tabelas['contas'],
        'toolbar' => false,
        'summary' => false,
        'showPageSummary' => true,
        'condensed' => true,
        'striped' => true,
        'bordered' => true,
        'responsive' => false,
        'hover' => false,
        'moduleId' => 'gridviewKrajee',
        'panel' => [
            'type' => GridView::TYPE_INFO,
            'heading' => '<span style="color:white; !important; font-weight:bold"> Contas Contábeis</span>',
            'footer' => false,
            'after' => false,
        ],
        'columns' => [
            [
                'attribute' => 'conta_contabil',
                'label' => 'Conta Contábil',
                'value' => function($model){
                    $conta = ContaContabil::find()->andWhere([ContaContabil::tableName().'.id' => $model['conta_contabil']])->one();
                    return $conta->descricao;
                },
                'pageSummary' => true,
                'pageSummaryOptions' => ['style' => 'text-align:left;font-weight:bold;'],
                'pageSummaryFunc' => function ($data) {
                   return count($data);
                },
            ],
            [
                'label' => 'Qtd. Bens',
                'headerOptions' => ['style' => 'text-align:right;'],
                'contentOptions' => ['style' => 'text-align:right;'],
                'value' => function($model){

                    $qtd = Bem::find()->findBemByEntity()->qtdDashboard($model['conta_contabil']);

                    return ($qtd == null) ? null : $qtd;

                },
                'pageSummary' => true,
                'hAlign' => 'right',
                'pageSummaryOptions' => ['style' => 'text-align:right;font-weight:bold;'],
                'pageSummaryFunc' => function ($data) {
                    $total = 0;
                    foreach ($data as $value) {
                        $total += $value;
                    }
                    return $total;
                },
            ],
            [
                'label' => 'Valor Compra',
                'headerOptions' => ['style' => 'text-align:right;'],
                'contentOptions' => ['style' => 'text-align:right;'],
                'value' => function($model){

                    //$valor_atual = CompraBem::find()->valorCompraDashboard($model['conta_contabil']);

                    return ($model['valor_compra'] == null) ? '0,00' : Yii::$app->formatter->asDecimal($model['valor_compra'],2);

                },
                'pageSummary' => true,
                'hAlign' => 'right',
                'pageSummaryOptions' => ['style' => 'text-align:right;font-weight:bold;'],
                'pageSummaryFunc' => function ($data) {
                    $total = 0;
                    foreach ($data as $value) {
                        $total += floatval(\Yii::$app->formatter->asDecimalUS($value));
                    }
                    return \Yii::$app->formatter->asDecimal($total,2);
                },
            ],
            [
                'label' => 'Valor Atual',
                'headerOptions' => ['style' => 'text-align:right;'],
                'contentOptions' => ['style' => 'text-align:right;'],
                'value' => function($model){

                    //$valor_atual = CompraBem::find()->valorAtualDashboard($model['conta_contabil']);

                    return ($model['valor_atual'] == null) ? '0,00' : Yii::$app->formatter->asDecimal($model['valor_atual'],2);

                },
                'pageSummary' => true,
                'hAlign' => 'right',
                'pageSummaryOptions' => ['style' => 'text-align:right;font-weight:bold;'],
                'pageSummaryFunc' => function ($data) {
                    $total = 0;
                    foreach ($data as $value) {
                        $total += floatval(\Yii::$app->formatter->asDecimalUS($value));
                    }
                    return \Yii::$app->formatter->asDecimal($total,2);
                },
            ],
        ]
    ])
    ?>
<?php } ?>