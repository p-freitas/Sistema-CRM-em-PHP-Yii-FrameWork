<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "itens_orcamento".
 *
 * @property int $id
 * @property int $fk_orcamento
 * @property int $fk_produto
 * @property int $quantidade
 * @property string $valor_unitario
 * @property string $valor_total
 *
 * @property OrcamentoProposta $fkOrcamento
 * @property Produto $fkProduto
 */
class ItensOrcamento extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'itens_orcamento';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_orcamento', 'fk_produto', 'quantidade', 'valor_unitario', 'valor_total'], 'required'],
            [['fk_orcamento', 'fk_produto', 'quantidade'], 'integer'],
            [['valor_unitario', 'valor_total'], 'number'],
            [['fk_orcamento'], 'exist', 'skipOnError' => true, 'targetClass' => OrcamentoProposta::className(), 'targetAttribute' => ['fk_orcamento' => 'id']],
            [['fk_produto'], 'exist', 'skipOnError' => true, 'targetClass' => Produto::className(), 'targetAttribute' => ['fk_produto' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_orcamento' => 'Fk Orcamento',
            'fk_produto' => 'Fk Produto',
            'quantidade' => 'Quantidade',
            'valor_unitario' => 'Valor Unitario',
            'valor_total' => 'Valor Total',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkOrcamento()
    {
        return $this->hasOne(OrcamentoProposta::className(), ['id' => 'fk_orcamento']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkProduto()
    {
        return $this->hasOne(Produto::className(), ['id' => 'fk_produto']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\ItensOrcamentoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\ItensOrcamentoQuery(get_called_class());
    }
}
