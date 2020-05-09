<?php

namespace app\models\query;

/**
 * This is the ActiveQuery class for [[\app\models\NotaFiscal]].
 *
 * @see \app\models\NotaFiscal
 */
class NotaFiscalQuery extends \yii\db\ActiveQuery
{
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return \app\models\NotaFiscal[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\NotaFiscal|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
