<?php
/**
 * Created by PhpStorm.
 * User: luanaraujo
 * Date: 06/07/18
 * Time: 10:23
 */

namespace app\modules;

use Yii;
use Fpdf\Fpdf;


class FpdfHelper extends FPDF{

    public $entidade;
    public $brasao;
    public $header;
    public $tipo_orientacao;
    public $footer;
    public $data;

    function Cell( $w, $h = 0, $txt = '', $border = 0, $ln = 0, $align = '', $fill = false, $link = '' ) {
        $txt = utf8_decode($txt);
        // Output a cell
        $k = $this->k;
        if( $this->y + $h > $this->PageBreakTrigger && !$this->InHeader && !$this->InFooter && $this->AcceptPageBreak() ) {
            // Automatic page break
            $x = $this->x;
            $ws = $this->ws;
            if( $ws > 0 ) {
                $this->ws = 0;
                $this->_out( '0 Tw' );
            }
            $this->AddPage( $this->CurOrientation, $this->CurPageSize, $this->CurRotation );
            $this->x = $x;
            if( $ws > 0 ) {
                $this->ws = $ws;
                $this->_out( sprintf( '%.3F Tw', $ws * $k ) );
            }
        }
        if( $w == 0 )
            $w = $this->w - $this->rMargin - $this->x;
        $s = '';
        if( $fill || $border == 1 ) {
            if( $fill )
                $op = ( $border == 1 ) ? 'B' : 'f';
            else
                $op = 'S';
            $s = sprintf( '%.2F %.2F %.2F %.2F re %s ', $this->x * $k, ( $this->h - $this->y ) * $k, $w * $k, -$h * $k, $op );
        }
        if( is_string( $border ) ) {
            $x = $this->x;
            $y = $this->y;
            if( strpos( $border, 'L' ) !== false )
                $s .= sprintf( '%.2F %.2F m %.2F %.2F l S ', $x * $k, ( $this->h - $y ) * $k, $x * $k, ( $this->h - ( $y + $h ) ) * $k );
            if( strpos( $border, 'T' ) !== false )
                $s .= sprintf( '%.2F %.2F m %.2F %.2F l S ', $x * $k, ( $this->h - $y ) * $k, ( $x + $w ) * $k, ( $this->h - $y ) * $k );
            if( strpos( $border, 'R' ) !== false )
                $s .= sprintf( '%.2F %.2F m %.2F %.2F l S ', ( $x + $w ) * $k, ( $this->h - $y ) * $k, ( $x + $w ) * $k, ( $this->h - ( $y + $h ) ) * $k );
            if( strpos( $border, 'B' ) !== false )
                $s .= sprintf( '%.2F %.2F m %.2F %.2F l S ', $x * $k, ( $this->h - ( $y + $h ) ) * $k, ( $x + $w ) * $k, ( $this->h - ( $y + $h ) ) * $k );
        }
        if( $txt !== '' ) {
            if( !isset( $this->CurrentFont ) )
                $this->Error( 'No font has been set' );
            if( $align == 'R' )
                $dx = $w - $this->cMargin - $this->GetStringWidth( $txt );
            elseif( $align == 'C' )
                $dx = ( $w - $this->GetStringWidth( $txt ) ) / 2;
            else
                $dx = $this->cMargin;
            if( $this->ColorFlag )
                $s .= 'q ' . $this->TextColor . ' ';
            $s .= sprintf( 'BT %.2F %.2F Td (%s) Tj ET', ( $this->x + $dx ) * $k, ( $this->h - ( $this->y + .5 * $h + .3 * $this->FontSize ) ) * $k, $this->_escape( $txt ) );
            if( $this->underline )
                $s .= ' ' . $this->_dounderline( $this->x + $dx, $this->y + .5 * $h + .3 * $this->FontSize, $txt );
            if( $this->ColorFlag )
                $s .= ' Q';
            if( $link )
                $this->Link( $this->x + $dx, $this->y + .5 * $h - .5 * $this->FontSize, $this->GetStringWidth( $txt ), $this->FontSize, $link );
        }
        if( $s )
            $this->_out( $s );
        $this->lasth = $h;
        if( $ln > 0 ) {
            // Go to next line
            $this->y += $h;
            if( $ln == 1 )
                $this->x = $this->lMargin;
        } else
            $this->x += $w;
    }

