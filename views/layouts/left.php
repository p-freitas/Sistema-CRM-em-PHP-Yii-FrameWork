<?php

/* @var $this \yii\web\View */

use app\modules\GhostMenuCustom;

$this->registerCss("
#mySearch {
  width: 100%;
  font-size: 14px;
  padding: 10px;
  border: 1px solid #ddd;
}");


?>

<div class="navbar-default sidebar" role="navigation">
    <div class="sidebar-nav navbar-collapse slimscrollsidebar">
        <input type="text" class="form-control hidden-xs" id="search-menu" onkeyup="searchSideMenu()"
               placeholder="Pesquisar no menu...">


        <?= GhostMenuCustom::widget([
            'encodeLabels' => false,
            'activateParents' => true,
            'items' => [
                [
                    'label' => 'Entidades',
                    'level' => 'first',
                    'options' => ['class' => 'nav-small-cap m-t-0']
                ],
                GhostMenuCustom::gerenciaClientes(),
                [
                    'label' => 'Contratos',
                    'level' => 'first',
                    'options' => ['class' => 'nav-small-cap m-t-0'],
                    'submenuTemplate' => '<li>{items}</li>',
                ],
                GhostMenuCustom::gerenciaContratos(),
                [
                    'label' => 'Atendimentos',
                    'level' => 'first',
                    'submenuTemplate' => '<li>{items}</li>',
                    'options' => ['class' => 'nav-small-cap m-t-0'],
                ],
                GhostMenuCustom::gerenciaAtendimento(),
                [
                    'label' => 'Financeiro',
                    'level' => 'first',
                    'submenuTemplate' => '<li>{items}</li>',
                    'options' => ['class' => 'nav-small-cap m-t-0'],
                ],
                GhostMenuCustom::gerenciaFinanceiro(),
                [
                    'label' => 'Sistema',
                    'level' => 'first',
                    'visible' => !\app\models\Usuario::hasRole(['usuarioWeb'], false),
                    'submenuTemplate' => '<li>{items}</li>',
                    'options' => ['class' => 'nav-small-cap m-t-0'],
                ],
                GhostMenuCustom::gerenciaUsuarios(),
                [
                    'label' => 'Usuário',
                    'level' => 'first',
                    'submenuTemplate' => '<li>{items}</li>',
                    'options' => ['class' => 'nav-small-cap m-t-0'],

                ],
                GhostMenuCustom::gerenciaConta(),

                [
                    'label' => 'SuperAdmin',
                    'level' => 'first',
                    'options' => ['class' => 'nav-small-cap m-t-0'],
                    'visible' => Yii::$app->user->isSuperadmin,
                    'submenuTemplate' => '<li>{items}</li>',
                ],
                GhostMenuCustom::gerenciaParametrosGerais(),

            ]


        ]);
        ?>
    </div>
</div>