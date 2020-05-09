<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\GestaoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Gestaos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="gestao-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Gestao', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'fk_cliente',
            'periodo',
            'prefeito',
            'data_nascimento',
            //'vice_prefeito',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
