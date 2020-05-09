<?php

namespace app\models\query;

use app\models\TipoTelefone;

/**
 * This is the ActiveQuery class for [[\app\models\TipoTelefone]].
 *
 * @see \app\models\TipoTelefone
 */
class TipoTelefoneQuery extends \yii\db\ActiveQuery
{

    public function findTipoTelefoneByEntidade(){
        if(\Yii::$app->user->isSuperadmin){
            return $this;
        }else{
            return $this->andWhere([TipoTelefone::tableName().'.fk_entidade' => \Yii::$app->user->entidade]);
        }
    }
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\TipoTelefone[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\TipoTelefone|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
