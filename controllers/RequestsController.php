<?php

namespace app\controllers;

use app\modules\PdfHelper;
use webvimark\modules\UserManagement\models\User;
use Yii;
use app\models\Requests;
use app\models\search\RequestsSearch;
use app\controllers\MainController;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * RequestsController implements the CRUD actions for Requests model.
 */
class RequestsController extends MainController
{


    public $freeAccessActions = ['report-bug', 'mensagem-pdf'];

    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['POST'],
                ],
            ],
        ];
    }

    /**
     * Lists all Requests models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new RequestsSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Requests model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Finds the Requests model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Requests the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Requests::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

    public function actionReportBug()
    {
        if (isset($_POST)) {
            $mensagem = $_POST['report'];
            if (!empty($mensagem)) {
                Yii::$app->mailer->compose('report_bug', ['message' => $mensagem, 'user' => User::getCurrentUser()])
                    ->setFrom('noreply@keepinformatica.com')
                    ->setTo('adm@keepinformatica.com')
                    ->setSubject('Error Report [Patrimônio Online]')
                    ->send();

                Yii::$app->session->setFlash('success', 'Obrigado pelo feedback. Estaremos atendendo o quanto antes.');
            }
        }
        return $this->redirect(['bem/index']);

    }

    public function actionModalMensagem($id)
    {
        $request = $this->findModel($id);
        
            return $this->renderAjax('mensagemModal-pdf', [
                'model' => $request,
            ]);

    }

    public function actionMensagemPdf($id)
    {

        $request = $this->findModel($id);

        return $this->renderAjax('mensagem-pdf', [
            'model' => $request,
        ]);
    }
}
