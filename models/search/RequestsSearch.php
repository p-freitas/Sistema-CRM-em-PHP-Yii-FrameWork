<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Requests;

/**
 * RequestsSearch represents the model behind the search form about `app\models\Requests`.
 */
class RequestsSearch extends Requests
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['id', 'status'], 'integer'],
            [['nome_arquivo', 'ip', 'data_ini_req', 'data_fim_req', 'mensagem'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
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
        $query = Requests::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'data_ini_req' => $this->data_ini_req,
            'data_fim_req' => $this->data_fim_req,
            'status' => $this->status,
        ]);

        $query->andFilterWhere(['like', 'nome_arquivo', $this->nome_arquivo])
            ->andFilterWhere(['like', 'ip', $this->ip])
            ->andFilterWhere(['like', 'mensagem', $this->mensagem]);

        $query->orderBy(['id' => SORT_DESC]);

        return $dataProvider;
    }
}
