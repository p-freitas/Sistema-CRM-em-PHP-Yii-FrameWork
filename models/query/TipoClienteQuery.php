<?php

namespace app\models\query;

use app\models\TipoCliente;

/**
 * This is the ActiveQuery class for [[\app\models\TipoCliente]].
 *
 * @see \app\models\TipoCliente
 */
class TipoClienteQuery extends \yii\db\ActiveQuery
{

    public function findTipoClienteByEntidade(){
        if(\Yii::$app->user->isSuperadmin){
            return $this;
        }else{
            return $this->andWhere([TipoCliente::tableName().'.fk_entidade' => \Yii::$app->user->entidade]);
        }
    }
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\TipoCliente[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\TipoCliente|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
