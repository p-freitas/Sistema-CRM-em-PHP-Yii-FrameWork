<?php

namespace app\controllers;

use app\models\Cargo;
use Yii;
use app\models\ContatoCliente;
use app\models\search\ContatoClienteSearch;
use app\controllers\MainController;
use yii\helpers\Json;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * ContatoClienteController implements the CRUD actions for ContatoCliente model.
 */
class ContatoClienteController extends MainController
{

    /**
     * Lists all ContatoCliente models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new ContatoClienteSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single ContatoCliente model.
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
     * Creates a new ContatoCliente model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {

        $model = new ContatoCliente();
        ddd($model->getErrors());

        if (!Yii::$app->request->isAjax) {
            if ($model->load(Yii::$app->request->post()) && $model->save()) {
                return $this->redirect(['index']);
            }

        } else {
            if ($model->load(Yii::$app->request->post()) && $model->save()) {
                Yii::$app->session->removeAllFlashes();
                return Json::encode(['status' => 200, 'id' => $model->id, 'text' => $model->nome]);
            } else {
                return Json::encode([
                    'status' => 500,
                    'content' => $this->renderAjax('_form_modal', [
                        'model' => $model
                    ])
                ]);
            }
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

    /**
     * Updates an existing ContatoCliente model.
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
     * Deletes an existing ContatoCliente model.
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
     * Finds the ContatoCliente model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return ContatoCliente the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = ContatoCliente::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionGetContatoCliente($id = null)
    {

        if (isset($_POST['depdrop_parents'])) {
            $parents = $_POST['depdrop_parents'];

            if ($parents != null) {
                $cliente_id = $parents[0];

                $contatos = ContatoCliente::find()->where(['fk_cliente' => $cliente_id])->all();
                $out = array();

                foreach ($contatos as $contato) {
                    $out[] = array('id' => $contato->id, 'name' => $contato->nome);
                }

                $selected = '';
                return Json::encode(['output'=>$out, 'selected'=> $selected]);

            }
        }
        return Json::encode(['output'=>'', 'selected'=>'']);
    }

    public function actionCreateModal()
    {
        $model = new ContatoCliente();
        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return Json::encode(['status' => 200, 'text' => $model->nome]);
        }else{
            return Json::encode(['status' => 500, 'content' => $this->renderAjax('_form_modal', [
                'model' => $model
            ])]);
        }
    }


}
