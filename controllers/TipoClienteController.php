<?php

namespace app\controllers;

use Yii;
use yii\helpers\Url;
use app\models\TipoCliente;
use app\models\search\TipoClienteSearch;
use app\controllers\MainController;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\Response;
use yii\helpers\Json;

/**
 * TipoClienteController implements the CRUD actions for TipoCliente model.
 */
class TipoClienteController extends MainController
{

    /**
     * Lists all TipoCliente models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new TipoClienteSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single TipoCliente model.
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
     * Creates a new TipoCliente model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new TipoCliente();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['index']);
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

    /**
     * Updates an existing TipoCliente model.
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
     * Deletes an existing TipoCliente model.
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
     * Finds the TipoCliente model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return TipoCliente the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = TipoCliente::find()->findTipoClienteByEntidade()->andWhere([TipoCliente::tableName().'.id' => $id])->one()) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionBuscaAjax($q = null, $id = null)
    {
        \Yii::$app->response->format = Response::FORMAT_JSON;
        $out = ['results' => ['id' => '', 'text' => '']];
        if (!is_null($q)) {
            $data = TipoCliente::find()->findTipoClienteByEntidade()->select([TipoCliente::tableName() . '.id', TipoCliente::tableName() . '.descricao AS text'])->andWhere(['like', TipoCliente::tableName() . '.descricao', $q])->orderBy(['descricao' => SORT_ASC])->asArray()->all();
            $out['results'] = array_values($data);
        } elseif ($id > 0) {
            $tipo_cliente = TipoCliente::find()->findTipoClienteByEntidade()->andWhere([TipoCliente::tableName().'.id' => $id])->one();
            $out['results'] = ['id' => $id, 'text' => $tipo_cliente->descricao];
        }
        return $out;
    }

    public function actionGetTipoCliente($id){
        if(!isset($id) || empty($id)){
            throw new NotFoundHttpException(Yii::t('app', 'The requested page does not exist.'));
        }else{
            $tipo = TipoCliente::find()->findTipoClienteByEntidade()->andWhere([TipoCliente::tableName().'.id' => $id])->one();
            if($tipo){
                return Json::encode(['rep' => $tipo->descricao]);
            }else{
                throw new NotFoundHttpException(Yii::t('app', 'The requested page does not exist.'));
            }
        }
    }
}
