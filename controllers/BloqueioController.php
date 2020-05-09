<?php

namespace app\controllers;

use app\models\ContratoProdutos;
use Yii;
use app\models\Bloqueio;
use app\models\BloqueioProduto;
use yii\base\Model;
use app\models\search\BloqueioSearch;
use app\controllers\MainController;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\Json;
use yii\web\Response;
/**
 * BloqueioController implements the CRUD actions for Bloqueio model.
 */
class BloqueioController extends MainController
{


    /**
     * Lists all Bloqueio models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new BloqueioSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Bloqueio model.
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
     * Creates a new Bloqueio model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Bloqueio();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

    /**
     * Updates an existing Bloqueio model.
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
     * Deletes an existing Bloqueio model.
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
     * Finds the Bloqueio model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Bloqueio the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Bloqueio::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionCreateModal(){
        $model = new Bloqueio();
        $modelBloqueioProduto = new BloqueioProduto();

        if ($model->load(Yii::$app->request->post()) && $model->validate() ) {
            $qtd_produtos = count(Yii::$app->request->post('BloqueioProduto', []));

            //condições para nao cadastrar
            $existe_bloqueios = Bloqueio::find()->where([Bloqueio::tableName().'.fk_cliente' => $model->fk_cliente, Bloqueio::tableName().'.status' => 1])->all();
            if(!is_null($existe_bloqueios)){
                foreach($existe_bloqueios as $existe_bloqueio){
                    //se existir um bloqueio naquele cliente com contrato null
                    if(is_null($existe_bloqueio->fk_contrato) && is_null($model->fk_contrato) ){
                        return Json::encode(['status' => 500, 'text' => 'Bloqueio já cadastrado.', 'content' => $this->renderAjax('_form_modal', [
                            'model' => $model,
                            'modelBloqueioProduto' => $modelBloqueioProduto,
                        ]) ]);
                    }
                    //se existir um bloqueio em um contrato, nao pode repetir os produtos
                    $existe_produtos = $existe_bloqueio->bloqueioProdutos;
                    if(!is_null($existe_produtos)){
                        if($qtd_produtos > 1){
                            $produtos = [new BloqueioProduto()];
                            for($p = 0; $p < $qtd_produtos; $p++){
                                $produtos[] = new BloqueioProduto();
                            }
                            Model::loadMultiple($produtos, Yii::$app->request->post());
                            foreach($existe_produtos as $existe_produto){
                                if(!is_null($produtos)){
                                    foreach($produtos as $produto){
                                        if(!is_null($produto->fk_produto)){
                                            if($existe_produto->fk_produto == $produto->fk_produto){
                                                return Json::encode(['status' => 500, 'text' => 'Bloqueio e produto já cadastrados.', 'content' => $this->renderAjax('_form_modal', [
                                                    'model' => $model,
                                                    'modelBloqueioProduto' => $modelBloqueioProduto,
                                                ])]);
                                            }
                                        }
                                    }
                                }
                            }

                        }else{
                            $produtos = null;
                            if($existe_bloqueio->fk_contrato == $model->fk_contrato){
                                return Json::encode(['status' => 500, 'text' => 'Bloqueio e produtos já cadastrado.', 'content' => $this->renderAjax('_form_modal', [
                                    'model' => $model,
                                    'modelBloqueioProduto' => $modelBloqueioProduto,
                                ]) ]);
                            }
                        }
                    }
                }
            }

            $model->save(false);
            if($qtd_produtos > 1){
                $produtos = [new BloqueioProduto()];
                for($g = 0; $g < $qtd_produtos; $g++){
                    $produtos[] = new BloqueioProduto();
                }
                Model::loadMultiple($produtos, Yii::$app->request->post());

                foreach($produtos as $produto){
                    if(!is_null($produto->fk_produto)){
                        $produto->fk_bloqueio = $model->id;
                        $produto->save();
                    }
                }
                //se o usuário não enviar nenhum produto pelo form, quer dizer que serão adicionados todos os produtos que aquele contrato contem( caso ele tb envie o contrato pelo form )
            }else{
                $produtos = ContratoProdutos::find()->where([ContratoProdutos::tableName().'.fk_contrato' => $model->fk_contrato])->all();
                if(!is_null($produtos)){
                    foreach($produtos as $produto){
                        $new_bloqueio_produto = new BloqueioProduto();
                        $new_bloqueio_produto->fk_produto = $produto->fk_produto;
                        $new_bloqueio_produto->fk_bloqueio = $model->id;
                        $new_bloqueio_produto->save();
                    }
                }
            }

            return $this->redirect(['/cliente/index-card']);
        }else{
            return Json::encode(['status' => 500, 'content' => $this->renderAjax('_form_modal', [
                'model' => $model,
                'modelBloqueioProduto' => $modelBloqueioProduto,
            ])]);
        }
    }

    public function actionGetBloqueiosCliente($id){

        $bloqueios = Bloqueio::find()->where([Bloqueio::tableName() . '.fk_cliente' => $id, Bloqueio::tableName().'.status' => 1])->all();
        $out = array();

        foreach ($bloqueios as $bloqueio) {
            $produtos = BloqueioProduto::find()->where([BloqueioProduto::tableName().'.fk_bloqueio' => $bloqueio->id])->all();
            $produtos_lista = array();
            if(!is_null($produtos)){
                foreach($produtos as $produto){
                    $produtos_lista[] = array('id' => $produto->fk_produto, 'descricao' => $produto->fkProduto->descricao);
                }
            }else{
                $produtos_lista[] = array('id' => '', 'descricao' => '');
            }
            $out[] = array('id' => $bloqueio->id,
                'contrato' => is_null($bloqueio->fk_contrato) ? '' : $bloqueio->fkContrato->numero,
                'contrato_id' => is_null($bloqueio->fk_contrato) ? '' : $bloqueio->fk_contrato,
                'usuario' => is_null($bloqueio->fk_usuario) ? '' : $bloqueio->fkUsuario->nome_completo,
                'usuario_id' =>  is_null($bloqueio->fk_usuario) ? '' : $bloqueio->fk_usuario,
                'data_bloqueio' => $bloqueio->data_bloqueio,
                'data_limite' =>  is_null($bloqueio->data_limite) ? '' : $bloqueio->data_limite,
                'produtos' => $produtos_lista);
        }

        return Json::encode(['output'=>$out, 'selected'=> $id]);

    }

    public function actionDeleteBloqueio(){

        $cliente_id = Yii::$app->request->post('cliente');
        $qtd_bloqueios = count(Yii::$app->request->post('Bloqueio', []));

        if($qtd_bloqueios > 0){
            $bloqueios = [new Bloqueio()];
            for($b = 0; $b < $qtd_bloqueios; $b++){
                $bloqueios[] = new Bloqueio();
            }
            Model::loadMultiple($bloqueios, Yii::$app->request->post());
            $not_desbloqueio = array();

            foreach($bloqueios as $bloqueio){
                if(!is_null($bloqueio->data_bloqueio)){
                    $not_desbloqueio[] = $bloqueio->bloqueio_id;
                }
            }
            $desbloqueios = Bloqueio::find()->where([Bloqueio::tableName().'.fk_cliente' => $cliente_id])->andWhere(['not in', Bloqueio::tableName().'.id', $not_desbloqueio])->all();
            if(!is_null($desbloqueios)){
                foreach($desbloqueios as $desbloqueio){
                    $desbloqueio->status = 0;
                    $desbloqueio->save();
                }
            }
        }else{
            $desbloqueios = Bloqueio::find()->where([Bloqueio::tableName().'.fk_cliente' => $cliente_id, Bloqueio::tableName().'.status' => 1])->all();
            if(!is_null($desbloqueios)){
                foreach($desbloqueios as $desbloqueio){
                    $desbloqueio->status = 0;
                    $desbloqueio->save();
                }
            }
        }
        return $this->redirect(['/cliente/index-card']);
    }
}
