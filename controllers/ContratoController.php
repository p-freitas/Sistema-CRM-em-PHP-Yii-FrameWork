<?php

namespace app\controllers;

use app\models\ContratoProdutos;
use yii\base\Model;
use Yii;
use app\models\Contrato;
use app\models\Aditivo;
use app\models\Produto;
use app\models\search\ContratoSearch;
use app\controllers\MainController;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\UploadedFile;
use Aws\S3\S3Client;
use yii\web\Response;
use yii\helpers\Json;

/**
 * ContratoController implements the CRUD actions for Contrato model.
 */
class ContratoController extends MainController
{

    /**
     * Lists all Contrato models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new ContratoSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Contrato model.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        $model = $this->findModel($id);
        $aditivos = $model->aditivos;

        return $this->render('view', [
            'model' => $model,
            'aditivos' => $aditivos,
        ]);
    }

    /**
     * Creates a new Contrato model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Contrato();
        $modelProduto = new Produto();
        $modelsAditivo = null;
        $aditivo = new Aditivo;

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {

            $anexo = UploadedFile::getInstance($model, 'anexo');
            if (!is_null($anexo)) {
                $s3 = Yii::$app->get('s3');
                $saved = false;
                while (!$saved) {
                    $nome = rand(0, 9999999);
                    $exist = $s3->exist('crm/anexos/' . $model->numero . '/' . $nome . '.' . $anexo->extension);

                    if (!$exist) {
                        $result = $s3->upload('crm/anexos/' . $model->numero . '/' . $nome . '.' . $anexo->extension, $anexo->tempName);
                        $model->anexo = $result->get('ObjectURL');
                        $saved = true;
                    }
                }
            }


            $model->save(false);
            $qtd_produtos = count(Yii::$app->request->post('ContratoProdutos', []));

            if ($qtd_produtos > 0) {
                $produtos = [new ContratoProdutos()];
                for ($g = 0; $g < $qtd_produtos; $g++) {
                    $produtos[] = new ContratoProdutos();
                }
                Model::loadMultiple($produtos, Yii::$app->request->post());

                foreach ($produtos as $produto) {
                    $produto->fk_contrato = $model->id;
                    $produto->save();
                }
            } else {
                $produtos = null;
            }


            return $this->redirect(['index']);
        }

        return $this->render('create', [
            'model' => $model,
            'modelProduto' => $modelProduto,
            'modelsAditivo' => $modelsAditivo,
            'aditivo' => $aditivo,
        ]);
    }

    /**
     * Updates an existing Contrato model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $modelProduto = new Produto();
        $modelsAditivo = null;
        $aditivo = new Aditivo();

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {

            $anexo = UploadedFile::getInstance($model, 'anexo');
            if (!is_null($anexo)) {
                $s3 = Yii::$app->get('s3');
                $saved = false;
                while (!$saved) {
                    $nome = rand(0, 9999999);
                    $exist = $s3->exist('crm/anexos/' . $model->numero . '/' . $nome . '.' . $anexo->extension);

                    if (!$exist) {
                        $result = $s3->upload('crm/anexos/' . $model->numero . '/' . $nome . '.' . $anexo->extension, $anexo->tempName);
                        $model->anexo = $result->get('ObjectURL');
                        $saved = true;
                    }
                }
            }

            $model->save(false);

            $count_produtos = ContratoProdutos::find()->where([ContratoProdutos::tableName() . '.fk_contrato' => $model->id])->count();
            $qtd_produtos = count(Yii::$app->request->post('ContratoProdutos', [])) + $count_produtos;

            if ($qtd_produtos > 0) {
                $produtos = [new ContratoProdutos()];
                for ($g = 1; $g < $qtd_produtos; $g++) {
                    $produtos[] = new ContratoProdutos();
                }
                Model::loadMultiple($produtos, Yii::$app->request->post());
                $not_exclude_produtos = array();

                foreach ($produtos as $produto) {
                    if (!is_null($produto->fk_produto) || !empty($produto->fk_produto)) {
                        $existe_produto = ContratoProdutos::findOne(['fk_contrato' => $model->id, 'fk_produto' => $produto->fk_produto]);
                        if (is_null($existe_produto)) {
                            $existe_produto = new ContratoProdutos();
                            $existe_produto->fk_produto = $produto->fk_produto;
                            $existe_produto->fk_contrato = $model->id;
                            $existe_produto->save();
                            $not_exclude_produtos[] = $existe_produto->id;
                        } else {
                            $not_exclude_produtos[] = $existe_produto->id;
                        }
                    }
                }
                ContratoProdutos::deleteAll(['and', ['fk_contrato' => $model->id], ['not in', 'id', $not_exclude_produtos]]);

            } else {
                $produtos = null;
            }

            $count_aditivos = Aditivo::find()->where([Aditivo::tableName() . '.fk_contrato' => $model->id])->count();
            $qtd_aditivos = count(Yii::$app->request->post('Aditivo', [])) + $count_aditivos;

            if ($qtd_aditivos > 0) {
                $aditivos = [new Aditivo()];
                for ($a = 1; $a < $qtd_aditivos; $a++) {
                    $aditivos[] = new Aditivo();
                }
                Model::loadMultiple($aditivos, Yii::$app->request->post());
                $not_exclude_aditivos = array();
                $anexo_aditivo = $_FILES['Aditivo'];
                $index_aditivo = 0;

                foreach ($aditivos as $aditivo) {
                    if (!is_null($aditivo->numero) || !empty($aditivo->numero)) {
                        $existe_aditivo = Aditivo::findOne(['fk_contrato' => $model->id, 'id' => $aditivo->id_edit_aditivo]);
                        $existe_aditivo->numero = $aditivo->numero;
                        $existe_aditivo->data_inicio = $aditivo->data_inicio;
                        $existe_aditivo->data_termino = $aditivo->data_termino;
                        $existe_aditivo->valor = $aditivo->valor;
                        $existe_aditivo->justificativa = $aditivo->justificativa;

                        if (is_null($existe_aditivo->anexo) || empty($existe_aditivo->anexo)) {
                            if ($anexo_aditivo['name'][$index_aditivo]['anexo'] != '') {
                                $s3 = Yii::$app->get('s3');
                                $saved = false;
                                while (!$saved) {
                                    $nome = rand(0, 9999999);
                                    $ext = explode(".", $anexo_aditivo['name'][$index_aditivo]['anexo']);
                                    $exist = $s3->exist('crm/anexos/' . $existe_aditivo->numero . '/' . $nome . '.' . $ext[1]);
                                    if (!$exist) {
                                        $result = $s3->upload('crm/anexos/' . $existe_aditivo->numero . '/' . $nome . '.' . $ext[1], $anexo_aditivo['tmp_name'][$index_aditivo]['anexo']);
                                        $existe_aditivo->anexo = $result->get('ObjectURL');
                                        $saved = true;
                                    }
                                }
                            }
                        } else {
                            if ($anexo_aditivo['name'][$index_aditivo]['anexo'] != '') {
                                $s3 = Yii::$app->get('s3');
                                $nomeArquivo = explode('/', $existe_aditivo->anexo)[7];
                                if ($s3->exist('crm/anexos/' . $existe_aditivo->numero . '/' . $nomeArquivo)) {
                                    $s3->delete('crm/anexos/' . $existe_aditivo->numero . '/' . $nomeArquivo);
                                }
                                $saved = false;
                                while (!$saved) {
                                    $nome = rand(0, 9999999);
                                    $ext = explode("/", $anexo_aditivo['type'][$index_aditivo]['anexo']);
                                    $exist = $s3->exist('crm/anexos/' . $existe_aditivo->numero . '/' . $nome . '.' . $ext[1]);
                                    if (!$exist) {
                                        $result = $s3->upload('crm/anexos/' . $existe_aditivo->numero . '/' . $nome . '.' . $ext[1], $anexo_aditivo['tmp_name'][$index_aditivo]['anexo']);
                                        $existe_aditivo->anexo = $result->get('ObjectURL');
                                        $saved = true;
                                    }
                                }
                            }
                        }
                        $existe_aditivo->save();
                        $not_exclude_aditivos[] = $existe_aditivo->id;
                        $index_aditivo++;
                    }
                }
                Aditivo::deleteAll(['and', ['fk_contrato' => $model->id], ['not in', 'id', $not_exclude_aditivos]]);
            }

            return $this->redirect(['index']);
        }

        return $this->render('update', [
            'model' => $model,
            'modelProduto' => $modelProduto,
            'modelsAditivo' => $modelsAditivo,
            'aditivo' => $aditivo,
        ]);
    }

    /**
     * Deletes an existing Contrato model.
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
     * Finds the Contrato model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Contrato the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Contrato::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }


    public function actionGetContratoCliente($id = null)
    {

        if (isset($_POST['depdrop_parents'])) {
            $parents = $_POST['depdrop_parents'];

            if ($parents != null) {
                $cliente_id = $parents[0];

                $contratos = Contrato::find()->where(['fk_cliente' => $cliente_id])->all();
                $out = array();

                foreach ($contratos as $contrato) {
                    $out[] = array('id' => $contrato->id, 'name' => $contrato->numero);
                }

                return Json::encode(['output' => $out, 'selected' => $id]);

            }
        }
        return Json::encode(['output'=>'', 'selected'=>'']);
    }

    public function actionGetDetails()
    {

       // foreach ($aditivos as $aditivo){
            if (isset($_POST['expandRowKey'])) {
                $model = Contrato::find()->where([Contrato::tableName() . '.id' => $_POST['expandRowKey']])->one();
               // $locais = LocalBem::find()->innerJoin(Bem::tableName(), Bem::tableName() . '.id=' . LocalBem::tableName() . '.fk_bem')->andWhere([LocalBem::tableName() . '.fk_bem' => $_POST['expandRowKey']])->orderBy([LocalBem::tableName() . '.id' => SORT_DESC])->one();
             //   $compra = CompraBem::find()->innerJoin(Bem::tableName(), Bem::tableName() . '.fk_compra_bem=' . CompraBem::tableName() . '.id')->andWhere([Bem::tableName() . '.id' => $_POST['expandRowKey']])->one();
                $aditivo = Aditivo::find()->where([Aditivo::tableName() . '.fk_contrato' => $_POST['expandRowKey']])->one();

                return $this->renderPartial('_contrato_details', [
                    'model' => $model,
                    'aditivo' => $aditivo,
                ]);
            } else {
                return '<div class="alert alert-danger">Dados não encontrados</div>';
            }
      //  }
    }

    public function actionDesligaContrato($id){
        $model = $this->findModel($id);

        if ($model->status == 0){
            $model->status = 2;
            $model->save();

            Yii::$app->session->setFlash('success', 'Contrato cancelado com sucesso');
        }

        return $this->redirect(['index']);
    }

    public function actionAtivaContrato($id){
        $model = $this->findModel($id);

        if ($model->status == 0){
            $model->status = 1;
            $model->save();

            Yii::$app->session->setFlash('success', 'Contrato ativado com sucesso');
        }

        return $this->redirect(['index']);
    }



}
