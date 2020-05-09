<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "bloqueio_produto".
 *
 * @property int $id
 * @property int $fk_bloqueio
 * @property int $fk_produto
 *
 * @property Bloqueio $fkBloqueio
 * @property Produto $fkProduto
 */
class BloqueioProduto extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'bloqueio_produto';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_bloqueio'], 'required'],
            [['fk_bloqueio', 'fk_produto'], 'integer'],
            [['fk_bloqueio'], 'exist', 'skipOnError' => true, 'targetClass' => Bloqueio::className(), 'targetAttribute' => ['fk_bloqueio' => 'id']],
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
            'fk_bloqueio' => 'Bloqueio',
            'fk_produto' => 'Produto',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkBloqueio()
    {
        return $this->hasOne(Bloqueio::className(), ['id' => 'fk_bloqueio']);
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
     * @return \app\models\query\BloqueioProdutoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\BloqueioProdutoQuery(get_called_class());
    }
}
