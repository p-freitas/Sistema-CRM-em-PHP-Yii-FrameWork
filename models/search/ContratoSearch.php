<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Contrato;
use app\models\Cliente;
use app\models\Modalidade;

/**
 * ContratoSearch represents the model behind the search form of `app\models\Contrato`.
 */
class ContratoSearch extends Contrato
{
    public $search;
    /**
     * {@inheritdoc}
     */

    public $cliente;
    public $modalidade;

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
        $query = Contrato::find();

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
        $query->innerJoinWith(['fkModalidade'], false);

        $query->orFilterWhere(['like', 'nome_fantasia', $this->search])
          ->orFilterWhere(['like', 'descricao', $this->search])
          ->orFilterWhere(['like', "date_format(data_inicio,'%d/%m/%Y %h:%i')", $this->search])
          ->orFilterWhere(['like', "date_format(data_termino,'%d/%m/%Y %h:%i')", $this->search]);

        return $dataProvider;
    }
}
