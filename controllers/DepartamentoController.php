<?php

namespace app\controllers;

use Yii;
use app\models\Departamento;
use app\models\search\DepartamentoSearch;
use app\controllers\MainController;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\Response;
use yii\helpers\Json;

/**
 * DepartamentoController implements the CRUD actions for Departamento model.
 */
class DepartamentoController extends MainController
{

    /**
     * Lists all Departamento models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new DepartamentoSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Departamento model.
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
     * Creates a new Departamento model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Departamento();

        if (!Yii::$app->request->isAjax) {
            if ($model->load(Yii::$app->request->post()) && $model->save()) {
                return $this->redirect(['index']);
            }

        } else {
            if ($model->load(Yii::$app->request->post()) && $model->save()) {
                Yii::$app->session->removeAllFlashes();
                return Json::encode(['status' => 200, 'id' => $model->id, 'text' => $model->descricao]);
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
     * Updates an existing Departamento model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['index']);
        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing Departamento model.
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
     * Finds the Departamento model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Departamento the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Departamento::find()->findDepartamentoByEntidade()->andWhere([Departamento::tableName().'.id' => $id])->one()) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionBuscaAjax($q = null, $id = null)
    {
        \Yii::$app->response->format = Response::FORMAT_JSON;
        $out = ['results' => ['id' => '', 'text' => '']];
        if (!is_null($q)) {
            $data = Departamento::find()->findDepartamentoByEntidade()->select([Departamento::tableName() . '.id', Departamento::tableName() . '.descricao AS text'])->andWhere(['like', Departamento::tableName() . '.descricao', $q])->orderBy(['descricao' => SORT_ASC])->asArray()->all();
            $out['results'] = array_values($data);
        } elseif ($id > 0) {
            $departamento = Departamento::find()->findDepartamentoByEntidade()->andWhere([Departamento::tableName().'.id' => $id])->one();
            $out['results'] = ['id' => $id, 'text' => $departamento->descricao];
        }
        return $out;
    }


}
