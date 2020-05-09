<?php

use app\models\search\ContratoSearch;
use yii\data\ActiveDataProvider;
use yii\helpers\Html;
use yii\grid\GridView;

use app\models\Contrato;
use app\models\Aditivo;
use yii\web\View;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\ContratoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */
/* @var $model app\models\Aditivo */
?>
<div class="contrato-index">
    <div class="row">
        <div class="col-lg-12">
            <div>
                <table id="demo-foo-row-toggler" class="table table-bordered table-get-details toggle-circle table-hover">

                    <thead>
                    <?php $modelsAditivo = $model->aditivos; ?>
                        <tr>
                            <th>Número </th>
                            <th>Valor </th>
                            <th>Anexo do aditivo</th>
                        </tr>
                    <?php foreach ($modelsAditivo as $index => $modelAditivo) { ?>
                        <tbody>
                        <tr>
                            <td><?= $modelAditivo->numero; ?></td>
                            <td><?= $modelAditivo->valor; ?></td>
                            <?php if ($modelAditivo->anexo){ ?>
                                <td width=" 10%" class="text-center">
                                    <a href= <?= $modelAditivo->anexo ?>>
                                        <button data-toggle="tooltip" data-placement="top" title="Download" type="button" type="button" class="btn btn-rounded btn-info btn-sm">
                                            <i class="fa fa-arrow-down"></i>
                                        </button>
                                    </a>
                                </td>
                            <?php }else { ?>
                                <td width="10%" class="text-center not-set">
                                    <span>(não definido)</span>
                                </td>
                            <?php } ?>

                        </tr>
                        </tbody>
                    <?php } ?>
                    </thead>
                    <thead>
                </table>
            </div>
        </div>
    </div>
</div>
