<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\entidade;

/**
 * EntidadeSearch represents the model behind the search form of `app\models\entidade`.
 */
class EntidadeSearch extends entidade
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id'], 'integer'],
            [['cnpj', 'razao_social', 'nome_fantasia', 'insc_municipal', 'logo_marca', 'cep', 'estado', 'cidade', 'bairro', 'endereco', 'complemento'], 'safe'],
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
        $query = entidade::find();

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
        ]);

        $query->andFilterWhere(['like', 'cnpj', $this->cnpj])
            ->andFilterWhere(['like', 'razao_social', $this->razao_social])
            ->andFilterWhere(['like', 'nome_fantasia', $this->nome_fantasia])
            ->andFilterWhere(['like', 'insc_municipal', $this->insc_municipal])
            ->andFilterWhere(['like', 'logo_marca', $this->logo_marca])
            ->andFilterWhere(['like', 'cep', $this->cep])
            ->andFilterWhere(['like', 'estado', $this->estado])
            ->andFilterWhere(['like', 'cidade', $this->cidade])
            ->andFilterWhere(['like', 'bairro', $this->bairro])
            ->andFilterWhere(['like', 'endereco', $this->endereco])
            ->andFilterWhere(['like', 'complemento', $this->complemento]);

        return $dataProvider;
    }
}
