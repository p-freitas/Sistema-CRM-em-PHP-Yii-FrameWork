<?php

namespace app\models\query;

use app\models\Entidade;
use app\models\Usuario;
use yii\db\ActiveQuery;

class UsuarioQuery extends ActiveQuery
{
    public function entidadeFilter()
    {
        if (!\Yii::$app->user->isSuperadmin) {
            return $this->andWhere([Usuario::tableName() . '.fk_entidade' => \Yii::$app->user->entidade]);
        }
        else{
            return $this;
        }
    }

    public function lotacaoFilter()
    {
        if (Usuario::hasRole(['adminLotacao', false])) {
            return $this->andWhere([Usuario::tableName() . '.fk_lotacao' => \Yii::$app->user->lotacao]);
        }
        else{
            return $this;
        }
    }

    /**
     * @inheritdoc
     * @return \app\models\Usuario[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * @inheritdoc
     * @return \app\models\Usuario|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}