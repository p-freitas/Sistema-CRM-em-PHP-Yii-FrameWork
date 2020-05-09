<?php
/**
 * Created by PhpStorm.
 * User: wilton
 * Date: 07/12/17
 * Time: 11:02
 */

namespace app\modules;


use miloschuman\highcharts\Highcharts;

class GraphHelper
{
    public static function parametrizaPizzaGraph($dados, $titulo, $id)
    {
        return Highcharts::widget([
            'htmlOptions' => ['id' => 'graph-' . $id],
            'scripts' => [
                'modules/exporting',
            ],
            'options' => [
                'lang' => [
                    'months' => ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
                    'shortMonths' => ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
                    'weekdays' => ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
                    'loading' => ['Atualizando o gráfico...aguarde'],
                    'contextButtonTitle' => 'Exportar gráfico',
                    'decimalPoint' => ',',
                    'thousandsSep' => '.',
                    'downloadJPEG' => 'Baixar imagem JPEG',
                    'downloadPDF' => 'Baixar arquivo PDF',
                    'downloadPNG' => 'Baixar imagem PNG',
                    'downloadSVG' => 'Baixar vetor SVG',
                    'printChart' => 'Imprimir gráfico',
                    'rangeSelectorFrom' => 'De',
                    'rangeSelectorTo' => 'Para',
                    'rangeSelectorZoom' => 'Zoom',
                    'resetZoom' => 'Limpar Zoom',
                ],
                'chart' => ['type' => 'pie', 'borderWidth' => 1],
                'title' => ['text' => $titulo],
                'legend' => [
                    'labelFormat' => '{name} ({percentage:.1f}%)',
                ],
                'credits' => ['enabled' => false],
                'plotOptions' => [
                    'pie' => [
                        'allowPointSelect' => true,
                        'cursor' => 'pointer',
                        'showInLegend' => true,
                    ],
                ],
                'tooltip' => [
                    'enabled' => false
                ],
                'series' => [[
                    'type' => 'pie',
                    'data' => $dados,
                ]],
            ]
        ]);
    }

    public static function formataArrayGraph($dados)
    {
        $saida = array(array(), array(), array(), array());

        foreach ($dados as $nome => $contagem) {
            $outros = 0;

            if (empty($nome))
                $nome = 'Não atribuído';

            foreach ($contagem as $dados) {
                if (intval($dados['status']) === 5 || intval($dados['status']) === 3 || intval($dados['status']) === 4) {
                    $outros += intval($dados['sum']);
                } else if (intval($dados['status']) === 0) {
                    $saida[0][] = ['name' => $nome, 'y' => intval($dados['sum'])];
                } else if (intval($dados['status']) === 1) {
                    $saida[1][] = ['name' => $nome, 'y' => intval($dados['sum'])];
                } else {
                    $saida[2][] = ['name' => $nome, 'y' => intval($dados['sum'])];
                }
            }
            $saida[3][] = ['name' => $nome, 'y' => $outros];
        }

        return $saida;
    }

    public static function formataDashBoardGraphs($dados)
    {
        $labels = array();
        $series = array();

        foreach ($dados as $nome => $dado) {
            $labels[] = $dado['name'];
            $series['data'][] = intval($dado['y']);
        }

        return ['categories' => $labels, 'series' => $series];
    }

    public static function formataDashBoardGraphsTrimestre($dados)
    {
        $dados1 = $dados[0];
        $dados2 = $dados[1];
        $dados3 = $dados[2];

        $series = array();

        foreach ($dados1 as $nome => $dado) {
            $series[$dado['name']] = ['name' => $dado['name'], 'data' => [intval($dado['y'])]];
        }

        foreach ($dados2 as $nome => $dado) {
            if (isset($series[$dado['name']])) {
                $series[$dado['name']]['data'][] = intval($dado['y']);
            } else {
                $series[$dado['name']] = ['name' => $dado['name'], 'data' => [0, intval($dado['y'])]];
            }
        }

        foreach ($dados3 as $nome => $dado) {
            if (isset($series[$dado['name']])) {
                $series[$dado['name']]['data'][] = intval($dado['y']);
            } else {
                $series[$dado['name']] = ['name' => $dado['name'], 'data' => [0, 0, intval($dado['y'])]];
            }
        }

        $saida = array();

        foreach ($series as $serie) {
            $saida[] = $serie;
        }

        return $saida;
    }

    public static function getCategoriesDashboardLine()
    {
        setlocale(LC_TIME, 'pt_BR', 'pt_BR.utf-8', 'pt_BR.utf-8', 'portuguese');
        date_default_timezone_set('America/Sao_Paulo');

        return [
            strftime('%h', strtotime('today -3 month')) . ' / ' . strftime('%h', strtotime('today -2 month')),
            strftime('%h', strtotime('today -2 month')) . ' / ' . strftime('%h', strtotime('today -1 month')),
            strftime('%h', strtotime('today -1 month')) . ' / ' . strftime('%h', strtotime('today')),
        ];
    }

    public static function getLangGraph()
    {
        return [
            'months' => ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
            'shortMonths' => ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
            'weekdays' => ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
            'loading' => ['Atualizando o gráfico...aguarde'],
            'contextButtonTitle' => 'Exportar gráfico',
            'decimalPoint' => ',',
            'thousandsSep' => '.',
            'downloadJPEG' => 'Baixar imagem JPEG',
            'downloadPDF' => 'Baixar arquivo PDF',
            'downloadPNG' => 'Baixar imagem PNG',
            'downloadSVG' => 'Baixar vetor SVG',
            'printChart' => 'Imprimir gráfico',
            'rangeSelectorFrom' => 'De',
            'rangeSelectorTo' => 'Para',
            'rangeSelectorZoom' => 'Zoom',
            'resetZoom' => 'Limpar Zoom',
        ];
    }
}