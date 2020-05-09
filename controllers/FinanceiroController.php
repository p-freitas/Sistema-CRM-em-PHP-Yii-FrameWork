<?php

namespace app\controllers;

use Yii;
use app\models\Financeiro;
use app\models\search\FinanceiroSearch;
use app\controllers\MainController;
use yii\helpers\Json;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * FinanceiroController implements the CRUD actions for Financeiro model.
 */
class FinanceiroController extends MainController
{

    /**
     * Lists all Financeiro models.
     * @return mixed
     */
    public function actionIndex()
    {
        $model = new Financeiro();
        $searchModel = new FinanceiroSearch(['tipo' => 1]);
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'model' => $model,
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    public function actionIndexReceber()
    {
        $searchModel = new FinanceiroSearch(['tipo' => 2]);
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index-receber', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }



    /**
     * Displays a single Financeiro model.
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
     * Creates a new Financeiro model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate($tipo)
    {
        $model = new Financeiro();

        if ($tipo == 1){
            $model->scenario = 'ContaPagar';
        }else if ($tipo == 2){
            $model->scenario = 'ContaReceber';
        }


        if ($model->load(Yii::$app->request->post()) && $model->save()) {

            if ($model->scenario == 'ContaPagar'){
                return $this->redirect(['index']);
            }else{
                return $this->redirect(['index-receber']);
            }

        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

    /**
     * Updates an existing Financeiro model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post())) {
            if ($model->valor_pgto = null){
                $model->saldo = floatval(str_replace(',', '.', $model->saldo));
                $model->valor_pgto = floatval(str_replace(',', '.', $model->valor_pgto));

                $saldo_atual = floatval($model->getOldAttribute('saldo'));
                $saldo_atual = floatval(number_format($saldo_atual, 2,'.',''));

                $model->saldo = $saldo_atual - $model->valor_pgto;

                $model->save();

            }
        }

        if ($model->load(Yii::$app->request->post()) && $model->save()) {

            if ($model->tipo == 1){
                return $this->redirect(['index']);
            }else{
                return $this->redirect(['index-receber']);
            }

        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing Financeiro model.
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
     * Finds the Financeiro model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Financeiro the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Financeiro::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionBaixa()
    {
        $model = Financeiro::find()->where(['id' => Yii::$app->request->post('Financeiro')['id']])->one(); //achar id da conta

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            $saldo = $model->saldo;
            $saldo = str_replace(',', '.', str_replace(".","", $saldo));

            $valor_baixa = $model->valor_pgto;
            $valor_baixa = str_replace(',', '.', str_replace(".","", $valor_baixa));

            $saldo = floatval($saldo) - floatval($valor_baixa);

            if ($saldo == 0)
                $model->situacao = 1;
            if ($saldo > 0 )
                $model->situacao = 2;

            $model->save(false);

            return $this->redirect(['/financeiro/index']);
        } else {
            return Json::encode(['status' => 500, 'content' => $this->renderAjax('_form_modal', [
                'model' => $model
            ])]);
        }
    }
}
