<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\ContatoCliente;

/**
 * ContatoClienteSearch represents the model behind the search form of `app\models\ContatoCliente`.
 */
class ContatoClienteSearch extends ContatoCliente
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'fk_cliente', 'fk_departamento', 'fk_cargo'], 'integer'],
            [['nome', 'email', 'foto'], 'safe'],
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
        $query = ContatoCliente::find();

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
            'fk_departamento' => $this->fk_departamento,
            'fk_cargo' => $this->fk_cargo,
        ]);

        $query->andFilterWhere(['like', 'nome', $this->nome])
            ->andFilterWhere(['like', 'email', $this->email])
            ->andFilterWhere(['like', 'foto', $this->foto]);

        $dataProvider->setSort([
            'attributes' => [
                'situacao',
                'nome',
            ],
            'defaultOrder' => [
                'situacao' => SORT_ASC,
                'nome' => SORT_DESC,

            ]
        ]);

        return $dataProvider;
    }
}
