<?php

namespace app\models\search;

use app\models\TipoOrgao;
use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\TipoCliente;
use app\models\Entidade;

/**
 * TipoClienteSearch represents the model behind the search form of `app\models\TipoCliente`.
 */
class TipoClienteSearch extends TipoCliente
{
    public $search;
    /**
     * {@inheritdoc}
     */

    public $entidade;

    public function rules()
    {
        return [
            [['search'], 'safe'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = TipoCliente::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'sort' => false
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        $query->innerJoinWith(['fkEntidade'], false);

        $query->orFilterWhere(['like', 'descricao', $this->search])
              ->orFilterWhere(['like', 'codigo', $this->search]);

        return $dataProvider;
    }
}
