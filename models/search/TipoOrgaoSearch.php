<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\TipoOrgao;
use app\models\Entidade;

/**
 * TipoOrgaoSearch represents the model behind the search form of `app\models\TipoOrgao`.
 */
class TipoOrgaoSearch extends TipoOrgao
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
        $query = TipoOrgao::find();

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

        $query->orFilterWhere(['like', 'descricao', $this->search])
              ->orFilterWhere(['like', 'sigla', $this->search]);

        return $dataProvider;
    }
}
