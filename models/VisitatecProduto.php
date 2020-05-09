<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "visitatec_produto".
 *
 * @property int $id
 * @property int $fk_visita
 * @property int $fk_produto
 *
 * @property Produto $fkProduto
 * @property VisitaTecnica $fkVisita
 */
class VisitatecProduto extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'visitatec_produto';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_visita', 'fk_produto'], 'required'],
            [['fk_visita', 'fk_produto'], 'integer'],
            [['fk_produto'], 'exist', 'skipOnError' => true, 'targetClass' => Produto::className(), 'targetAttribute' => ['fk_produto' => 'id']],
            [['fk_visita'], 'exist', 'skipOnError' => true, 'targetClass' => VisitaTecnica::className(), 'targetAttribute' => ['fk_visita' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_visita' => 'Fk Visita',
            'fk_produto' => 'Fk Produto',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkProduto()
    {
        return $this->hasOne(Produto::className(), ['id' => 'fk_produto']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkVisita()
    {
        return $this->hasOne(VisitaTecnica::className(), ['id' => 'fk_visita']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\VisitatecProdutoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\VisitatecProdutoQuery(get_called_class());
    }
}