    function entidade(){
        $this->entidade = \app\models\Entidade::findOne([\app\models\Entidade::tableName() . '.id' => Yii::$app->user->entidade]);
         if(is_null($this->entidade->brasao) || empty($this->entidade->brasao)){
             $this->brasao = null;
        }else{
             $this->brasao = \yii\helpers\Url::to('@web/img/', true).$this->entidade->brasao;
         }
    }

    function Header($titulo = null, $header = null, $tipo_orientacao = null, $data = null){
        if($this->page == 1){
            $this->entidade();

            $this->SetFont('Arial','',8);
            $this->Cell(1,1, $titulo, 0,0, 'L');


            if($tipo_orientacao == 'P'){
                $this->SetLeftMargin(200);
                $this->Cell(1,1, 'Gerado em: '.date('d/m/Y H:i'), 0,1, 'R');
                $this->SetLeftMargin(0);
                $this->Ln(3);

                $this->SetLeftMargin(200);
                $this->Cell(1,1, \Yii::$app->user->identity->username, 0, 1, 'R');
                $this->SetLeftMargin(0);

                $this->Ln(20);

                is_null($this->brasao) ? ' ' : $this->Image($this->brasao, 90,10,30, 20);
                $this->Ln();

                $this->SetFont('Arial', 'B', 10);
                $this->SetLeftMargin(95);
                $this->Cell(20,3, $this->entidade->nome, 0, 1,'C');

                $this->SetLeftMargin(95);
                $this->Ln();
                $this->Cell(20,3, $this->entidade->fkCidade->nome, 0, 0, 'C');

                $this->SetLeftMargin(95);
                $this->Ln();
                $this->Cell(20,3, $this->entidade->fkCidade->fkEstado->nome, 0, 1, 'C');

                $this->SetFont('Arial', '', 8);
                $this->SetLeftMargin(95);
                $this->Ln();
                $this->Cell(20,3, $this->entidade->endereco, 0, 0, 'C');

                $this->SetLeftMargin(95);
                $this->Ln(4);
                $this->Cell(20,3, 'CNPJ: '. Yii::$app->formatter->asCgc(\Yii::$app->formatter->removeCharactersNonNumeric($this->entidade->cnpj)), 0, 0, 'C');

                if(!empty($data[1]) && !empty($data[2])){
                    $this->SetLeftMargin(10);
                    $this->Ln(10);
                    $this->Cell(1,1, 'Período: '.$data[1].' à '. $data[2], 0,0, 'L');
                }

                $this->SetLeftMargin(0);
                $this->Ln(10);
            }else{
                $this->SetLeftMargin(286);
                $this->Cell(1,1, 'Gerado em: '.date('d/m/Y H:i'), 0,1, 'R');
                $this->SetLeftMargin(0);
                $this->Ln(3);

                $this->SetLeftMargin(286);
                $this->Cell(1,1, \Yii::$app->user->identity->username, 0, 1, 'R');
                $this->SetLeftMargin(0);

                $this->Ln(20);

                is_null($this->brasao) ? ' ' : $this->Image($this->brasao, 130,10,30, 20);
                $this->Ln();

                $this->SetFont('Arial', 'B', 10);
                $this->SetLeftMargin(135);
                $this->Cell(20,3, $this->entidade->nome, 0, 1, 'C');

                $this->SetLeftMargin(135);
                $this->Ln();
                $this->Cell(20,3, $this->entidade->fkCidade->nome, 0, 0, 'C');

                $this->SetLeftMargin(135);
                $this->Ln();
                $this->Cell(20,3, $this->entidade->fkCidade->fkEstado->nome, 0, 1, 'C');

                $this->SetFont('Arial', '', 8);
                $this->SetLeftMargin(135);
                $this->Ln();
                $this->Cell(20,3, $this->entidade->endereco, 0, 0, 'C');

                $this->SetLeftMargin(135);
                $this->Ln(4);
                $this->Cell(20,3, 'CNPJ: '. Yii::$app->formatter->asCgc(\Yii::$app->formatter->removeCharactersNonNumeric($this->entidade->cnpj)), 0, 0, 'C');

                if(!empty($data[1]) && !empty($data[2])){
                    $this->SetLeftMargin(10);
                    $this->Ln(10);
                    $this->Cell(1,1, 'Período: '.$data[1].' à '. $data[2], 0,0, 'L');
                }

                $this->SetLeftMargin(0);
                $this->Ln(10);
            }

        }

        $this->SetLeftMargin(11);
        $this->SetFont('Arial', 'B', 8);

        for($i = 0; $i < count($header); $i++){
            $this->Cell($header[$i][0], $header[$i][1], $header[$i][2], $header[$i][3], $header[$i][4], $header[$i][5]);
        }
        $this->Ln(7);
    }

