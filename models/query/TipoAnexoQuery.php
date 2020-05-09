<?php

namespace app\models\query;

use app\models\TipoAnexo;

/**
 * This is the ActiveQuery class for [[\app\models\TipoAnexo]].
 *
 * @see \app\models\TipoAnexo
 */
class TipoAnexoQuery extends \yii\db\ActiveQuery
{

    public function findTipoAnexoByEntidade(){
        if(\Yii::$app->user->isSuperadmin){
            return $this;
        }else{
            return $this->andWhere([TipoAnexo::tableName().'.fk_entidade' => \Yii::$app->user->entidade]);
        }
    }
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\TipoAnexo[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\TipoAnexo|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
