<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\AtendimentoAnexosSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Atendimento Anexos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="atendimento-anexos-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Atendimento Anexos', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'fk_atendimento',
            'anexo',
            'descricao',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
