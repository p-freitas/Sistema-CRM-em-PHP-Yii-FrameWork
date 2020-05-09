let index_aditivo;
let table_aditivo;

$(document).ready(function () {
    let tabela_aditivo = $('#corpo-aditivos');
    table_aditivo = tabela_aditivo.parents('table').DataTable();
    index_aditivo = table_aditivo.rows().count();
    deleteAditivo();

    $('.edit-aditivo').off('click').on('click', function () {

        let index_aditivo = $(this).parents('tr').data('index');
        let button_aditivo = this;
        let id_edit_aditivo = $($(this).parents('tr').find('td')[0]).find('#id_edit_aditivo').val();

        $('#aditivo-modal').modal('show');
        $('#aditivo-numero').val($($(this).parents('tr').find('td')[0]).find('input').val());
        $('#aditivo-valor').val($($(this).parents('tr').find('td')[1]).find('input').val());
        $('#aditivo-data_inicio').val($($(this).parents('tr').find('td')[2]).find('input').val());
        $('#aditivo-data_termino').val($($(this).parents('tr').find('td')[3]).find('input').val());
        $('#aditivo-justificativa').val($($(this).parents('tr').find('td')[4]).find('input').val());

        $('#save-aditivo-btn').off('click').on('click', function () {
            if($('#aditivo-numero').val() !== '' && $('#aditivo-valor').val() !== '' && $('#aditivo-data_inicio').val() !== '' &&  $('#aditivo-data_termino').val() !== '' &&  $('#aditivo-justificativa').val() !== '' ){
                atualizarAditivo(button_aditivo, id_edit_aditivo);
            }else{
                $.toast({
                    heading: "Atenção",
                    text: "É necessário preencher todos os campos!",
                    position: "top-right",
                    loaderBg: '#ff6849',
                    icon: 'error',
                    hideAfter: 5000,
                });
            }

        });

    })

    function atualizarAditivo(button_aditivo, id_edit_aditivo){
        let index_aditivo = $(button_aditivo).parents('tr').data('index-aditivo');
        let tr = $('#corpo-aditivos').find('tr[data-index-aditivo="' + index_aditivo + '"]');

        let td_numero = $(tr.find('td')[0]);
        td_numero.empty();

        let td_valor = $(tr.find('td')[1]);
        td_valor.empty();

        let td_data_inicio = $(tr.find('td')[2]);
        td_data_inicio.empty();

        let td_data_termino = $(tr.find('td')[3]);
        td_data_termino.empty();

        let td_justificativa = $(tr.find('td')[4]);
        td_justificativa.empty();


        let numero_edit = $('#aditivo-numero').val();
        let valor_edit = $('#aditivo-valor').val();
        let data_inicio_edit = $('#aditivo-data_inicio').val();
        let data_termino_edit = $('#aditivo-data_termino').val();
        let justificativa_edit = $('#aditivo-justificativa').val();

        td_numero.append("<input type='hidden' id='Aditivo["+index_aditivo+"][numero]' name='Aditivo["+index_aditivo+"][numero]' value='"+numero_edit+"'>" +
                        "<input type='hidden' id='id_edit_aditivo' name='Aditivo["+index_aditivo+"][id_edit_aditivo]' value='"+id_edit_aditivo+"'>"+numero_edit);

        td_valor.append("<input type='hidden' id='Aditivo["+index_aditivo+"][valor]' name='Aditivo["+index_aditivo+"][valor]' value='"+valor_edit+"'>"+valor_edit);

        td_data_inicio.append("<input type='hidden' id='Aditivo["+index_aditivo+"][data_inicio]' name='Aditivo["+index_aditivo+"][data_inicio]' value='"+data_inicio_edit+"'>"+data_inicio_edit);

        td_data_termino.append("<input type='hidden' id='Aditivo["+index_aditivo+"][data_termino]' name='Aditivo["+index_aditivo+"][data_termino]' value='"+data_termino_edit+"'>"+data_termino_edit);

        td_justificativa.append("<input type='hidden' id='Aditivo["+index_aditivo+"][justificativa]' name='Aditivo["+index_aditivo+"][justificativa]' value='"+justificativa_edit+"'>"+justificativa_edit);

        $('#aditivo-modal').modal('hide');
    }


});




function limpaAditivo(){
    $('#aditivo-from').val('');
    $('#aditivo-to').val('');
    $('#aditivo-prefeito').val('');
    $('#aditivo-data_nascimento').val('');
    $('#aditivo-vice_prefeito').val('');

}

function deleteAditivo(){
    $('.delete-aditivo').off('click').on('click', function () {
        swalParamAditivo($(this).parents('tr').data('index-aditivo'));
    })
}

function swalParamAditivo(aditivo) {
    swal({
        title: "Excluir",
        text: "Você realmente deseja excluir este aditivo?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Sim, prosseguir",
        cancelButtonText: "Não, voltar",
    }).then(result => {
        if (result.value) {
            table_aditivo.rows("[data-index-aditivo='"+aditivo+"']").remove().draw(false);
            $.toast({
                heading: "Excluído com sucesso",
                text: "Clique em salvar para gravar as alterações",
                position: "top-right",
                loaderBg: "#ff6849",
                icon: "success",
                hideAfter: 2000,
            });
        }
    })
}

function file(div){
    $(div).parent().find('input').click();

}


