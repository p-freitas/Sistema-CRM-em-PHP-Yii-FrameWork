<?php

namespace app\models\query;
use app\models\Produto;

/**
 * This is the ActiveQuery class for [[\app\models\Produto]].
 *
 * @see \app\models\Produto
 */
class ProdutoQuery extends \yii\db\ActiveQuery
{

    public function findProdutosByEntidade(){
        if(\Yii::$app->user->isSuperadmin){
            return $this;
        }else{
            return $this->andWhere([Produto::tableName().'.fk_entidade' => \Yii::$app->user->entidade]);
        }
    }
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\Produto[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\Produto|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
