<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\BloqueioSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Bloqueios';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="bloqueio-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Bloqueio', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'fk_cliente',
            'fk_contrato',
            'fk_produto',
            'fk_usuario',
            //'data_bloqueio',
            //'data_limite',
            //'status',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
