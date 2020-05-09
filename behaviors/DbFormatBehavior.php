<?php
/**
 * Created by PhpStorm.
 * User: wilton
 * Date: 13/09/17
 * Time: 14:34
 */

namespace app\behaviors;

use app\components\CustomFormatter;
use app\models\Entidade;
use yii\base\Behavior;
use yii\base\Event;
use yii\base\Model;
use \yii\db\ActiveRecord;
use yii\db\ColumnSchema;

class DbFormatBehavior extends Behavior
{
    /**
     * @inheritdoc
     */
    public function events()
    {
        return [
            ActiveRecord::EVENT_AFTER_FIND => 'afterFind',
            Model::EVENT_AFTER_VALIDATE => 'filterData'
        ];
    }

    public function afterFind(Event $event)
    {
        /** @var CustomFormatter $formatter */
        $formatter = \Yii::$app->formatter;
        $tableColumns = $this->owner->getTableSchema()->columns;
        /** @var ColumnSchema $column */

        foreach ($tableColumns as $column) {
            if (empty($this->owner->{$column->name}))
                continue;
            if ($this->isDecimalColumn($column))
                $this->owner->{$column->name} = $formatter->asDecimal($this->owner->{$column->name}, $column->scale);
            if ($this->isDateColumn($column))
                $this->owner->{$column->name} = $formatter->asDate($this->owner->{$column->name});
            if ($this->isDateTimeColumn($column))
                $this->owner->{$column->name} = $formatter->asDatetime($this->owner->{$column->name});
        }
    }

    public function filterData(Event $event)
    {
        if (empty($this->owner->getErrors())) {


            /** @var CustomFormatter $formatter */
            $formatter = \Yii::$app->formatter;
            $tableColumns = $this->owner->getTableSchema()->columns;
            /** @var ColumnSchema $column */
            foreach ($tableColumns as $column) {
                if (!is_numeric($this->owner->{$column->name}) && empty($this->owner->{$column->name}) && !$this->isIntegerColumn($column) && !$this->isDateColumn($column) && !$this->isDateTimeColumn($column))
                    continue;
                if ((($this->isIntegerColumn($column) && !is_numeric($this->owner->{$column->name})) || $this->isDateColumn($column) || $this->isDateTimeColumn($column)) && empty($this->owner->{$column->name}))
                    $this->owner->{$column->name} = null;
                else if ($this->isIntegerColumn($column))
                    $this->owner->{$column->name} = intval($this->owner->{$column->name});
                else if ($this->isDecimalColumn($column))
                    $this->owner->{$column->name} = $formatter->asDecimalUS($this->owner->{$column->name});
                else if ($this->isDateColumn($column))
                    $this->owner->{$column->name} = $formatter->asDateUS($this->owner->{$column->name});
                else if ($this->isDateTimeColumn($column))
                    $this->owner->{$column->name} = $formatter->asDateTimeUS($this->owner->{$column->name});
            }
        }
    }

    /**
     * Metodo que verifica se a coluna informada e do tipo Double/Decimal
     * @param ColumnSchema $column
     * @return bool
     */
    private function isDecimalColumn(ColumnSchema $column)
    {
        return in_array($column->type, ['decimal', 'double', 'float', 'real', 'numeric']);
    }

    /**
     * Metodo que verifica se a coluna informada e do tipo Integer
     * @param ColumnSchema $column
     * @return bool
     */
    private function isIntegerColumn(ColumnSchema $column)
    {
        return in_array($column->type, ['integer']);
    }

    /**
     * Metodo que verifica se a coluna informada e do tipo Date
     * @param ColumnSchema $column
     * @return bool
     */
    private function isDateColumn(ColumnSchema $column)
    {
        return in_array($column->type, ['date']);
    }

    /**
     * Metodo que verifica se a coluna informada e do tipo Datetime
     * @param ColumnSchema $column
     * @return bool
     */
    private function isDateTimeColumn(ColumnSchema $column)
    {
        return in_array($column->type, ['datetime', 'timestamp']);
    }
}