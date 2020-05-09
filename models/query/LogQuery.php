<?php

namespace app\models\query;

use app\models\Log;
use app\models\Usuario;
use asinfotrack\yii2\toolbox\helpers\PrimaryKey;
use yii\db\ActiveQuery;

class LogQuery extends ActiveQuery
{
    /**
     * Named scope to set the ordering to show the newest entries first.
     *
     * @param boolean $sortByModelTypeFirst if set to true, the result will be sorted by
     * model_type first
     * @return LogQuery
     */
    public function orderNewestFirst($sortByModelTypeFirst=true)
    {
        if ($sortByModelTypeFirst) {
            $this->orderBy(['model_type'=>SORT_ASC, 'happened_at'=>SORT_DESC]);
        } else {
            $this->orderBy(['happened_at'=>SORT_DESC]);
        }

        return $this;
    }

    /**
     * Named scope to get entries for a certain model
     *
     * @param \yii\db\ActiveRecord $model the model to get the audit trail for
     * @return LogQuery
     * @throws \yii\base\InvalidParamException if the model is not of type ActiveRecord
     * @throws \yii\base\InvalidConfigException if the models pk is empty or invalid
     */
    public function subject($model)
    {
        $this->modelType($model::className());
        $this->andWhere(['foreign_pk'=>static::createPrimaryKeyJson($model)]);
        return $this;
    }

    /**
     * Named scope to filter entries by their model type
     *
     * @param string $modelType class type of the model
     * @return LogQuery
     */
    public function modelType($modelType)
    {
        $this->andWhere(['model_type'=>$modelType]);
        return $this;
    }

    /**
     * Creates the json-representation of the pk (array in the format attribute=>value)
     * @see \asinfotrack\yii2\toolbox\helpers\PrimaryKey::asJson()
     *
     * @return string json-representation of the pk-array
     * @throws \yii\base\InvalidParamException if the model is not of type ActiveRecord
     * @throws \yii\base\InvalidConfigException if the models pk is empty or invalid
     */
    protected static function createPrimaryKeyJson($model)
    {
        return PrimaryKey::asJson($model->owner);
    }

    public function entidadeFilter()
    {
        $this->innerJoin(Usuario::tableName(), Usuario::tableName() . '.id = ' . Log::tableName() . '.user_id');

        if (!\Yii::$app->user->isSuperadmin)
            $this->andWhere([Usuario::tableName() . '.fk_entidade' => \Yii::$app->user->entidade]);

        return $this;
    }

    public function one($db = null)
    {
        $this->entidadeFilter();
        return parent::one($db);
    }

    public function all($db = null)
    {
        $this->entidadeFilter();
        return parent::all($db);
    }

    public function count($q = '*', $db = null)
    {
        $this->entidadeFilter();
        return parent::count($q, $db);
    }

    public function sum($q, $db = null)
    {
        $this->entidadeFilter();
        return parent::sum($q, $db);
    }

    public function average($q, $db = null)
    {
        $this->entidadeFilter();
        return parent::average($q, $db);
    }

    public function min($q, $db = null)
    {
        $this->entidadeFilter();
        return parent::min($q, $db);
    }

    public function max($q, $db = null)
    {
        $this->entidadeFilter();
        return parent::max($q, $db);
    }

    public function scalar($db = null)
    {
        $this->entidadeFilter();
        return parent::scalar($db);
    }

    public function column($db = null)
    {
        $this->entidadeFilter();
        return parent::column($db);
    }

    public function exists($db = null)
    {
        $this->entidadeFilter();
        return parent::exists($db);
    }
}