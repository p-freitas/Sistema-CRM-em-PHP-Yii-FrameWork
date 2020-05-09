<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Gestao;

/**
 * GestaoSearch represents the model behind the search form of `app\models\Gestao`.
 */
class GestaoSearch extends Gestao
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'fk_cliente'], 'integer'],
            [['periodo', 'prefeito', 'data_nascimento', 'vice_prefeito'], 'safe'],
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
        $query = Gestao::find();

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
            'fk_cliente' => $this->fk_cliente,
            'data_nascimento' => $this->data_nascimento,
        ]);

        $query->andFilterWhere(['like', 'periodo', $this->periodo])
            ->andFilterWhere(['like', 'prefeito', $this->prefeito])
            ->andFilterWhere(['like', 'vice_prefeito', $this->vice_prefeito]);

        return $dataProvider;
    }
}
