<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\ContratoProdutosSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Contrato Produtos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="contrato-produtos-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Contrato Produtos', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'fk_contrato',
            'fk_produto',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
