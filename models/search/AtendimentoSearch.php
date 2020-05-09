<?php

namespace app\models\search;

use phpDocumentor\Reflection\Types\This;
use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Atendimento;
use yii\helpers\Html;

/**
 * AtendimentoSearch represents the model behind the search form of `app\models\Atendimento`.
 */
class AtendimentoSearch extends Atendimento{
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
    /*public function validaData($dat){
        $this->search = explode('/', '$dat');
        $d = $this->search[0];
        $m = $this->search[1];
        $a = $this->search[2];



        $res = checkdate($m, $d, $a);
        if ($res = 1){
            return $this->search;
        }else
            echo 'data errada';

    }*/

    public function search($params)
    {
        $query = Atendimento::find();

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

        $query->innerJoinWith(['fkCliente'], false);
        $query->innerJoinWith(['fkTipoAtendimento'], false);
        $query->innerJoinWith(['fkContatoCliente'], false);

        $query->orFilterWhere(['like', 'nome_fantasia', $this->search])
              ->orFilterWhere(['like', 'nome', $this->search])
              ->orFilterWhere(['like', "date_format(data_atendimento,'%d/%m/%Y %h:%i')", $this->search]);

        $dataProvider->setSort([
            'attributes' => [
                'data_atendimento',
                'status',
            ],
            'defaultOrder' => [
                'status' => SORT_ASC,
                'data_atendimento' => SORT_DESC,

            ]
        ]);

        return $dataProvider;
    }
}
?>
