<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "controle_versao".
 *
 * @property int $id
 * @property int $fk_produto
 * @property int $fk_usuario
 * @property string $data_hora
 * @property string $numero_versao
 * @property string $descricao
 * @property string $script
 *
 * @property Produto $fkProduto
 * @property User $fkUsuario
 */
class ControleVersao extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'controle_versao';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_produto', 'fk_usuario', 'data_hora', 'numero_versao', 'descricao'], 'required'],
            [['fk_produto', 'fk_usuario'], 'integer'],
            [['data_hora'], 'safe'],
            [['descricao', 'script'], 'string'],
            [['numero_versao'], 'string', 'max' => 20],
            [['fk_produto'], 'exist', 'skipOnError' => true, 'targetClass' => Produto::className(), 'targetAttribute' => ['fk_produto' => 'id']],
            [['fk_usuario'], 'exist', 'skipOnError' => true, 'targetClass' => Usuario::className(), 'targetAttribute' => ['fk_usuario' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_produto' => 'Fk Produto',
            'fk_usuario' => 'Fk Usuario',
            'data_hora' => 'Data Hora',
            'numero_versao' => 'Numero Versao',
            'descricao' => 'Descricao',
            'script' => 'Script',
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
    public function getFkUsuario()
    {
        return $this->hasOne(Usuario::className(), ['id' => 'fk_usuario']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\ControleVersaoQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\ControleVersaoQuery(get_called_class());
    }
}
