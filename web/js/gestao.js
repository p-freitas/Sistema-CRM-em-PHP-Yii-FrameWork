let index_gestao;
let table_gestao;

$(document).ready(function () {
    let tabela_gestao = $('#corpo-gestoes');
    table_gestao = tabela_gestao.parents('table').DataTable();
    index_gestao = table_gestao.rows().count();
    deleteGestao();
    modalGestaoEdit();

    $('#add-gestao-btn').click(function () {
        limpaGestao();

        $('#gestao-modal').modal('show');

        $('#save-gestao-btn').off('click').on('click', function () {

            let from = $('#gestao-from').val();
            let to = $('#gestao-to').val();
            let prefeito = $('#gestao-prefeito').val();
            let data_nascimento = $('#gestao-data_nascimento').val();
            let vice_prefeito = $('#gestao-vice_prefeito').val();

            if(from !== '' && to !== '' && prefeito !== '' && vice_prefeito !== ''){

                table_gestao.row.add($(
                    "<tr data-index-gestao='"+index_gestao+"' data-gestao='"+prefeito+"'>" +

                    "<td><input type='hidden' name='Gestao["+index_gestao+"][periodo]' value='"+from+" à " +to+"'>"+from+" à "+to+"" +
                        "<input type='hidden' name='Gestao["+index_gestao+"][id_edit_gestao]' value='' id='id_edit_gestao'>" +"</td>" +
                    "<td><input type='hidden' name='Gestao["+index_gestao+"][prefeito]' value='"+prefeito+"'>" + prefeito + "</td>" +
                    "<td><input type='hidden' name='Gestao["+index_gestao+"][data_nascimento]' value='"+data_nascimento+"'>" + data_nascimento + "</td>" +
                    "<td><input type='hidden' name='Gestao["+index_gestao+"][vice_prefeito]' value='"+vice_prefeito+"'>" + vice_prefeito + "</td>" +

                    "<td class='text-center'><button type='button' class='btn btn-rounded btn-sm btn-primary edit-gestao'><i class='fa fa-pencil'></i></button><button type='button' class='btn btn-sm btn-rounded btn-danger delete-gestao'><i class='fa fa-trash'></i></button></td>" +

                    "</tr>"
                )[0]).draw(false);

                modalGestaoEdit();
                deleteGestao();
                limpaGestao();
                $('#gestao-modal').modal('hide');

                $.toast({
                    heading: "Adicionado com sucesso",
                    text: "Clique em salvar para gravar as alterações",
                    position: "top-right",
                    loaderBg: "#ff6849",
                    icon: "success",
                    hideAfter: 4000,
                });

                index_gestao++;


            }else{
                $.toast({
                    heading: "Atenção",
                    text: "É necessário preencher os campos para adicionar.",
                    position: "top-right",
                    loaderBg: '#ff6849',
                    icon: 'error',
                    hideAfter: 5000,
                });
            }
        })
    });     
});


function limpaGestao(){
    $('#gestao-from').val('');
    $('#gestao-to').val('');
    $('#gestao-prefeito').val('');
    $('#gestao-data_nascimento').val('');
    $('#gestao-vice_prefeito').val('');

}

function deleteGestao(){
    $('.delete-gestao').off('click').on('click', function () {
       swalParamGestao($(this).parents('tr').data('index-gestao'));
    })
}

function swalParamGestao(gestao) {
    swal({
        title: "Excluir",
        text: "Você realmente deseja excluir esta gestão?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Sim, prosseguir",
        cancelButtonText: "Não, voltar",
    }).then(result => {
        if (result.value) {
            table_gestao.rows("[data-index-gestao='"+gestao+"']").remove().draw(false);
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

function modalGestaoEdit(){
    $('.edit-gestao').off('click').on('click', function () {
        let index_gestao = $(this).parents('tr').data('index');
        let button_gestao = this;
        let id_edit_gestao = $($(this).parents('tr').find('td')[0]).find('#id_edit_gestao').val();

        let from = $($(this).parents('tr').find('td')[0]).find('input').val().split("à")[0];
        let to = $($(this).parents('tr').find('td')[0]).find('input').val().split("à")[1];

        $('#gestao-modal').modal('show');
        $('#gestao-from').val(from);
        $('#gestao-to').val(to);
        $('#gestao-prefeito').val($($(this).parents('tr').find('td')[1]).find('input').val());
        $('#gestao-data_nascimento').val($($(this).parents('tr').find('td')[2]).find('input').val());
        $('#gestao-vice_prefeito').val($($(this).parents('tr').find('td')[3]).find('input').val());

        $('#save-gestao-btn').off('click').on('click', function () {
            atualizarGestao(button_gestao, id_edit_gestao);
        });

    })
}

function atualizarGestao(button_gestao, id_edit_gestao){
    let index_gestao = $(button_gestao).parents('tr').data('index-gestao');
    let tr = $('#corpo-gestoes').find('tr[data-index-gestao="' + index_gestao + '"]');

    let td_periodo = $(tr.find('td')[0]);
    td_periodo.empty();

    let td_prefeito = $(tr.find('td')[1]);
    td_prefeito.empty();

    let td_data_nascimento = $(tr.find('td')[2]);
    td_data_nascimento.empty();

    let td_vice_prefeito = $(tr.find('td')[3]);
    td_vice_prefeito.empty();

    let periodo_edit = $('#gestao-from').val() + ' à ' + $('#gestao-to').val();
    let prefeito_edit = $('#gestao-prefeito').val();
    let data_nascimento_edit = $('#gestao-data_nascimento').val();
    let vice_prefeito_edit = $('#gestao-vice_prefeito').val();

    td_periodo.append("<input type='hidden' id='Gestao["+index_gestao+"][periodo]' name='Gestao["+index_gestao+"][periodo]' value='"+periodo_edit+"'>"+periodo_edit);
    td_prefeito.append("<input type='hidden' id='Gestao["+index_gestao+"][prefeito]' name='Gestao["+index_gestao+"][prefeito]' value='"+prefeito_edit+"'>" +
        "<input type='hidden' id='id_edit_gestao' name='Gestao["+id_edit_gestao+"][id_edit_gestao]' value='"+id_edit_gestao+"'>" +prefeito_edit);
    td_data_nascimento.append("<input type='hidden' id='Gestao["+index_gestao+"][data_nascimento]' name='Gestao["+index_gestao+"][data_nascimento]' value='"+data_nascimento_edit+"'>"+data_nascimento_edit);
    td_vice_prefeito.append("<input type='hidden' id='Gestao["+index_gestao+"][vice_prefeito]' name='Gestao["+index_gestao+"][vice_prefeito]' value='"+vice_prefeito_edit+"'>"+vice_prefeito_edit);

    $('#gestao-modal').modal('hide');
}