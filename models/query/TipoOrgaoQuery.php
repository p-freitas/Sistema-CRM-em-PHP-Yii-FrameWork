<?php

namespace app\models\query;
use app\models\TipoOrgao;

/**
 * This is the ActiveQuery class for [[\app\models\TipoOrgao]].
 *
 * @see \app\models\TipoOrgao
 */
class TipoOrgaoQuery extends \yii\db\ActiveQuery
{

    public function findTipoOrgaoByEntidade(){
        if(\Yii::$app->user->isSuperadmin){
            return $this;
        }else{
            return $this->andWhere([TipoOrgao::tableName().'.fk_entidade' => \Yii::$app->user->entidade]);
        }
    }
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\TipoOrgao[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\TipoOrgao|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
