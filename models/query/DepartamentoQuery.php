<?php

namespace app\models\query;
use app\models\Departamento;

/**
 * This is the ActiveQuery class for [[\app\models\Departamento]].
 *
 * @see \app\models\Departamento
 */
class DepartamentoQuery extends \yii\db\ActiveQuery
{

    public function findDepartamentoByEntidade(){
        if(\Yii::$app->user->isSuperadmin){
            return $this;
        }else{
            return $this->andWhere([Departamento::tableName().'.fk_entidade' => \Yii::$app->user->entidade]);
        }
    }
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\Departamento[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\Departamento|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
