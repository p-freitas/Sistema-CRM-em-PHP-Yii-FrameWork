<?php

namespace app\modules;

use Yii;
use kartik\mpdf\Pdf;

class PdfHelper
{
    public static function createPDF($PDFcontent, $titulo, $custom_css = null, $destination = null, $orientation = null)
    {
        $pdf = new Pdf([
            'mode' => PDF::MODE_UTF8,
            'orientation' => is_null($orientation) ? Pdf::ORIENT_PORTRAIT : Pdf::ORIENT_LANDSCAPE,
            'destination' => is_null($destination) ? Pdf::DEST_BROWSER : $destination,
            'content' => $PDFcontent,
            'cssFile' => '@vendor/kartik-v/yii2-mpdf/assets/kv-mpdf-bootstrap.css',
            'cssInline' => is_null($custom_css) ? '' :
                file_get_contents(Yii::getAlias('@webroot') . '/css/' . $custom_css),
            'methods' => [
                'SetHTMLHeader' => '<div class="text-right" style="font-size:10px">'.Yii::$app->getUser()->username.' - '.date('d/m/Y H:i:s').'</div>',
            ]
        ]);

        $pdf->api->SetProtection(array('print', 'modify', 'annot-forms', 'fill-forms', 'extract', 'assemble', 'print-highres'));
        $pdf->filename = $titulo . ".pdf";
        $pdf->render();
    }
}