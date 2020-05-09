<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Cargo */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Cargos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo Cargo';
$this->title = 'Criar novo cargo';
?>
<div class="cargo-create">



    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
