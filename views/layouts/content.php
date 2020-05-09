<?php

use yii\widgets\Breadcrumbs;
use dmstr\widgets\Alert;

?>
<div class="row bg-title">
    <div class="col-md-12 col-lg-12 col-xs-12">
        <div class="row">
            <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
                <?=
                Breadcrumbs::widget(
                    [
                        'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
                    ]
                ) ?>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-md-12 col-lg-12 col-sm-12">
        <div class="white-box">
            <?= Alert::widget() ?>
            <?= $content ?>
        </div>

        <div class="modal fade" id="modal-report">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger">
                        <button type="button" class="close" data-dismiss="modal">×</button>
                        <h4 class="modal-title">Reportar Erro</h4>
                    </div>
                    <form action="<?= \yii\helpers\Url::to(['user/report-bug']) ?>" method="post">
                        <input id="form-token" type="hidden" name="<?= Yii::$app->request->csrfParam ?>"
                               value="<?= Yii::$app->request->csrfToken ?>"/>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="alert alert-info">
                                        Por favor, insira um breve descritivo do problema.
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <label for="report" class="control-label">Descrição</label>
                                    <?= \yii\helpers\Html::textarea('report', '', ['class' => 'form-control', 'required' => 'required']) ?>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                            <button type="submit" class="btn btn-primary">Enviar</button>
                        </div>
                    </form>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->

        <div class="modal fade" id="modal-perfil">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger">
                        <button type="button" class="close" data-dismiss="modal">×</button>
                        <h4 class="modal-title">Perfil</h4>
                    </div>
                    <?= $this->render('//user-management/user/perfil', array('model' => Yii::$app->user->identity)); ?>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
    </div>
</div>