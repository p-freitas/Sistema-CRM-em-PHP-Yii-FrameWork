<?php

namespace app\models\query;

use app\models\Entidade;

/**
 * This is the ActiveQuery class for [[\app\models\Entidade]].
 *
 * @see \app\models\Entidade
 */
class EntidadeQuery extends \yii\db\ActiveQuery
{

    public function findEntidadeByUser(){
        if(\Yii::$app->user->isSuperadmin || \Yii::$app->user->id <= 1 )

            return $this;
            
        return $this->andWhere([Entidade::tableName().'.id' => \Yii::$app->user->entidade]);
       
    }

    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * @inheritdoc
     * @return \app\models\Entidade[]|array
     */
    public function all($db = null)
    {
        $this->findEntidadeByUser();
        return parent::all($db);
    }

    /**
     * @inheritdoc
     * @return \app\models\Entidade|array|null
     */
    public function one($db = null)
    {
        $this->findEntidadeByUser();
        return parent::one($db);
    }
}
