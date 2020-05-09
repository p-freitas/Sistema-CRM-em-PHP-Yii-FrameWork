<?php
/**
 * Created by PhpStorm.
 * User: KEEP-PC
 * Date: 24/05/2017
 * Time: 08:39
 */

namespace app\modules;


use webvimark\modules\UserManagement\components\AuthHelper;

class CustomAuthHelper extends AuthHelper
{
    public static $mustLoginLayout = ['user-management/auth/login', 'user-management/auth/password-recovery', 'user-management/auth/registration', 'user-management/auth/password-recovery-receive'];

    public static function customLayoutHandler($event)
    {
        if (in_array($event->action->uniqueId, self::$mustLoginLayout)) {
            $event->action->controller->layout = '@app/views/layouts/main-login.php';
        } else {
            $event->action->controller->layout = '@app/views/layouts/main.php';
        }
    }
}