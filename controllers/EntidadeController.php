<?php

namespace app\controllers;

use Aws\S3\S3Client;
use Yii;
use app\models\Entidade;
use app\models\search\EntidadeSearch;
use yii\web\NotFoundHttpException;
use yii\web\Response;
use yii\web\UploadedFile;

Yii::$app->params['uploadPath'] = Yii::$app->basePath . '/web/img/';

/**
 * EntidadeController implements the CRUD actions for Entidade model.
 */
class EntidadeController extends MainController
{
    /**
     * Lists all Entidade models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new EntidadeSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Entidade model.
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
     * Creates a new Entidade model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Entidade();

        if ($model->load(Yii::$app->request->post())) {

            $imagem = UploadedFile::getInstance($model, 'logo_marca');
            if (!is_null($imagem)) {
                $s3 = Yii::$app->get('s3');
                $saved = false;
                while (!$saved) {
                    $nome = rand(0, 9999999);
                    $exist = $s3->exist('crm/images/entidade/' . $nome . '.' . $imagem->extension);

                    if (!$exist) {
                        $result = $s3->upload('crm/images/entidade/' . $nome . '.' . $imagem->extension, $imagem->tempName);
                        $model->brasao = $result->get('ObjectURL');
                        $saved = true;
                    }
                }
            }

            if ($model->save()) {
                return $this->redirect(['index']);
            } else {
                $model->cnpj = Yii::$app->formatter->asCgc($model->cnpj);
                return $this->render('create', [
                    'model' => $model,
                ]);
            }
        } else {
            return $this->render('create', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing Entidade model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $exist = $model->logo_marca;

        if ($model->load(Yii::$app->request->post())) {

            $image = UploadedFile::getInstance($model, 'logo_marca');
            //echo '<pre>'; print_r($exist); exit;
            if(!is_null($image) ){

                $model->logo_marca = $image->name;
                $tmp = explode('.', $image->name);
                $ext = end($tmp);

                if($ext == 'png'){
                    Yii::$app->session->setFlash('danger', ' Formato de imagem inválido - '.$ext);
                    return $this->render('update', [
                        'model' => $model
                    ]);
                }

                $model->logo_marca = Yii::$app->security->generateRandomString().".{$ext}";
                $path = Yii::$app->params['uploadPath']. $model->logo_marca;
                $image->saveAs($path);
            }else if (is_null($image) && !is_null($exist)){
                $model->logo_marca = $exist;
            }

            if ($model->save()) {
                return $this->redirect(['index']);
            } else {
                $model->cnpj = Yii::$app->formatter->asCgc($model->cnpj);
                return $this->render('update', [
                    'model' => $model,
                ]);
            }
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing Entidade model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id)
    {
        $model = $this->findModel($id);
        if (!empty($model->logo_marca)) {
            $s3 = Yii::$app->get('s3');
            $nomeArquivo = explode('/', $model->logo_marca)[6];
            if ($s3->exist('patrimonio/images/' . $nomeArquivo))
                $s3->delete('patrimonio/images/' . $nomeArquivo);
        }

        $model->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the Entidade model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Entidade the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Entidade::findOne([Entidade::tableName() . '.id' => $id])) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

    public function actionBuscaAjax($q = null, $id = null)
    {
        \Yii::$app->response->format = Response::FORMAT_JSON;
        $out = ['results' => ['id' => '', 'text' => '']];
        if (!is_null($q)) {
            $data = Entidade::find()->select([Entidade::tableName() . '.id', Entidade::tableName() . ".razao_social AS text"])->where(['like', Entidade::tableName() . '.razao_social', $q])->asArray()->all();
            $out['results'] = array_values($data);
        } elseif ($id > 0) {
            $entidade = Entidade::findOne([Entidade::tableName() . '.id' => $id]);
            $out['results'] = ['id' => $id, 'text' => $entidade->razao_social];
        }
        return $out;
    }
}
