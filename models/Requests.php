<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "requests".
 *
 * @property integer $id
 * @property string $nome_arquivo
 * @property string $ip
 * @property string $data_ini_req
 * @property string $data_fim_req
 * @property integer $status
 * @property string $mensagem
 */
class Requests extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'requests';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['nome_arquivo', 'ip', 'data_ini_req', 'data_fim_req', 'status', 'mensagem'], 'required'],
            [['data_ini_req', 'data_fim_req'], 'safe'],
            [['status'], 'integer'],
            [['mensagem'], 'string'],
            [['nome_arquivo'], 'string', 'max' => 255],
            [['ip'], 'string', 'max' => 15],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'nome_arquivo' => 'Nome do arquivo',
            'ip' => 'IP de origem',
            'data_ini_req' => 'Data Início',
            'data_fim_req' => 'Data Final',
            'status' => 'Status',
            'mensagem' => 'Mensagem',
        ];
    }
}
