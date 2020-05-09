<?php
/**
 * Created by PhpStorm.
 * User: keep-to
 * Date: 08/11/17
 * Time: 10:46
 */

namespace app\modules;

use app\models\MovimentacaoProtocolo;
use webvimark\extensions\GridBulkActions\GridBulkActions;
use yii\base\InvalidConfigException;
use yii\helpers\Url;

class GridBulkHelper extends GridBulkActions
{
    public $registerJs = true;

    public static function Bulks($action = MovimentacaoProtocolo::STATUS_NAO_ATRIBUIDO)
    {
        if ($action == MovimentacaoProtocolo::STATUS_NAO_ATRIBUIDO) {
            if (!\app\models\Usuario::hasRole(['adminEntidade', 'usuarioWeb'])) {
                return self::widget([
                    'registerJs' => false,
                    'gridId' => 'list-protocolos',
                    'actions' => self::BulkProtocolosNaoAtribuidos()
                ]);
            }
            return '';
        } else if ($action == MovimentacaoProtocolo::STATUS_ATRIBUIDO) {
            if (\app\models\Usuario::hasRole(['adminLotacao'], false)) {
                return self::widget([
                    'registerJs' => false,
                    'gridId' => 'list-protocolos',
                    'actions' => self::BulkProtocolosRecebidos()
                ]);
            }

            return '';
        } else {
            return '';
        }
    }

    public static function BulkProtocolosNaoAtribuidos()
    {
        $actions = array();

        if (\app\models\Usuario::hasRole(['adminLotacao'], false)) {
            $actions[Url::to(['//protocolo/bulk-actions', 'action' => 'atribuir'])] = 'Atribuir responsável';
        }

        if (\app\models\Usuario::hasRole(['usuarioMovimentador', 'usuarioProtocolador'])) {
            $actions[Url::to(['//protocolo/bulk-actions', 'action' => 'receber'])] = 'Receber';
        }

        return $actions;
    }

    public static function BulkProtocolosRecebidos()
    {
        $actions = array();
        $actions[Url::to(['//protocolo/bulk-actions', 'action' => 'mudar'])] = 'Mudar responsável';

        return $actions;
    }

    public function run()
    {
        if (!$this->gridId) {
            throw new InvalidConfigException('Missing gridId param');
        }

        $this->setDefaultOptions();

        if ($this->registerJs)
            $this->view->registerJs($this->js());

        return $this->render('//user-management/bulk-actions/index');
    }
}