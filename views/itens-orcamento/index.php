<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\ItensOrcamentoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Itens Orcamentos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="itens-orcamento-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Itens Orcamento', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'fk_orcamento',
            'fk_produto',
            'quantidade',
            'valor_unitario',
            //'valor_total',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
