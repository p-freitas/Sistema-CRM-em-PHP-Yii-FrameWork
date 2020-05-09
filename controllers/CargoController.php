<?php

namespace app\controllers;

use app\models\Cliente;
use Yii;
use app\models\Cargo;
use app\models\search\CargoSearch;
use app\controllers\MainController;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\Response;
use yii\helpers\Json;

/**
 * CargoController implements the CRUD actions for Cargo model.
 */
class CargoController extends MainController
{


    /**
     * Lists all Cargo models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new CargoSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Cargo model.
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
     * Creates a new Cargo model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Cargo();

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

    public function actionUpdate($fk_entidade, $id)
    {
        Yii::$app->assetManager->bundles = [
            'yii\bootstrap\BootstrapPluginAsset' => false,
            'yii\bootstrap\BootstrapAsset' => false,
            'yii\web\JqueryAsset' => false,
        ];

        $modelCargo = is_null($id) ? new Cargo(['$fk_entidade' => $fk_entidade]) : Cargo::findOne(['$fk_entidade' => $fk_entidade, 'id' => $id]);
        $modelCargo->scenario = 'modelCargo';
        if ($modelCargo->load(Yii::$app->request->post()) && $modelCargo->save()) {
            Yii::$app->session->removeAllFlashes();

            return Json::encode([
                'status' => 200,
                'id' => $modelCargo->id,
                'content' =>
                    "<tr data-id='$modelCargo->id'>
        
                    <td>" . $modelCargo->descricao . "</td>" .
                    "</tr>"

            ]);
        }

        return Json::encode([
            'status' => 500,
            'content' => $this->renderAjax('//cliente/update', [
                'model' => $modelCargo
            ])
        ]);
    }

    /**
     * Deletes an existing Cargo model.
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
     * Finds the Cargo model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Cargo the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Cargo::find()->findCargoByEntidade()->andWhere([Cargo::tableName().'.id' => $id])->one()) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionBuscaAjax($q = null, $id = null)
    {
        \Yii::$app->response->format = Response::FORMAT_JSON;
        $out = ['results' => ['id' => '', 'text' => '']];
        if (!is_null($q)) {
            $data = Cargo::find()->findCargoByEntidade()->select([Cargo::tableName() . '.id', Cargo::tableName() . '.descricao AS text'])->andWhere(['like', Cargo::tableName() . '.descricao', $q])->orderBy(['descricao' => SORT_ASC])->asArray()->all();
            $out['results'] = array_values($data);
        } elseif ($id > 0) {
            $cargo = Cargo::find()->findCargoByEntidade()->andWhere([Cargo::tableName().'.id' => $id])->one();
            $out['results'] = ['id' => $id, 'text' => $cargo->descricao];
        }
        return $out;
    }

    public function actionGetCargoAtual()
    {
        \Yii::$app->response->format = Response::FORMAT_JSON;
        $cargo_atual = null;
        if (Yii::$app->request->get()) {
            $cargo_atual = Cargo::findOne([
                'id' => Yii::$app->request->get('fk_cargo'),
            ]);
        }

        return ['atual' => is_null($cargo_atual) ? '' : $cargo_atual->descricao];
    }
}
