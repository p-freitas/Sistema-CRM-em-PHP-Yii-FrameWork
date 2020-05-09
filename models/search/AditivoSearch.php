<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Aditivo;
use app\models\Contrato;

/**
 * AditivoSearch represents the model behind the search form of `app\models\Aditivo`.
 */
class AditivoSearch extends Aditivo
{
    /**
     * {@inheritdoc}
     */
    public $contrato;

    public function rules()
    {
        return [
            [['id', 'fk_contrato'], 'integer'],
            [['numero', 'data_inicio', 'data_termino', 'justificativa', 'anexo'], 'safe'],
            [['valor'], 'number'],
            [['contrato'], 'string'],
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
        $query = Aditivo::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $dataProvider->sort->attributes['contrato'] = [
            'asc' => [ Contrato::tableName().'.numero' => SORT_ASC],
            'desc' => [ Contrato::tableName().'.numero' => SORT_DESC],
        ];

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'fk_contrato' => $this->fk_contrato,
            'data_inicio' => $this->data_inicio,
            'data_termino' => $this->data_termino,
            'valor' => $this->valor,
        ]);

        $query->andFilterWhere(['like', 'numero', $this->numero])
            ->andFilterWhere(['like', 'justificativa', $this->justificativa])
            ->andFilterWhere(['like', 'anexo', $this->anexo])
            ->andFilterWhere(['like', Contrato::tableName().'.numero', $this->contrato])
            ->innerJoin(Contrato::tableName(), Contrato::tableName().'.id='.Aditivo::tableName().'.fk_contrato');

        return $dataProvider;
    }
}
