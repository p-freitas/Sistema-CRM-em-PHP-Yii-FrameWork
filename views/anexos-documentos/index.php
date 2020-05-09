<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\AnexosDocumentosSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Anexos Documentos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="anexos-documentos-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Anexos Documentos', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'fk_tipo_documento',
            'fk_cliente',
            'anexo',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
