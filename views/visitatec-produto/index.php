<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\VisitaTecProdutoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Visita Tec Produtos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="visita-tec-produto-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Visita Tec Produto', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'fk_visita',
            'fk_produto',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
