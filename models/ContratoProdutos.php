<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "contrato_produtos".
 *
 * @property int $id
 * @property int $fk_contrato
 * @property int $fk_produto
 *
 * @property Contrato $fkContrato
 * @property Produto $fkProduto
 * @property Produto[] $modelProduto
 */
class ContratoProdutos extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'contrato_produtos';
    }

    /**
     * {@inheritdoc}
     */

    public function rules()
    {
        return [
            [['fk_contrato', 'fk_produto'], 'required'],
            [['fk_contrato', 'fk_produto'], 'integer'],
            [['fk_contrato'], 'exist', 'skipOnError' => true, 'targetClass' => Contrato::className(), 'targetAttribute' => ['fk_contrato' => 'id']],
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
            'fk_contrato' => 'Fk Contrato',
            'fk_produto' => 'Fk Produto',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkContrato()
    {
        return $this->hasOne(Contrato::className(), ['id' => 'fk_contrato']);
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
     * @return \app\models\query\ContratoProdutosQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\ContratoProdutosQuery(get_called_class());
    }
}
