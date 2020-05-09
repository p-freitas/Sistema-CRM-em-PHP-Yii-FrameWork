<?php

namespace app\models\query;

use app\models\TipoDocumento;

/**
 * This is the ActiveQuery class for [[\app\models\TipoDocumento]].
 *
 * @see \app\models\TipoDocumento
 */
class TipoDocumentoQuery extends \yii\db\ActiveQuery
{
    public function findTipoDocumentoByEntidade(){
        if(\Yii::$app->user->isSuperadmin){
            return $this;
        }else{
            return $this->andWhere([TipoDocumento::tableName().'.fk_entidade' => \Yii::$app->user->entidade]);
        }
    }
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\TipoDocumento[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\TipoDocumento|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
