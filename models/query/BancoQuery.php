<?php

namespace app\models\query;

/**
 * This is the ActiveQuery class for [[\app\models\Banco]].
 *
 * @see \app\models\Banco
 */
class BancoQuery extends \yii\db\ActiveQuery
{
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\Banco[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\Banco|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
