<?php

namespace app\models\query;

/**
 * This is the ActiveQuery class for [[\app\models\ContatoCliente]].
 *
 * @see \app\models\ContatoCliente
 */
class ContatoClienteQuery extends \yii\db\ActiveQuery
{
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\ContatoCliente[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\ContatoCliente|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
