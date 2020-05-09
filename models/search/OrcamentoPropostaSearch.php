<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\OrcamentoProposta;

/**
 * OrcamentoPropostaSearch represents the model behind the search form of `app\models\OrcamentoProposta`.
 */
class OrcamentoPropostaSearch extends OrcamentoProposta
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
        $query = OrcamentoProposta::find();

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

        $query->innerJoinWith(['fkCliente'], false);
        $query->innerJoinWith(['fkContatoCliente'], false);

        $query->orFilterWhere(['like', 'nome_fantasia', $this->search])
            ->orFilterWhere(['like', 'nome', $this->search])
            ->orFilterWhere(['like', "date_format(data,'%d/%m/%Y %h:%i')", $this->search]);

        return $dataProvider;
    }
}
