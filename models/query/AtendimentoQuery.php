<?php

namespace app\models\query;

use app\models\Atendimento;

/**
 * This is the ActiveQuery class for [[\app\models\Atendimento]].
 *
 * @see \app\models\Atendimento
 */
class AtendimentoQuery extends \yii\db\ActiveQuery
{
    public function findTipoAtendimentoByEntidade(){
        if(\Yii::$app->user->isSuperadmin){
            return $this;
        }else{
            return $this->andWhere([Atendimento::tableName().'.fk_entidade' => \Yii::$app->user->entidade]);
        }
    }
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\Atendimento[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\Atendimento|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
