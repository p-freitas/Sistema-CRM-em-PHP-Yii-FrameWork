<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Bloqueio;

/**
 * BloqueioSearch represents the model behind the search form of `app\models\Bloqueio`.
 */
class BloqueioSearch extends Bloqueio
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'fk_cliente', 'fk_contrato', 'fk_usuario', 'status'], 'integer'],
            [['data_bloqueio', 'data_limite'], 'safe'],
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
        $query = Bloqueio::find();

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
            'fk_contrato' => $this->fk_contrato,
            'fk_usuario' => $this->fk_usuario,
            'data_bloqueio' => $this->data_bloqueio,
            'data_limite' => $this->data_limite,
            'status' => $this->status,
        ]);

        return $dataProvider;
    }
}
