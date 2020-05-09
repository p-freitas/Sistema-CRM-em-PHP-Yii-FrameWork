<?php

namespace app\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\AnexosDocumentos;

/**
 * AnexosDocumentosSearch represents the model behind the search form of `app\models\AnexosDocumentos`.
 */
class AnexosDocumentosSearch extends AnexosDocumentos
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'fk_tipo_documento', 'fk_cliente'], 'integer'],
            [['anexo'], 'safe'],
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
        $query = AnexosDocumentos::find();

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
            'fk_tipo_documento' => $this->fk_tipo_documento,
            'fk_cliente' => $this->fk_cliente,
        ]);

        $query->andFilterWhere(['like', 'anexo', $this->anexo]);

        return $dataProvider;
    }
}
