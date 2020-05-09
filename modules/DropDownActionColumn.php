<?php

namespace app\modules;


use Yii;
use yii\base\InvalidParamException;
use yii\grid\Column;
use yii\helpers\ArrayHelper;
use yii\helpers\Html;


/**
 * Class DropDownActionColumn
 */
class DropDownActionColumn extends Column
{
    /**
     * @var string the ID of the controller that should handle the actions specified here.
     * If not set, it will use the currently active controller. This property is mainly used by
     * [[urlCreator]] to create URLs for different actions. The value of this property will be prefixed
     * to each action name to form the route of the action.
     */
    public $controller;

    /**
     * @var string the template used for composing each cell in the action column.
     * Tokens enclosed within curly brackets are treated as controller action IDs (also called *button names*
     * in the context of action column). They will be replaced by the corresponding button rendering callbacks
     * specified in [[buttons]]. For example, the token `{view}` will be replaced by the result of
     * the callback `buttons['view']`. If a callback cannot be found, the token will be replaced with an empty string.
     *
     * As an example, to only have the view, and update button you can add the ActionColumn to your GridView columns as follows:
     *
     * ```
     * ['class' => 'microinginer\yii2-dropdown-action-column', 'items' => ['label' => 'view', 'url' => ['update']]],
     * ```
     *
     */
    public $items = [

    ];

    public $primaryKey = [];

    public $template = '{view} {update} {delete}';

    public $visibleButtons = [];


    /**
     * @var bool
     */
    private $defaultItems = true;

    /**
     * Initializes the object.
     * This method is invoked at the end of the constructor after the object is initialized with the
     * given configuration.
     */
    public function init()
    {
        $this->defaultItems = !$this->items;
        parent::init();
    }

    /**
     * @inheritdoc
     */
    protected function renderDataCellContent($model, $key, $index)
    {
        $result = '';

        if ($this->defaultItems) {
            $this->items = [];
        }

        if (strpos($this->template, '{view}') !== false && !isset($this->items['view']))
            $this->items['view'] =
                [
                    'label' => Yii::t('yii', 'View'),
                    'url' => ['view'],
                    'icon' => 'glyphicon glyphicon-eye-open',
                    'linkOptions' => [
                        'class' => 'btn-sm',
                        'data-pjax' => 0
                    ],
                    'visible' => true,
                ];

        if (strpos($this->template, '{update}') !== false && !isset($this->items['update']))
            $this->items['update'] =
                [
                    'label' => Yii::t('yii', 'Update'),
                    'url' => ['update'],
                    'icon' => 'glyphicon glyphicon-pencil',
                    'linkOptions' => [
                        'class' => 'btn-sm',
                        'data-pjax' => 0
                    ],
                    'visible' => true,
                ];

        if (strpos($this->template, '{delete}') !== false && !isset($this->items['delete']))
            $this->items['delete'] =
                [
                    'label' => Yii::t('yii', 'Delete'),
                    'url' => ['delete'],
                    'icon' => 'glyphicon glyphicon-trash',
                    'linkOptions' => [
                        'class' => 'btn-sm',
                        'data-confirm' => Yii::t('yii', 'Are you sure you want to delete this item?'),
                        'data-method' => 'post',
                        'data-pjax' => 0
                    ],
                    'visible' => true,
                ];

        foreach ($this->items as $key => $value) {
            if (isset($value['visible']) && false === $value['visible']) {
                unset($this->items[$key]);
            } else if (isset($value['visible']) && $value['visible'] instanceof \Closure) {
                $this->visibleButtons[$key] = call_user_func($value['visible'], $model, $key, $index);
            }
        }

        $result .= Html::button('Ações' . Html::tag('span', '', ['class' => 'caret m-l-5', 'style' => 'display:inline-block']), ['class' => 'btn btn-default btn-sm dropdown-toggle waves-effect', 'data-toggle' => 'dropdown']);

        if (count($this->items) != 0) {
            $items = '';
            foreach ($this->items as $itemIndex => $item) {
                if (isset($this->visibleButtons[$itemIndex])) {
                    $isVisible = $this->visibleButtons[$itemIndex];
                } else {
                    $isVisible = true;
                }

                if (!isset($item['mergePrimaryKey']))
                    $item['mergePrimaryKey'] = true;

                if ($isVisible) {
                    $primaryKey = $this->primaryKey;

                    if (!empty($primaryKey)) {
                        if (isset($primaryKey['attribute']) && !isset($primaryKey['paramName']))
                            $primaryKeyArray = [$model->primaryKey()[0] => $model->{$primaryKey['attribute']}];
                        else if (!isset($primaryKey['attribute']) && isset($primaryKey['paramName']))
                            $primaryKeyArray = [$primaryKey['paramName'] => $model->getPrimaryKey()];
                        else
                            $primaryKeyArray = [$primaryKey['paramName'] => $model->{$primaryKey['attribute']}];
                    } else {
                        $primaryKeyArray = [$model->primaryKey()[0] => $model->getPrimaryKey()];
                    }

                    $icon = (isset($item['icon'])) ? Html::tag('i', '', ['class' => $item['icon'] . ' m-r-5']) : '';
                    $url = is_array($item['url']) && $item['mergePrimaryKey'] ? array_merge($item['url'], $primaryKeyArray) : $item['url'];
                    $linkOptions = isset($item['linkOptions']) ? isset($item['adParameter']) ? array_merge($item['linkOptions'], ['data-' . $item['adParameter'] => $model->{$item['adParameter']}]) : $item['linkOptions'] : [];

                    $items .= Html::tag(
                        'li',
                        Html::a(
                            $icon . $item['label'],
                            $url,
                            ($linkOptions)
                        ),
                        (isset($item['options']) ? $item['options'] : []));
                }
            }
            $result .= Html::tag('ul', $items, ['class' => 'dropdown-menu no-min-width', 'role' => 'menu']);

            return Html::tag('div', $result, ['class' => 'btn-group pull-right dropdown-toggle', 'style' => 'display: flex']);
        } else {
            throw new InvalidParamException('The $template array or $items array must contain at least one element.');
        }
    }
}
