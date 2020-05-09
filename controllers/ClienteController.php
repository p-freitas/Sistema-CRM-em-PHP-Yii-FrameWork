<?php

namespace app\controllers;

use app\models\Cargo;
use app\models\DynamicFormModel;
use Yii;
use app\models\Cliente;
use app\models\ContatoCliente;
use app\models\Gestao;
use app\models\AnexosDocumentos;
use app\models\Telefone;
use app\models\search\ClienteSearch;
use app\controllers\MainController;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\base\Model;
use yii\web\Response;
use yii\web\UploadedFile;
use Aws\S3\S3Client;
use yii\helpers\ArrayHelper;


/**
 * ClienteController implements the CRUD actions for Cliente model.
 */
class ClienteController extends MainController
{

    /**
     * Lists all Cliente models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new ClienteSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    public function actionIndexCard()
    {
        $clientes = Cliente::find()->findClienteByEntidade()->all();


        $searchModel = new ClienteSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index-card', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
            'clientes' => $clientes,
        ]);
    }

    /**
     * Displays a single Cliente model.
     * @param integer $id
     * @param integer $fk_representante
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
     * Creates a new Cliente model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Cliente();
        $modelContato = new ContatoCliente();
        $modelGestao = new Gestao;
        $modelTelefone = new Telefone();
        $modelsAnexoDocumento = [new AnexosDocumentos];
        $contatos = null;
        $telefones = null;
        $gestoes = null;

        if ($model->load(Yii::$app->request->post())) {

            $qtd_contatos = count(Yii::$app->request->post('ContatoCliente', []));
            $qtd_telefones = count(Yii::$app->request->post('Telefone', []));
            $qtd_gestaoes = count(Yii::$app->request->post('Gestao', []));

            if ($qtd_gestaoes > 0) {
                $gestoes = [new Gestao()];
                for ($g = 0; $g < $qtd_gestaoes; $g++) {
                    $gestoes[] = new Gestao();
                }
                Model::loadMultiple($gestoes, Yii::$app->request->post());
            } else {
                $gestoes = null;
            }

            if ($qtd_contatos > 0) {
                $contatos = [new ContatoCliente()];
                for ($i = 1; $i < $qtd_contatos; $i++) {
                    $contatos[] = new ContatoCliente();
                }
                Model::loadMultiple($contatos, Yii::$app->request->post());
            } else {
                $contatos = null;
            }

            if ($qtd_telefones > 0) {
                $telefones = [new Telefone()];
                for ($j = 1; $j < $qtd_telefones; $j++) {
                    $telefones[] = new Telefone();
                }
                Model::loadMultiple($telefones, Yii::$app->request->post());
            } else {
                $telefones = null;
            }

            $imagem = UploadedFile::getInstance($model, 'brasao');
            if (!is_null($imagem)) {
                $s3 = Yii::$app->get('s3');
                $saved = false;
                while (!$saved) {
                    $nome = rand(0, 9999999);
                    $exist = $s3->exist('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $imagem->extension);

                    if (!$exist) {
                        $result = $s3->upload('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $imagem->extension, $imagem->tempName);
                        $model->brasao = $result->get('ObjectURL');
                        $saved = true;
                    }
                }
            }

            if ($model->save()) {

                if (!is_null($gestoes)) {
                    foreach ($gestoes as $gestao) {
                        $gestao->fk_cliente = $model->id;
                        $gestao->save();
                    }
                }

                $index = 0;
                $index_foto = 0;
                $index_anexo = 0;

                $modelsAnexoDocumento = DynamicFormModel::createMultiple(AnexosDocumentos::classname());
                DynamicFormModel::loadMultiple($modelsAnexoDocumento, Yii::$app->request->post());

                if (!empty($_FILES['AnexosDocumentos'])) {
                    $files = $_FILES['AnexosDocumentos'];

                    foreach ($modelsAnexoDocumento as $modelAnexoDocumento) {
                        if (count($files['name']) > $index_anexo && $files['name'][$index_anexo]['anexo'] != '') {
                            $s3 = Yii::$app->get('s3');
                            $saved = false;
                            while (!$saved) {
                                $nome = rand(0, 9999999);
                                $ext = explode(".", $files['name'][$index_anexo]['anexo']);
                                $exist = $s3->exist('crm/anexos/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1]);
                                if (!$exist) {
                                    $result = $s3->upload('crm/anexos/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1], $files['tmp_name'][$index_anexo]['anexo']);
                                    $modelAnexoDocumento->anexo = $result->get('ObjectURL');
                                    $saved = true;
                                }
                            }
                            $modelAnexoDocumento->fk_cliente = $model->id;
                            $modelAnexoDocumento->save();
                        }
                        $index_anexo++;
                    }
                }

                if (!empty($_FILES['ContatoCliente'])) {
                    $fotos = $_FILES['ContatoCliente'];
                }

                if (!is_null($contatos)) {
                    foreach ($contatos as $contato) {

                        if (count($fotos['name']) > $index_foto && $fotos['name'][$index_foto]['foto'] != '') {
                            $s3 = Yii::$app->get('s3');
                            $saved = false;
                            while (!$saved) {
                                $nome = rand(0, 9999999);
                                $ext = explode("/", $fotos['type'][$index_foto]['foto']);
                                $exist = $s3->exist('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1]);
                                if (!$exist) {
                                    $result = $s3->upload('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1], $fotos['tmp_name'][$index_foto]['foto']);
                                    $contato->foto = $result->get('ObjectURL');
                                    $saved = true;
                                }
                            }
                        }

                        $contato->fk_cliente = $model->id;
                        $contato->save();

                        for ($l = 0; $l < $qtd_telefones; $l++) {

                            if ($telefones[$l]['contato_index'] == $index) {
                                $telefones[$l]['fk_contato_cliente'] = $contato->id;
                                $telefones[$l]->save();
                            }
                        }
                        $index++;
                        $index_foto++;
                    }
                }
                return $this->redirect(['index']);
            } else {
                return $this->render('create', [
                    'view' => null,
                    'model' => $model,
                    'modelContato' => $modelContato,
                    'modelGestao' => $modelGestao,
                    'modelTelefone' => $modelTelefone,
                    'modelsAnexoDocumento' => (empty($modelsnexoDocumento)) ? [new AnexosDocumentos] : $modelsAnexoDocumento,
                    'contatos' => $contatos,
                    'telefones' => $telefones,
                    'gestoes' => $gestoes,
                ]);
            }
        }

        return $this->render('create', [
            'view' => null,
            'model' => $model,
            'modelContato' => $modelContato,
            'modelGestao' => $modelGestao,
            'modelTelefone' => $modelTelefone,
            'modelsAnexoDocumento' => (empty($modelsnexoDocumento)) ? [new AnexosDocumentos] : $modelsAnexoDocumento,
            'contatos' => $contatos,
            'telefones' => $telefones,
            'gestoes' => $gestoes,
        ]);
    }

    /**
     * Updates an existing Cliente model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @param integer $fk_representante
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $modelContato = new ContatoCliente();
        $modelTelefone = new Telefone();
        $modelGestao = new Gestao();
        $modelsAnexoDocumento = $model->anexosDocumentos;

        $contatos = null;
        $telefones = null;
        $gestoes = null;

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {

            $count_contatos = ContatoCliente::find()->where([ContatoCliente::tableName() . '.fk_cliente' => $model->id])->count();
            $count_telefones = Telefone::find()->innerJoin(ContatoCliente::tableName(), ContatoCliente::tableName() . '.id=' . Telefone::tableName() . '.fk_contato_cliente')->innerJoin(Cliente::tableName(), Cliente::tableName() . '.id=' . ContatoCliente::tableName() . '.fk_cliente')->where([Cliente::tableName() . '.id' => $model->id])->count();
            $count_gestoes = Gestao::find()->where([Gestao::tableName() . '.fk_cliente' => $model->id])->count();
            $qtd_contatos = count(Yii::$app->request->post('ContatoCliente', [])) + $count_contatos;
            $qtd_telefones = count(Yii::$app->request->post('Telefone', [])) + $count_telefones;
            $qtd_gestoes = count(Yii::$app->request->post('Gestao', [])) + $count_gestoes;

            $exclude_contato = ContatoCliente::find()->where([ContatoCliente::tableName() . '.fk_cliente' => $model->id])->asArray()->indexBy('id')->column();

            $imagem = UploadedFile::getInstance($model, 'brasao');
            if (!is_null($imagem)) {
                if (is_null($model->brasao) || empty($model->brasao)) {
                    $s3 = Yii::$app->get('s3');
                    $saved = false;
                    while (!$saved) {
                        $nome = rand(0, 9999999);
                        $exist = $s3->exist('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $imagem->extension);

                        if (!$exist) {
                            $result = $s3->upload('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $imagem->extension, $imagem->tempName);
                            $model->brasao = $result->get('ObjectURL');
                            $saved = true;
                        }
                    }
                } else {
                    $s3 = Yii::$app->get('s3');
                    $nomeArquivo = explode('/', $model->brasao)[7];
                    if ($s3->exist('crm/imagens/' . $model->cpf_cnpj . '/' . $nomeArquivo)) {
                        $s3->delete('crm/imagens/' . $model->cpf_cnpj . '/' . $nomeArquivo);
                    }
                    $saved = false;
                    while (!$saved) {
                        $nome = rand(0, 9999999);
                        $exist = $s3->exist('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $imagem->extension);

                        if (!$exist) {
                            $result = $s3->upload('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $imagem->extension, $imagem->tempName);
                            $model->brasao = $result->get('ObjectURL');
                            $saved = true;
                        }
                    }
                }
            } else {
                $model->brasao = $model->getOldAttribute('brasao');
            }
            if ($model->situacao != $model->getOldAttribute('situacao')) {
                $model->data_situacao = date("Y-m-d");
            }
            $model->save(false);

            if ($qtd_gestoes > 0) {
                $gestoes = [new Gestao()];
                for ($g = 1; $g < $qtd_gestoes; $g++) {
                    $gestoes[] = new Gestao();
                }
                Model::loadMultiple($gestoes, Yii::$app->request->post());

                $not_exclude_gestao = array();

                foreach ($gestoes as $gestao) {
                    if (!is_null($gestao->prefeito) || !empty($gestao->prefeito)) {
                        $existe_gestao = Gestao::findOne(['fk_cliente' => $model->id, 'id' => $gestao->id_edit_gestao]);

                        if (is_null($existe_gestao)) {
                            $existe_gestao = new Gestao();
                            $existe_gestao->fk_cliente = $model->id;
                            $existe_gestao->periodo = $gestao->periodo;
                            $existe_gestao->prefeito = $gestao->prefeito;
                            $existe_gestao->data_nascimento = $gestao->data_nascimento;
                            $existe_gestao->vice_prefeito = $gestao->vice_prefeito;
                            $existe_gestao->save();
                            $not_exclude_gestao[] = $existe_gestao->id;
                        }else{
                            $existe_gestao->periodo = $gestao->periodo;
                            $existe_gestao->prefeito = $gestao->prefeito;
                            $existe_gestao->data_nascimento = $gestao->data_nascimento;
                            $existe_gestao->vice_prefeito = $gestao->vice_prefeito;
                            $existe_gestao->save();
                            $not_exclude_gestao[] = $existe_gestao->id;
                        }
                    }
                }
                Gestao::deleteAll(['and', ['fk_cliente' => $model->id], ['not in', 'id', $not_exclude_gestao]]);
            } else {
                $gestoes = null;
            }


            $index = 0;
            $index_foto = 0;
            $index_anexo = 0;

            $exclude_anexo = ArrayHelper::map($modelsAnexoDocumento, 'id', 'id');
            $modelsAnexoDocumento = DynamicFormModel::createMultiple(AnexosDocumentos::classname(), $modelsAnexoDocumento);
            DynamicFormModel::loadMultiple($modelsAnexoDocumento, Yii::$app->request->post());
            $deletedIDsAnexos = array_diff($exclude_anexo, array_filter(ArrayHelper::map($modelsAnexoDocumento, 'id', 'id')));

            if (!empty($_FILES['AnexosDocumentos'])) {
                $files = $_FILES['AnexosDocumentos'];
                foreach ($modelsAnexoDocumento as $modelAnexoDocumento) {
                    if ($files['name'][$index_anexo]['anexo'] != '') {
                        $s3 = Yii::$app->get('s3');
                        $saved = false;
                        while (!$saved) {
                            $nome = rand(0, 9999999);
                            $ext = explode(".", $files['name'][$index_anexo]['anexo']);
                            $exist = $s3->exist('crm/anexos/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1]);
                            if (!$exist) {
                                $result = $s3->upload('crm/anexos/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1], $files['tmp_name'][$index_anexo]['anexo']);
                                $modelAnexoDocumento->anexo = $result->get('ObjectURL');
                                $saved = true;
                            }
                        }
                        $modelAnexoDocumento->fk_cliente = $model->id;
                        $modelAnexoDocumento->save();
                    }
                    $index_anexo++;
                }
            }

            if (!empty($deletedIDsAnexos)) {
                foreach ($deletedIDsAnexos as $s3Delete) {
                    $nome = AnexosDocumentos::find()->select('anexo')->where([AnexosDocumentos::tableName() . '.id' => $s3Delete])->one();
                    $nomeArquivo = explode('/', $nome->anexo)[7];
                    $s3 = Yii::$app->get('s3');
                    if ($s3->exist('crm/anexos/' . $model->cpf_cnpj . '/' . $nomeArquivo)) {
                        $s3->delete('crm/anexos/' . $model->cpf_cnpj . '/' . $nomeArquivo);
                    }
                }
                AnexosDocumentos::deleteAll(['id' => $deletedIDsAnexos]);
            }

            if ($qtd_contatos > 0) {
                $contatos = [new ContatoCliente()];
                for ($i = 1; $i < $qtd_contatos; $i++) {
                    $contatos[] = new ContatoCliente();
                }
                Model::loadMultiple($contatos, Yii::$app->request->post());
            } else {
                $contatos = null;
            }

            if ($qtd_telefones > 0) {
                for ($j = 0; $j < $qtd_telefones; $j++) {
                    $telefones[] = new Telefone();

                }
                Model::loadMultiple($telefones, Yii::$app->request->post());
            }

            if (!is_null($contatos)) {
                $not_exclude_contato  = [];
                $not_exclude_telefone = [];

                if (!empty($_FILES['ContatoCliente'])) {
                    $fotos = $_FILES['ContatoCliente'];
                }


                foreach ($contatos as $contato) {
                    if (is_null($contato->fk_cargo) || empty($contato->fk_cargo)) {
                        $index++;
                        $index_foto++;
                    } else {
                        //se o id_edit vier vazio, significa que é um novo contato
                        $existe_contato = ContatoCliente::findOne(['fk_cliente' => $model->id, 'id' => $contato->id_edit]);

                        if (is_null($existe_contato)) {
                            $existe_contato = new ContatoCliente();

                            if (count($fotos['name']) > $index_foto && $fotos['name'][$index_foto]['foto'] != '') {
                                $s3 = Yii::$app->get('s3');
                                $saved = false;
                                while (!$saved) {
                                    $nome = rand(0, 9999999);
                                    $ext = explode("/", $fotos['type'][$index_foto]['foto']);
                                    $exist = $s3->exist('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1]);
                                    if (!$exist) {
                                        $result = $s3->upload('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1], $fotos['tmp_name'][$index_foto]['foto']);
                                        $existe_contato->foto = $result->get('ObjectURL');
                                        $saved = true;
                                    }
                                }
                            }
                            $existe_contato->nome = $contato->nome;
                            $existe_contato->email = $contato->email;
                            $existe_contato->data_nascimento = $contato->data_nascimento;
                            $existe_contato->fk_departamento = $contato->fk_departamento;
                            $existe_contato->fk_cargo = $contato->fk_cargo;
                            $existe_contato->fk_cliente = $model->id;
                            $existe_contato->save();
                            $not_exclude_contato[] = $existe_contato->id;
                            unset($exclude_contato[$existe_contato->id]);
                        } else {
                            if (is_null($existe_contato->foto) || empty($existe_contato->foto)) {
                                if (count($fotos['name']) > $index_foto && $fotos['name'][$index_foto]['foto'] != '') {
                                    $s3 = Yii::$app->get('s3');
                                    $saved = false;
                                    while (!$saved) {
                                        $nome = rand(0, 9999999);
                                        $ext = explode("/", $fotos['type'][$index_foto]['foto']);
                                        $exist = $s3->exist('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1]);
                                        if (!$exist) {
                                            $result = $s3->upload('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1], $fotos['tmp_name'][$index_foto]['foto']);
                                            $existe_contato->foto = $result->get('ObjectURL');
                                            $saved = true;
                                        }
                                    }
                                }
                            } else {
                                if (count($fotos['name']) > $index_foto && $fotos['name'][$index_foto]['foto'] != '') {
                                    $s3 = Yii::$app->get('s3');
                                    $nomeArquivo = explode('/', $existe_contato->foto)[7];
                                    if ($s3->exist('crm/imagens/' . $model->cpf_cnpj . '/' . $nomeArquivo)) {
                                        $s3->delete('crm/imagens/' . $model->cpf_cnpj . '/' . $nomeArquivo);
                                    }
                                    $saved = false;
                                    while (!$saved) {
                                        $nome = rand(0, 9999999);
                                        $ext = explode("/", $fotos['type'][$index_foto]['foto']);
                                        $exist = $s3->exist('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1]);
                                        if (!$exist) {
                                            $result = $s3->upload('crm/imagens/' . $model->cpf_cnpj . '/' . $nome . '.' . $ext[1], $fotos['tmp_name'][$index_foto]['foto']);
                                            $existe_contato->foto = $result->get('ObjectURL');
                                            $saved = true;
                                        }
                                    }
                                }
                            }
                            $existe_contato->nome = $contato->nome;
                            $existe_contato->email = $contato->email;
                            $existe_contato->data_nascimento = $contato->data_nascimento;
                            $existe_contato->fk_departamento = $contato->fk_departamento;
                            $existe_contato->fk_cargo = $contato->fk_cargo;
                            $existe_contato->situacao = $contato->situacao;
                            $existe_contato->save();
                            $not_exclude_contato[] = $existe_contato->id;
                            unset($exclude_contato[$existe_contato->id]);
                        }

                        if ($qtd_telefones > 0) {
                            foreach ($telefones as $telefone) {
                                $existe_telefone = Telefone::findOne(['fk_contato_cliente' => $existe_contato->id, 'telefone' => Yii::$app->formatter->removeCharactersNonNumeric($telefone->telefone)]);

                                if (is_null($existe_telefone)) {
                                    if ($telefone->contato_index == $index) {
                                        $existe_telefone = $telefone;
                                        $existe_telefone->fk_contato_cliente = $existe_contato->id;
                                        $existe_telefone->save();
                                        $not_exclude_telefone[] = $existe_telefone->id;
                                    }
                                } else {
                                    $existe_telefone->fk_tipo_telefone = $telefone->fk_tipo_telefone;
                                    $existe_telefone->save();
                                    $not_exclude_telefone[] = $existe_telefone->id;
                                }
                            }
                            Telefone::deleteAll(['and', ['fk_contato_cliente' => $existe_contato->id], ['not in', 'id', $not_exclude_telefone]]);
                        }
                        $index++;
                        $index_foto++;
                    }
                }
                if (!empty($exclude_contato)) {
                    foreach ($exclude_contato as $excluir_contato) {
                        Telefone::deleteAll(['fk_contato_cliente' => $excluir_contato]);
                    }
                }
                ContatoCliente::deleteAll(['and', ['fk_cliente' => $model->id], ['not in', 'id', $not_exclude_contato]]);
            }
            return $this->redirect(['index']);
        }

        return $this->render('update', [
            'view' => null,
            'model' => $model,
            'modelContato' => $modelContato,
            'modelGestao' => $modelGestao,
            'modelTelefone' => $modelTelefone,
            'modelsAnexoDocumento' => (empty($modelsAnexoDocumento)) ? [new AnexosDocumentos] : $modelsAnexoDocumento,
            'contatos' => $contatos,
            'telefones' => $telefones,
            'gestoes' => $gestoes,
        ]);
    }

    /**
     * Deletes an existing Cliente model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @param integer $fk_representante
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionAdd($fk_entidade, $id = null)
    {
        Yii::$app->assetManager->bundles = [
            'yii\bootstrap\BootstrapPluginAsset' => false,
            'yii\bootstrap\BootstrapAsset' => false,
            'yii\web\JqueryAsset' => false,
        ];

        $modelCargo = is_null($id) ? new Cliente(['$fk_entidade' => $fk_entidade]) : Cliente::findOne(['$fk_entidade' => $fk_entidade, 'id' => $id]);
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
    }
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();
        return $this->redirect(['index']);
    }

    /**
     * Finds the Cliente model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @param integer $fk_representante
     * @return Cliente the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Cliente::find()->findClienteByEntidade()->andWhere([Cliente::tableName() . '.id' => $id])->one()) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionBuscaAjax($q = null, $id = null)
    {
        \Yii::$app->response->format = Response::FORMAT_JSON;
        $out = ['results' => ['id' => '', 'text' => '']];
        if (!is_null($q)) {
            $data = Cliente::find()->select([Cliente::tableName() . '.id', Cliente::tableName() . ".razao_social AS text"])->where(['like', Cliente::tableName() . '.razao_social', $q])->asArray()->all();
            $out['results'] = array_values($data);
        } elseif ($id > 0) {
            $cliente = Cliente::findOne([Cliente::tableName() . '.id' => $id]);
            $out['results'] = ['id' => $id, 'text' => $cliente->razao_social];
        }
        return $out;
    }
}