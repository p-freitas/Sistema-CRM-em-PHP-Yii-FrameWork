<?php

namespace app\controllers;

use app\models\AtendimentoAnexos;
use app\models\DynamicFormModel;
use app\models\TipoOcorrencia;
use app\models\Usuario;
use DateTime;
use Yii;
use app\models\Atendimento;
use app\models\search\AtendimentoSearch;
use app\controllers\MainController;
use yii\helpers\ArrayHelper;
use yii\helpers\Console;
use yii\helpers\Json;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use app\models\Produto;
use app\models\ContratoProdutos;
use yii\base\Model;
use yii\web\UploadedFile;
use yii\data\Sort;

Yii::$app->params['uploadPath'] = Yii::$app->basePath . '/web/img/';

/**
 * AtendimentoController implements the CRUD actions for Atendimento model.
 */
class AtendimentoController extends MainController
{

    /**
     * Lists all Atendimento models.
     * @return mixed
     */
    public function actionIndex()
    {
        $model = new Atendimento();
        $searchModel = new AtendimentoSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);



        return $this->render('index', [
            'model' => $model,
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Atendimento model.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        $model = $this->findModel($id);
        $modelsAnexo = $model->atendimentoAnexos;


        return $this->render('view', [
            'model' => $model,
            'modelsAnexo' => $modelsAnexo,

        ]);
    }

    /**
     * Creates a new Atendimento model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Atendimento();
        $modelProduto = new Produto();
        $modelAnexo = new AtendimentoAnexos();
        $modelsAnexo = [new AtendimentoAnexos];
        $modelOcorrencia = new TipoOcorrencia();

        if( Yii::$app->request->isAjax && isset($_POST['Atendimento']) ) {

            $errors = CActiveForm::validate($model);

            if($errors !== '[]') {

                Yii::app()->end($errors);

            }else{

                $model->save(false);

                Yii::app()->end($errors);

            }

        }

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            if ($model->solucao != null){
                $model->status = 1;
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

        if ($model->load(Yii::$app->request->post())) {
            if ($model->save()) {
                $data_atendimento = $model->data_atendimento;
                $prazo = $modelOcorrencia->prazo;
                $data_prevista = $model->data_prevista;

                $data_prevista = date('d/m/Y', strtotime("+" . $prazo . " months", strtotime(date($data_atendimento))));

                if ($model->solucao != null) {
                    $model->status = 1;
                } else {
                    $model->status = 0;
                }


                $index = 0;
                $index_foto = 0;
                $index_anexo = 0;

                $model->numero_atendimento = $this->id . '/' . date('Y');

                $modelsAnexo = DynamicFormModel::createMultiple(AtendimentoAnexos::classname());
                DynamicFormModel::loadMultiple($modelsAnexo, Yii::$app->request->post());

                if (!empty($_FILES['AtendimentoAnexos'])) {
                    $files = $_FILES['AtendimentoAnexos'];

                    foreach ($modelsAnexo as $modelAnexo) {
                        if (count($files['name']) > $index_anexo && $files['name'][$index_anexo]['anexo'] != '') {
                            $s3 = Yii::$app->get('s3');
                            $saved = false;
                            while (!$saved) {
                                $nome = rand(0, 9999999);
                                $ext = 'aaa';
                                $exist = $s3->exist('crm/anexos/' . $model->numero_atendimento . '/' . $nome . '.' . $ext);
                                if (!$exist) {
                                    $result = $s3->upload('crm/anexos/' . $model->numero_atendimento . '/' . $nome . '.' . $ext, $files['tmp_name'][$index_anexo]['anexo']);
                                    $modelAnexo->anexo = $result->get('ObjectURL');
                                    $saved = true;
                                }
                            }
                            $modelAnexo->fk_atendimento = $model->id;
                            $modelAnexo->save();
                        }
                        $index_anexo++;
                    }
                }
                return $this->redirect(['index']);
            } else {
                return $this->render('create', [
                    'view' => null,
                    'model' => $model,
                    'modelProduto' => $modelProduto,
                    'modelsAnexo' => (empty($modelsnexo)) ? [new AtendimentoAnexos()] : $modelsAnexo,
                    'modelAnexo' => $modelAnexo,
                    'modelOcorrencia' => $modelOcorrencia,
                ]);
            }
        }


        return $this->render('create', [
            'model' => $model,
            'view' => null,
            'modelProduto' => $modelProduto,
            'modelsAnexo' => (empty($modelsAnexo)) ? [new AtendimentoAnexos()] : $modelsAnexo,
            'modelAnexo' => $modelAnexo,
            'modelOcorrencia' => $modelOcorrencia,
        ]);
    }

    /**
     * Updates an existing Atendimento model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $modelProduto = new Produto();
        $modelAnexo = new AtendimentoAnexos();
        $modelOcorrencia = new TipoOcorrencia();

        $count_produtos = ContratoProdutos::find()->where([ContratoProdutos::tableName() . '.fk_contrato' => $model->id])->count();
        $qtd_produtos = count(Yii::$app->request->post('ContratoProdutos', [])) + $count_produtos;


        if (Yii::$app->request->isPost && !empty($_FILES)) {
            $modelAnexo->load(Yii::$app->request->post());
            $modelAnexo->url = UploadedFile::getInstance($modelAnexo, 'url');
        }

        if ($model->load(Yii::$app->request->post())) {
            if ($model->solucao != null) {
                $model->status = 1;
            } else {
                $model->status = 0;
            }
        }

        if ($model->load(Yii::$app->request->post()) && $model->save() && $modelAnexo->validate()) {

            $prazo = $modelOcorrencia->prazo;
            $str = (string)$prazo;
            $data_atendimento = $model->data_atendimento;
            //$data_atendimento = explode("-", $data_atendimento);

            $model->data_prevista = date('d/m/Y', strtotime($data_atendimento . '+ ' . $prazo . ' days'));

            if ($model->solucao != null) {
                $model->status = 1;

            } else {
                $model->status = 0;
            }

            if (!is_null($modelAnexo->url)) {
                $modelAnexo->fk_atendimento = $model->id;
                $modelAnexo->anexo = $modelAnexo->url->name;
                $tmp = explode('.', $modelAnexo->url->name);
                $ext = end($tmp);
                $modelAnexo->anexo = Yii::$app->security->generateRandomString() . ".{$ext}";
                $modelAnexo->save();
                $path = Yii::$app->params['uploadPath'] . $modelAnexo->anexo;
                $modelAnexo->url->saveAs($path);
            }

            /*if ($qtd_produtos > 0) {
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

            } */

            return $this->redirect(['index']);
        }

