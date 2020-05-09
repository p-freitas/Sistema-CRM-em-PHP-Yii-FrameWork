<?php

namespace app\models\query;

use app\models\Cliente;

/**
 * This is the ActiveQuery class for [[\app\models\Cliente]].
 *
 * @see \app\models\Cliente
 */
class ClienteQuery extends \yii\db\ActiveQuery
{

    public function findClienteByEntidade(){
        if(\Yii::$app->user->isSuperadmin || is_null(\Yii::$app->user->id))

            return $this;

        return $this->andWhere([Cliente::tableName().'.fk_entidade' => \Yii::$app->user->entidade]);
    }
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\Cliente[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\Cliente|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
