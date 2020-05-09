<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\TelefoneSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Telefones';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="telefone-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Telefone', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'fk_contato_cliente',
            'fk_tipo_telefone',
            'telefone',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