        return $this->render('update', [
            'model' => $model,
            'modelProduto' => $modelProduto,
            'modelAnexo' => $modelAnexo,
            'modelOcorrencia' => $modelOcorrencia,
        ]);
    }

    /**
     * Deletes an existing Atendimento model.
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
     * Finds the Atendimento model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Atendimento the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */

    protected function findModel($id)
    {
        if (($model = Atendimento::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionSolucaoCreate()
    {
       // $model = Atendimento::find()->where(['id' => Yii::$app->request->post('Atendimento')['id']])->one(); //achar id do atendimento
        $model = new Atendimento();

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            $model->status = 1;
            $model->save(false);

            return $this->redirect(['/atendimento/create']);
        }
    }

    public function actionSolucaoModal()
    {
        $model = Atendimento::find()->where(['id' => Yii::$app->request->post('Atendimento')['id']])->one(); //achar id do atendimento

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            $model->status = 1;
            $model->save(false);

            return $this->redirect(['/atendimento/index']);
        } else {
            return Json::encode(['status' => 500, 'content' => $this->renderAjax('_form_modal', [
                'model' => $model
            ])]);
        }
    }

    public function actionCancelaAtendimento()


    {
        $model = Atendimento::find()->where(['id' => Yii::$app->request->post('Atendimento')['id']])->one(); //achar id do atendimento

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            $model->status = 2;
            $model->save(false);

            return $this->redirect(['/atendimento/index']);
        } else {
            return Json::encode(['status' => 500, 'content' => $this->renderAjax('_form_cancelamento', [
                'model' => $model
            ])]);
        }
    }
}