    function Footer(){
        $this->SetY(-15);
        $this->SetFont('Arial', 'B', 8);
        $this->Cell($this->footer[0][0], $this->footer[0][1], 'www.keepinformatica.com.br' , $this->footer[0][3], $this->footer[0][4], $this->footer[0][5]);
        $this->Cell($this->footer[1][0], $this->footer[1][1],  $this->PageNo()." / {pages}", $this->footer[1][3], $this->footer[0][4], $this->footer[1][5]);
    }

    function AddPage( $orientation = '', $size = '', $rotation = 0, $titulo = null, $header = null, $tipo_orientacao = null, $footer = null, $data = null) {
        // Start a new page
        if( $this->state == 3 )
            $this->Error( 'The document is closed' );
        $family = $this->FontFamily;
        $style = $this->FontStyle . ( $this->underline ? 'U' : '' );
        $fontsize = $this->FontSizePt;
        $lw = $this->LineWidth;
        $dc = $this->DrawColor;
        $fc = $this->FillColor;
        $tc = $this->TextColor;
        $cf = $this->ColorFlag;

        if(is_null($this->footer) && !is_null($footer))
            $this->footer = $footer;
        if( $this->page > 0 ) {
            // Page footer
            $this->InFooter = true;
            $this->Footer($tipo_orientacao);
            $this->InFooter = false;
            // Close page
            $this->_endpage();
        }
        // Start new page
        $this->_beginpage( $orientation, $size, $rotation );
        // Set line cap style to square
        $this->_out( '2 J' );
        // Set line width
        $this->LineWidth = $lw;
        $this->_out( sprintf( '%.2F w', $lw * $this->k ) );
        // Set font
        if( $family )
            $this->SetFont( $family, $style, $fontsize );
        // Set colors
        $this->DrawColor = $dc;
        if( $dc != '0 G' )
            $this->_out( $dc );
        $this->FillColor = $fc;
        if( $fc != '0 g' )
            $this->_out( $fc );
        $this->TextColor = $tc;
        $this->ColorFlag = $cf;
        // Page header
        $this->InHeader = true;

        if(is_null($this->header) && !is_null($header))
            $this->header = $header;

        $this->Header($titulo, $this->header, $tipo_orientacao, $data);
        $this->InHeader = false;
        // Restore line width
        if( $this->LineWidth != $lw ) {
            $this->LineWidth = $lw;
            $this->_out( sprintf( '%.2F w', $lw * $this->k ) );
        }
        // Restore font
        if( $family )
            $this->SetFont( $family, $style, $fontsize );
        // Restore colors
        if( $this->DrawColor != $dc ) {
            $this->DrawColor = $dc;
            $this->_out( $dc );
        }
        if( $this->FillColor != $fc ) {
            $this->FillColor = $fc;
            $this->_out( $fc );
        }
        $this->TextColor = $tc;
        $this->ColorFlag = $cf;
    }
}
