<?php

namespace app\models\query;

/**
 * This is the ActiveQuery class for [[\app\models\AtendimentoAnexos]].
 *
 * @see \app\models\AtendimentoAnexos
 */
class AtendimentoAnexosQuery extends \yii\db\ActiveQuery
{
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\AtendimentoAnexos[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\AtendimentoAnexos|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
