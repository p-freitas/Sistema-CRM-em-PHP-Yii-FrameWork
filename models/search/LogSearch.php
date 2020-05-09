<?php

namespace app\models\search;

use app\behaviors\DbFormatBehavior;
use app\behaviors\LogBehavior;
use app\models\Log;
use asinfotrack\yii2\audittrail\models\AuditTrailEntry;
use Yii;
use yii\base\Event;
use yii\base\Model;
use yii\data\ActiveDataProvider;

/**
 * LogSearch represents the model behind the search form about `app\models\Log`.
 */
class LogSearch extends Log
{
    public $fk_entidade;

    public function rules()
    {
        return [
            [['id', 'fk_entidade'], 'integer'],
            ['happened_at', 'date'],
            [['id', 'model_type', 'happened_at', 'foreign_pk', 'user_id', 'type', 'data', 'user_id'], 'safe'],
            [['type'], 'in', 'range' => LogBehavior::$AUDIT_TYPES],
        ];
    }

    /**
     * @inheritdoc
     */
    public function scenarios()
    {
        return Model::scenarios();
    }

    /**
     * Creates the data-provider for searching audit trails
     *
     * @param mixed $params the params as used by yiis search methods
     * @param \yii\db\ActiveRecord $subject the model to get the audit trail entries for
     * @return \yii\data\ActiveDataProvider
     */
    public function search($params)
    {
        //prepare data provider
        $query = Log::find();

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        //if no query data, return it
        if (!($this->load($params) && $this->validate())) {
            return $dataProvider;
        }

        //apply filtering
        $query->andFilterWhere([
            'id' => $this->id,
            'type' => $this->type,
            'fk_entidade' => $this->fk_entidade
        ]);

        $query
            ->andFilterWhere(['like', 'foreign_pk', $this->foreign_pk])
            ->andFilterWhere(['like', 'nome_completo', $this->user_id]);

        if (!empty($this->happened_at))
            $query->andFilterWhere([
                'between',
                'happened_at',
                strtotime(Yii::$app->formatter->asDateUS($this->happened_at) . ' 00:00:00'),
                strtotime(Yii::$app->formatter->asDateUS($this->happened_at) . ' 23:59:59')
            ]);

        $dataProvider->setSort([
            'attributes' => [
                'type',
                'happened_at',
            ],
            'defaultOrder' => [
                'happened_at' => SORT_DESC
            ]
        ]);

        return $dataProvider;
    }

}
