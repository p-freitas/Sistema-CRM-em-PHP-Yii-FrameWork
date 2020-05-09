<?= DetailView::widget([
    'model' => $model,
    'mode' => 'view',
    'striped' => false,
    'hAlign' => 'left',
    'vAlign' => 'middle',
    'panel' => false,
    'hideIfEmpty' => true,
    'attributes' => [
        [
            'group' => true,
            'label' => 'Autorização de Fornecimento de Material ou Serviço',
            'rowOptions' => ['class' => 'info'],
            'groupOptions' => ['class' => 'text-bold text-center', 'style' => 'font-size: 18px']
        ],
        [
            'columns' => [
                [
                    'attribute' => 'FK_CONTRATO',
                    'label' => 'Contrato Nº',
                    'value' => $model->fKCONTRATO->NUMERO,
                    'displayOnly' => true,
                    'labelColOptions' => ['style' => 'width: 15%', 'class' => 'text-bold'],
                    'valueColOptions' => ['style' => 'width: 15%']
                ]
            ]
        ],
    ]
]) ?>