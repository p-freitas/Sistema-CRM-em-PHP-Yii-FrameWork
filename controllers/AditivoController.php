<?php

namespace app\controllers;

use Yii;
use app\models\Aditivo;
use app\models\search\AditivoSearch;
use app\controllers\MainController;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\UploadedFile;
use Aws\S3\S3Client;

/**
 * AditivoController implements the CRUD actions for Aditivo model.
 */
class AditivoController extends MainController
{

    /**
     * Lists all Aditivo models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new AditivoSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Aditivo model.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Aditivo model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Aditivo();

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {

            $anexo = UploadedFile::getInstance($model, 'anexo');
            if (!is_null($anexo)) {
                $s3 = Yii::$app->get('s3');
                $saved = false;
                while (!$saved) {
                    $nome = rand(0, 9999999);
                    $exist = $s3->exist('crm/anexos/'.$model->numero.'/' . $nome . '.' . $anexo->extension);

                    if (!$exist) {
                        $result = $s3->upload('crm/anexos/'.$model->numero.'/' . $nome . '.' . $anexo->extension, $anexo->tempName);
                        $model->anexo = $result->get('ObjectURL');
                        $saved = true;
                    }
                }
            }
            $model->save(false);
            return $this->redirect(['view', 'id' => $model->id]);
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

    /**
     * Updates an existing Aditivo model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing Aditivo model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the Aditivo model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Aditivo the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Aditivo::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionCreateModal(){
        $model = new Aditivo();

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            $anexo = UploadedFile::getInstance($model, 'anexo');
            if (!is_null($anexo)) {
                $s3 = Yii::$app->get('s3');
                $saved = false;
                while (!$saved) {
                    $nome = rand(0, 9999999);
                    $exist = $s3->exist('crm/anexos/'.$model->numero.'/' . $nome . '.' . $anexo->extension);

                    if (!$exist) {
                        $result = $s3->upload('crm/anexos/'.$model->numero.'/' . $nome . '.' . $anexo->extension, $anexo->tempName);
                        $model->anexo = $result->get('ObjectURL');
                        $saved = true;
                    }
                }
            }
            $model->save(false);
            return $this->redirect(['/contrato/index']);
        }else{
            return Json::encode(['status' => 500, 'content' => $this->renderAjax('_form_modal', [
                'model' => $model
            ])]);
        }
    }
}
