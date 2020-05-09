<?php

namespace app\models\search;


use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Cliente;
use app\models\Entidade;
use app\models\TipoOrgao;

/**
 * ClienteSearch represents the model behind the search form of `app\models\Cliente`.
 */
class ClienteSearch extends Cliente
{
    public $search;
    /**
     * {@inheritdoc}
     */

    public $entidade;
    public $tipo_orgao;
    public $representante;

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
        $query = Cliente::find();

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

        $query->innerJoinWith(['fkTipoOrgao'], false);

        $query->orFilterWhere(['like', 'razao_social', $this->search])
            ->orFilterWhere(['like', 'cpf_cnpj', $this->search])
            ->orFilterWhere(['like', 'cidade', $this->search])
            ->orFilterWhere(['like', 'descricao', $this->search]);

        return $dataProvider;
    }
}
