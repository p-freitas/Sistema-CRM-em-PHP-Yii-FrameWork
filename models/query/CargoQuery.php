<?php

namespace app\models\query;
use app\models\Cargo;

/**
 * This is the ActiveQuery class for [[\app\models\Cargo]].
 *
 * @see \app\models\Cargo
 */
class CargoQuery extends \yii\db\ActiveQuery
{

    public function findCargoByEntidade(){
        if(\Yii::$app->user->isSuperadmin){
            return $this;
        }else{
            return $this->andWhere([Cargo::tableName().'.fk_entidade' => \Yii::$app->user->entidade]);
        }
    }
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\Cargo[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\Cargo|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
