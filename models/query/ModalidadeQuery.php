<?php

namespace app\models\query;

/**
 * This is the ActiveQuery class for [[\app\models\Modalidade]].
 *
 * @see \app\models\Modalidade
 */
class ModalidadeQuery extends \yii\db\ActiveQuery
{
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\Modalidade[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\Modalidade|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
