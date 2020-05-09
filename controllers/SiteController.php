<?php

namespace app\controllers;
use app\models\forms\RelatorioResumoContabilForm;
use app\modules\Helper;
use yii\data\ArrayDataProvider;
use yii\db\Expression;
use yii\helpers\ArrayHelper;
use ZipArchive;
use yii\helpers\Json;
use yii\helpers\Url;

use app\models\forms\SigaForm;
use app\models\Usuario;
use app\models\Entidade;
use app\models\Bem;
use app\models\Item;
use app\models\CompraBem;
use app\models\Conservacao;
use app\models\ContaContabil;
use app\models\ContaContabilSint;
use app\models\CorrecaoDepreciacao;
use app\models\FonteRecurso;
use app\models\Secretaria;
use app\models\LocalBem;
use app\models\Local;
use app\models\Departamento;
use app\models\NotaFiscal;
use app\models\Baixa;

class SiteController extends MainController
{
    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'ghost-access' => [
                'class' => 'webvimark\modules\UserManagement\components\GhostAccessControl',
            ],
        ];
    }

    /**
     * @inheritdoc
     */
    public function actions()
    {
        return [
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
            'addressSearch' => 'yiibr\correios\CepAction'
        ];
    }

    public function actionIndex()
    {
        return $this->render('index');
    }

    



}
