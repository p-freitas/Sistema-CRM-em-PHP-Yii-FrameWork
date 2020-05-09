<?php
/**
 * Created by PhpStorm.
 * User: wilton
 * Date: 21/08/17
 * Time: 09:26
 */

namespace app\models\search;


use app\models\Usuario;
use yii\base\Model;
use yii\data\ActiveDataProvider;

class UsuarioSearch extends Usuario
{
    public $search;

    public function rules()
    {
        return [
            [['search'], 'safe'],
        ];
    }

    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    public function search($params)
    {
        $query = Usuario::find();

        $query->with(['roles']);

        if ( !\Yii::$app->user->isSuperadmin )
        {
            $query->where(['superadmin'=>0]);
            $query->andFilterWhere(['fk_entidade' => \Yii::$app->user->entidade]);


        }

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'sort' => false,
            'pagination' => [
                'pageSize' => \Yii::$app->request->cookies->getValue('_grid_page_size', 20),
            ],
            'sort'=>[
                'defaultOrder'=>[
                    'id'=>SORT_DESC,
                ],
            ],
        ]);

        if (!($this->load($params) && $this->validate())) {
            return $dataProvider;
        }

        $query->innerJoinWith(['fkEntidade'], false);


        $query->orFilterWhere(['like', 'nome_fantasia', $this->search])
          ->orFilterWhere(['like', 'nome_completo', $this->search])
         ->orFilterWhere(['like', 'email', $this->search]);

        return $dataProvider;
    }
}