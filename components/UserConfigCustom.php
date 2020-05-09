<?php

namespace app\components;

use app\models\Usuario;
use webvimark\modules\UserManagement\components\UserConfig;

class UserConfigCustom extends UserConfig
{
    /* @return integer */
    public function getEntidade()
    {
        if (\Yii::$app->user->isGuest) {
            return null;
        } else {
            if (!\Yii::$app->user->isSuperAdmin)
                return \Yii::$app->user->identity->fk_entidade;
            else
                return null;
        }
    }

    /* @return integer */
    public function getLotacao()
    {
        if (\Yii::$app->user->isGuest) {
            return null;
        } else {
            if (!\Yii::$app->user->isSuperAdmin)
                return \Yii::$app->user->identity->fk_lotacao;
            else
                return null;
        }
    }

    /* @return integer */
    public function getFuncoes()
    {
        if (\Yii::$app->user->isGuest) {
            return null;
        } else {
            return Usuario::getCurrentUser()->getRoles()->all();
        }
    }
}