<?php
/**
 * Created by PhpStorm.
 * User: wilton
 * Date: 17/10/17
 * Time: 15:24
 */

namespace app\modules;

use webvimark\modules\UserManagement\models\rbacDB\Role;
use yii\helpers\ArrayHelper;

class UserManagementHelper
{
    public static function funcoesPossiveis(){
        $roles = ArrayHelper::index(Role::find()->asArray()->all(), 'name');
        $user_roles = Role::getUserRoles(\Yii::$app->user->id);

        if(!\Yii::$app->user->isSuperadmin){
            unset($roles['usuarioWeb']);

            if(!ArrayHelper::keyExists('adminEntidade' ,$user_roles)){
                unset($roles['adminEntidade']);
            }
        }

        return Helper::map($roles, 'name', 'description');
    }
}