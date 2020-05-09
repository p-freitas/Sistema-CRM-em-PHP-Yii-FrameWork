<?php

namespace app\controllers;

use Yii;
use app\models\TipoOrgao;
use app\models\search\TipoOrgaoSearch;
use app\controllers\MainController;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\Response;
use yii\helpers\Json;

/**
 * TipoOrgaoController implements the CRUD actions for TipoOrgao model.
 */
class TipoOrgaoController extends MainController
{

    /**
     * Lists all TipoOrgao models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new TipoOrgaoSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single TipoOrgao model.
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
     * Creates a new TipoOrgao model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new TipoOrgao();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['index']);
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

    /**
     * Updates an existing TipoOrgao model.
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
     * Deletes an existing TipoOrgao model.
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
     * Finds the TipoOrgao model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return TipoOrgao the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = TipoOrgao::find()->findTipoOrgaoByEntidade()->andWhere([TipoOrgao::tableName().'.id' => $id])->one()) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionBuscaAjax($q = null, $id = null)
    {
        \Yii::$app->response->format = Response::FORMAT_JSON;
        $out = ['results' => ['id' => '', 'text' => '']];
        if (!is_null($q)) {
            $data = TipoOrgao::find()->findTipoOrgaoByEntidade()->select([TipoOrgao::tableName() . '.id', TipoOrgao::tableName() . '.descricao AS text'])->andWhere(['like', TipoOrgao::tableName() . '.descricao', $q])->orderBy(['descricao' => SORT_ASC])->asArray()->all();
            $out['results'] = array_values($data);
        } elseif ($id > 0) {
            $tipo_orgao = TipoOrgao::find()->findTipoOrgaoByEntidade()->andWhere([TipoOrgao::tableName().'.id' => $id])->one();
            $out['results'] = ['id' => $id, 'text' => $tipo_orgao->descricao];
        }
        return $out;
    }
}
