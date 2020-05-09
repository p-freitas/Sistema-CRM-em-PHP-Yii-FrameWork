<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Modalidade */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Modalidades'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Nova Modalidade';
$this->title = 'Criar nova modalidade';
?>
<div class="modalidade-create">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
