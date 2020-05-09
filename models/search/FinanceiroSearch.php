<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Financeiro;

/**
 * FinanceiroSearch represents the model behind the search form of `app\models\Financeiro`.
 */
class FinanceiroSearch extends Financeiro
{
    public $search;
    /**
     * {@inheritdoc}
     */
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
        $query = Financeiro::find();

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


        $query->andFilterWhere(['tipo' => $this->tipo]);


        $query->innerJoinWith(['fkNotaFiscal'], false);
        $query->innerJoinWith(['fkCliente'], false);
        $query->innerJoinWith(['fkConta'], false);

        $query->orFilterWhere(['like', 'numero_nota', $this->search])
            ->orFilterWhere(['like', 'nome_fantasia', $this->search])
            ->orFilterWhere(['like', 'descricao', $this->search])
            ->orFilterWhere(['like', "date_format(data_emissao,'%d/%m/%Y %h:%i')", $this->search]);

        return $dataProvider;
    }
}
