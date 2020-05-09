<?php
/**
 * Created by PhpStorm.
 * User: wilton
 * Date: 10/10/17
 * Time: 15:38
 */

namespace app\behaviors;


use yii\base\Behavior;
use yii\base\ModelEvent;
use yii\db\ActiveRecord;

class RelationDeleteBehavior extends Behavior
{
    /**
     * @var array List of relations attributes to be checked
     * */
    public $relations = [];

    /**
     * @var boolean|array
     * Option if must exclude children or block parent delete
     * If boolean the option will take for all elements of relations
     * If array must contain same names of relation. If the position on array is not set it will take default value
     */
    public $excludeChildren = false;

    /**
     * @var boolean Option if must exclude children or block parent delete
     */
    public $mustFlash = true;

    /**
     * @inheritdoc
     */
    public function events()
    {
        return [
            ActiveRecord::EVENT_BEFORE_DELETE => 'beforeDelete',
        ];
    }

    public function beforeDelete(ModelEvent $event)
    {
        if (empty($this->relations))
            return;
        else if (is_array($this->excludeChildren)) {
            foreach ($this->relations as $relation) {
                $children = $this->owner->{$relation};
                $mustExclude = isset($this->excludeChildren[$relation]) ? true : false;

                if ($mustExclude) {
                    if (count($children) > 0)
                        foreach ($children as $child)
                            $child->delete();
                } else {
                    if (!empty($children)) {
                        $this->failTrait($event);
                        break;
                    }
                }
            }
            return;
        } else if ($this->excludeChildren) {
            foreach ($this->relations as $relation) {
                $children = $this->owner->{$relation};
                if (count($children) > 0)
                    foreach ($children as $child)
                        $child->delete();
            }
        } else {
            foreach ($this->relations as $relation) {
                $children = $this->owner->{$relation};
                if (!empty($children)) {
                    $this->failTrait($event);
                    break;
                }
            }
            return;
        }
    }

    protected function failTrait(ModelEvent $event)
    {
        if ($this->mustFlash)
            \Yii::$app->session->setFlash('error', \Yii::t('app', 'This object cannot be deleted. Exist one or more elements attached on it.'));

        $event->isValid = false;
        return;
    }
}