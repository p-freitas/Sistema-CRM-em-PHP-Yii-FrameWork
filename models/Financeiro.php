<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;

/**
 * This is the model class for table "financeiro".
 *
 * @property int $id
 * @property int $fk_nota_fiscal
 * @property int $fk_cliente
 * @property int $fk_conta
 * @property int $fk_tipo_documento
 * @property int $fk_banco_portador
 * @property int $fk_conta_orcamento
 * @property int $situacao
 * @property string $numero_titulo
 * @property string $data_emissao
 * @property string $tipo
 * @property string $data
 * @property string $vencimento
 * @property string $valor_titulo
 * @property string $valor_pgto
 * @property string $data_pgto
 * @property string $valor_desconto
 * @property string $data_dev
 * @property string $valor_dev
 * @property string $saldo
 * @property string $obs
 *
 * @property Banco $fkBancoPortador
 * @property Cliente $fkCliente
 * @property Conta $fkConta
 * @property ContaOrcamento $fkContaOrcamento
 * @property NotaFiscal $fkNotaFiscal
 * @property TipoDocumento $fkTipoDocumento
 */
class Financeiro extends \app\models\MainModel
{
    /**
     * {@inheritdoc}
     */
    public static $statusDesc = [
        1 => "Baixa parcial",
        0 => "Aberto",
        2 => "Liquidado"
    ];

    public static function tableName()
    {
        return 'financeiro';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['fk_nota_fiscal', 'fk_cliente', 'fk_conta', 'fk_tipo_documento', 'fk_banco_portador', 'fk_conta_orcamento'], 'integer'],
            [['fk_cliente', 'fk_tipo_documento', 'fk_banco_portador', 'fk_conta_orcamento', 'numero_titulo', 'data_emissao', 'vencimento', 'valor_titulo', 'valor_desconto'], 'required'],
            [['data_emissao', 'vencimento', 'data_pgto', 'data_dev', 'data'], 'safe'],
            [['valor_titulo', 'valor_pgto', 'valor_desconto', 'valor_dev', 'saldo'], 'number', 'numberPattern' => '/^\d+(.\d{1,2})?$/'],
            [['numero_titulo'], 'string', 'max' => 20],
            [['saldo'], 'default', 'value'=> function() {
                $saldo = $this->saldo;
                $valor_titulo = $this->valor_titulo;
                $valor_desconto = $this->valor_desconto;

                $valor_titulo = str_replace(',', '.', str_replace(".","",$valor_titulo));
                $valor_desconto = str_replace(',', '.', str_replace(".","",$valor_desconto));

                return $saldo = (floatval($valor_titulo) - floatval($valor_desconto));
                }],
            [['fk_nota_fiscal'], 'default', 'value' => 1],
            [['fk_conta'], 'default', 'value' => 1],
            [['data'], 'default', 'value' => date('d/m/Y H:i:s')],
            [['tipo'], 'string', 'max' => 1],
            [['tipo'], 'default', 'value' => 1, 'on' => 'ContaPagar'],
            [['tipo'], 'default', 'value' => 2, 'on' => 'ContaReceber'],
            [['obs'], 'string', 'max' => 255],
            [['situacao'], 'default', 'value' => 0],
            [['fk_banco_portador'], 'exist', 'skipOnError' => true, 'targetClass' => Banco::className(), 'targetAttribute' => ['fk_banco_portador' => 'id']],
            [['fk_cliente'], 'exist', 'skipOnError' => true, 'targetClass' => Cliente::className(), 'targetAttribute' => ['fk_cliente' => 'id']],
           // [['fk_conta'], 'exist', 'skipOnError' => true, 'targetClass' => Conta::className(), 'targetAttribute' => ['fk_conta' => 'id']],
            [['fk_conta_orcamento'], 'exist', 'skipOnError' => true, 'targetClass' => ContaOrcamento::className(), 'targetAttribute' => ['fk_conta_orcamento' => 'id']],
          //  [['fk_nota_fiscal'], 'exist', 'skipOnError' => true, 'targetClass' => NotaFiscal::className(), 'targetAttribute' => ['fk_nota_fiscal' => 'id']],
            [['fk_tipo_documento'], 'exist', 'skipOnError' => true, 'targetClass' => TipoDocumento::className(), 'targetAttribute' => ['fk_tipo_documento' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fk_nota_fiscal' => 'Fk Nota Fiscal',
            'fk_cliente' => 'Fk Cliente',
            'fk_conta' => 'Fk Conta',
            'fk_tipo_documento' => 'Fk Tipo Documento',
            'fk_banco_portador' => 'Fk Banco Portador',
            'fk_conta_orcamento' => 'Fk Conta Orcamento',
            'numero_titulo' => 'Numero Titulo',
            'data_emissao' => 'Data Emissao',
            'data' => 'Data',
            'tipo' => 'Tipo',
            'situacao' => 'Situação',
            'vencimento' => 'Vencimento',
            'valor_titulo' => 'Valor Titulo',
            'valor_pgto' => 'Valor Pgto',
            'data_pgto' => 'Data Pgto',
            'valor_desconto' => 'Valor Desconto',
            'data_dev' => 'Data Dev',
            'valor_dev' => 'Valor Dev',
            'saldo' => 'Saldo',
            'obs' => 'Obs',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkBancoPortador()
    {
        return $this->hasOne(Banco::className(), ['id' => 'fk_banco_portador']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkCliente()
    {
        return $this->hasOne(Cliente::className(), ['id' => 'fk_cliente']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkConta()
    {
        return $this->hasOne(Conta::className(), ['id' => 'fk_conta']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkContaOrcamento()
    {
        return $this->hasOne(ContaOrcamento::className(), ['id' => 'fk_conta_orcamento']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkNotaFiscal()
    {
        return $this->hasOne(NotaFiscal::className(), ['id' => 'fk_nota_fiscal']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkTipoDocumento()
    {
        return $this->hasOne(TipoDocumento::className(), ['id' => 'fk_tipo_documento']);
    }

    /**
     * {@inheritdoc}
     * @return \app\models\query\FinanceiroQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\FinanceiroQuery(get_called_class());
    }
}
