let index;
let table;
let indexTelefone;
let url  = window.location.href;
let url_crm = url.split("/")[0]+"/"+url.split("/")[1]+"/"+url.split("/")[2]+"/"+url.split("/")[3]+"/"+"themes"+"/";

$(document).ready(function () {
    $.extend($.fn.dataTable.defaults, {
        dom: 'B<"datatable-scroll"t><"datatable-footer">',
        autoWidth: false,
        paging: false,
        searching: true,
        ordering: true,
        order: [[6, "asc"], [0, "asc"]],
        columnDefs: [
            { "orderable": false, "targets": [1, 2 ,3 ,4, 5, 7] }
        ],
        retrieve: true,
        language: {
            decimal: ",",
            "sEmptyTable": "Nenhum registro encontrado",
            "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
            "sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
            "sInfoFiltered": "(Filtrados de _MAX_ registros)",
            "sInfoPostFix": "",
            "sInfoThousands": ".",
            "sLengthMenu": "_MENU_ resultados por página",
            "sLoadingRecords": "Carregando...",
            "sProcessing": "Processando...",
            "sZeroRecords": "Nenhum registro encontrado",
            "sSearch": "Pesquisar",
            "oPaginate": {
                "sNext": "Próximo",
                "sPrevious": "Anterior",
                "sFirst": "Primeiro",
                "sLast": "Último"
            },
            "oAria": {
                "sSortAscending": ": Ordenar colunas de forma ascendente",
                "sSortDescending": ": Ordenar colunas de forma descendente"
            }
        },
        initComplete: function () {
            this.api().columns().every(function () {
                var that = this;
                $('input', this.header()).on('keyup change submit', function () {
                    if (that.search() !== this.value) {
                        that
                            .search(this.value)
                            .draw();


                    }
                });
            })
        }
    });

    let tabela = $('#corpo-contatos');
    table = tabela.parents('table').DataTable();
    index = table.rows().count();
    indexTelefone = $('#corpo-contatos tr td li').length;

    modalTelefone();
    modalContatoEdit();
    deleteClick();
    deletePhone();
    InativarContato();
    ReativarContato();

    $('#form-cliente').on('beforeSubmit', function (e) {
        if ($(this).find('has-error').length === 0) {
            if ($('#corpo-contatos tr').length === 0) {
                e.preventDefault();
                $.toast({
                    heading: "Atenção",
                    text: "Preencha os campos do formulário de Contato",
                    position: "top-right",
                    loaderBg: '#ff6849',
                    icon: 'error',
                    hideAfter: 2000,
                });
                return false;
            } else {
                $('#contatocliente-nome').attr('name', '');
                $('#contatocliente-email').attr('name', '');
            }
        }
    });



    $('#add-contato-btn').click(function () {
        limpaContato();
        limpaTelefone();

        $('#contato-modal').modal('show');


        $('#save-contato-btn').off('click').on('click', function () {

            let contato_nome = $('#contatocliente-nome').val();
            let contato_email = $('#contatocliente-email').val();
            let data_nascimento = $('#contatocliente-data_nascimento').val();
            let situacao_id = $('#contatocliente-situacao').find('option:selected').val();
            let situacao_descricao = $('#contatocliente-situacao').find('option:selected').text()
            let cargo_id = $('#contatocliente-fk_cargo').find('option:selected').val();
            let cargo_descricao = $('#contatocliente-fk_cargo').find('option:selected').text();
            let departamento_id = $('#contatocliente-fk_departamento').find('option:selected').val();
            let departamento_descricao = $('#contatocliente-fk_departamento').find('option:selected').text();

            if (contato_nome !== '' && cargo_id !== '' && departamento_id !== '' ) {
                let tbody = $('#corpo-contatos');
                let exist = tbody.find('tr[data-contato="' + contato_nome + '"]');

                if (exist.length === 0){
                    table.row.add($(
                        "<tr data-index='"+index+"' data-contato='"+contato_nome+"'>" +

                        "<td><span onclick='file(this)'><img src='"+url_crm+"eliteadmin/plugins/images/users/blank-user.jpg' alt='user-img' class='img-circle'></span>" + contato_nome +
                        "<input type='hidden' name='ContatoCliente["+index+"][nome]' value='"+contato_nome+"'>" +
                        "<input type='hidden' name='ContatoCliente["+index+"][id_edit]' value='' id='id_edit'>" +
                        "<input type='file' class='hide' name='ContatoCliente["+index+"][foto]' onchange='previewImage(this)'>" +
                        "<input type='hidden' id='foto' value='"+url_crm+"eliteadmin/plugins/images/users/blank-user.jpg'>" +

                        "</td>" +

                        "<td><input type='hidden' name='ContatoCliente["+index+"][email]' value='"+contato_email+"'>"+contato_email+"</td>" +

                        "<td><ul id='Telefone[" + index + "]'></ul>"+ "</td>" +

                        "<td><input type='hidden' name='ContatoCliente["+index+"][data_nascimento]' value='"+data_nascimento+"'>" + data_nascimento + "</td>" +

                        "<td><input type='hidden' name='ContatoCliente["+index+"][fk_cargo]' value='"+cargo_id+"'>" +
                        "<input type='hidden' id='cargo_descricao' name='ContatoCliente["+index+"][cargo]' value='"+cargo_descricao+"'>" +cargo_descricao+"</td>" +

                        "<td><input type='hidden' id='departamento_descricao' name='ContatoCliente["+index+"][departamento]' value='"+departamento_descricao+"'>" +
                        "<input type='hidden' name='ContatoCliente["+index+"][fk_departamento]' value='"+departamento_id+"'>" +departamento_descricao+"</td>" +

                        "<td><input type='hidden' name='ContatoCliente["+index+"][situacao]' value='"+situacao_id+"'>" +
                        "<input type='hidden' id='situacao_descricao' name='ContatoCliente["+index+"][situacao]' value='"+situacao_descricao+"'>" +'Ativo'+"</td>" +

                        "<td class='text-center'><button type='button' class='btn btn-rounded btn-sm btn-primary edit-item'><i class='fa fa-pencil'></i></button> <button type='button' class='btn btn-rounded btn-sm btn-success phone-item'><i class='fa fa-phone'></i></button> <button type='button' class='btn btn-sm btn-rounded btn-danger delete-item'><i class='fa fa-trash'></i></button></td> <button type='button' class='btn btn-sm btn-rounded btn-secondary inativar-item'><i class='fa fa-times'></i></button> <button type='button' class='btn btn-sm btn-rounded btn-success reativar-item'><i class='fa fa-check-circle'></i></button></td>" +

                        "</tr>"
                    )[0]).draw(false);

                    modalTelefone();
                    modalContatoEdit();
                    deleteClick();
                    limpaContato();
                    InativarContato();
                    ReativarContato();

                    $.toast({
                        heading: "Contato criado com sucesso!",
                        text: "Clique em salvar para gravar as alterações.",
                        position: "top-right",
                        loaderBg: "#ff6849",
                        icon: "success",
                        hideAfter: 4000,
                    });



                    index++;
                }else{
                    swal({
                        title: "Atenção",
                        text: "Este contato já está na lista.",
                        type: "warning",
                    })
                }
            } else {
                $.toast({
                    heading: "Atenção",
                    text: "É necessário preencher os campos obrigatórios para adicionar.",
                    position: "top-right",
                    loaderBg: '#ff6849',
                    icon: 'error',
                    hideAfter: 5000,
                });
            }



        });

    });
});

function previewImage(preImg){
    let ofReader = new FileReader();
    ofReader.readAsDataURL(preImg.files[0]);

    ofReader.onload = function (oFREvent){
        $(preImg).parent().find('img').attr('src', oFREvent.target.result);
        $(preImg).parent().find('#foto').val( oFREvent.target.result);
    };
};

function limpaContato() {
    $('#contatocliente-fk_cargo').val('').change();
    $('#contatocliente-fk_departamento').val('').change();
    $('#contatocliente-foto').val('').change();
    $('#contatocliente-nome').val('');
    $('#contatocliente-data_nascimento').val('');
    $('#contatocliente-email').val('');
    $('#contatocliente-situacao').val('');
}

function InativarContato() {
    $('.inativar-item').off('click').on('click', function () {
        let botao = this;
        Inativar(botao);
    })
}

function Inativar(botao) {
    swal({
        title: "Inativar",
        text: "Você realmente deseja inativar este contato?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Sim, prosseguir",
        cancelButtonText: "Não, voltar",
    }).then(result => {
        if (result.value) {
            var linha = $(botao).parents('tr');
            var coluna = $(linha.find('td')[6]);
            let ul = $($($(botao).parents('tr').find('td')[6]).find('ul'));
            let index = $(botao).parents('tr').data('index');

            let id_edit = $($(this).parents('tr').find('td')[0]).find('#id_edit').val();

            let situacao_valor = coluna.find('input').val('0').change();


            atualizarSituacao(botao, id_edit);

            $.toast({
                heading: "Contato inativado com sucesso!",
                text: "Clique em salvar para gravar as alterações.",
                position: "top-right",
                loaderBg: "#ff6849",
                icon: "success",
                hideAfter: 4000,
            });
        }
    })
}


function atualizarSituacao(botao, id_edit){
    let index = $(botao).parents('tr').data('index');
    let tr = $('#corpo-contatos').find('tr[data-index="' + index + '"]');

    let td_situacao = $(tr.find('td')[6]);
    td_situacao.empty();

    let situacao_id = $('#contatocliente-situacao').find('option:selected').val();
    let situacao_descricao = $('#contatocliente-situacao').find('option:selected').text();

    td_situacao.append(
        "<input type='hidden' name='ContatoCliente["+index+"][situacao]' value='0'>" +
        "<input type='hidden' id='situacao_descricao' name='ContatoCliente["+index+"][situacao]' value='Inativo'>" + 'Inativo');

}

function ReativarContato() {
    $('.reativar-item').off('click').on('click', function () {
        let botao = this;
        Reativar(botao);
    })
}

function Reativar(botao) {
    swal({
        title: "Reativar",
        text: "Você realmente deseja reativar este contato?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Sim, prosseguir",
        cancelButtonText: "Não, voltar",
    }).then(result => {
        if (result.value) {
            var linha = $(botao).parents('tr');
            var coluna = $(linha.find('td')[6]);
            let ul = $($($(botao).parents('tr').find('td')[6]).find('ul'));
            let index = $(botao).parents('tr').data('index');

            let id_edit = $($(this).parents('tr').find('td')[0]).find('#id_edit').val();

            let situacao_valor = coluna.find('input').val('1').change();

            reativarSituacao(botao, id_edit);

            $.toast({
                heading: "Contato reativado com sucesso!",
                text: "Clique em salvar para gravar as alterações.",
                position: "top-right",
                loaderBg: "#ff6849",
                icon: "success",
                hideAfter: 4000,
            });
        }
    })
}


function reativarSituacao(botao, id_edit){
    let index = $(botao).parents('tr').data('index');
    let tr = $('#corpo-contatos').find('tr[data-index="' + index + '"]');

    let td_situacao = $(tr.find('td')[6]);
    td_situacao.empty();

    let situacao_id = $('#contatocliente-situacao').find('option:selected').val();
    let situacao_descricao = $('#contatocliente-situacao').find('option:selected').text();

    td_situacao.append(
        "<input type='hidden' name='ContatoCliente["+index+"][situacao]' value='1'>" +
        "<input type='hidden' id='situacao_descricao' name='ContatoCliente["+index+"][situacao]' value='Ativo'>" + 'Ativoaaaa');

}

function deleteClick() {
    $('.delete-item').off('click').on('click', function () {
        swalParam($(this).parents('tr').data('index'));
    })
}

function swalParam(contato) {
    swal({
        title: "Excluir",
        text: "Você realmente deseja excluir este contato?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Sim, prosseguir",
        cancelButtonText: "Não, voltar",
    }).then(result => {
        if (result.value) {
            table.rows("[data-index='"+contato+ "']").remove().draw(false);
            $.toast({
                heading: "Excluído com sucesso",
                text: "Clique em salvar para gravar as alterações",
                position: "top-right",
                loaderBg: "#ff6849",
                icon: "success",
                hideAfter: 4000,
            });
        }
    })
}

function modalTelefone(){
    $('.phone-item').off('click').on('click', function () {
        let button = this;
        $('#telefone-modal').modal('show');
        $('#add-telefone-btn').off('click').on('click', function () {
            inserirTelefone(button);
        });
    })
}


function inserirTelefone(button) {
    let contato_nome = $($(button).parents('tr')).data('contato');
    let contato_index = $($(button).parents('tr')).data('index');
    let ul = $($($(button).parents('tr').find('td')[2]).find('ul'));
    let tipo_telefone = $('#telefone-fk_tipo_telefone').find('option:selected').val();
    let telefone = $('#telefone-telefone').val();

    let icon = null;
    switch(tipo_telefone){
        case '1':{
            icon = 'fa fa-building';
            break;
        }
        case '2':{
            icon = 'fa fa-home';
            break;
        }
        case '3':{
            icon = 'fa fa-mobile';
            break;
        }
        case '4':{
            icon = 'fa fa-whatsapp';
            break;
        }
        default:{
            icon = 'fa fa-building';
        }
    }

    if (tipo_telefone !== '' && telefone !== '') {

        ul.append("<li style='list-style-type:none;'><i class='"+icon+"'></i><input type='hidden' name='Telefone[" + indexTelefone + "][telefone]' value='" + telefone + "'>" +
            "<input type='hidden' name='Telefone[" + indexTelefone + "][fk_tipo_telefone]' value='"+ tipo_telefone  +"'>" +
            "<input type='hidden' name='Telefone[" + indexTelefone + "][contato_index]' value='" + contato_index + "'>" + telefone + " " +
            "<button type='button' class='btn btn-rounded btn-xs delete-phone'><i class='fa fa-minus'></i></button> </li>");

        deletePhone();
        indexTelefone++;
        limpaTelefone();

    } else {
        $.toast({
            heading: "Atenção",
            text: "É necessário preencher os campos para adicionar.2",
            position: "top-right",
            loaderBg: '#ff6849',
            icon: 'error',
            hideAfter: 5000,
        });
    }
}

function limpaTelefone() {
    $('#telefone-fk_tipo_telefone').val('').change();
    $('#telefone-telefone').val('');
}

function deletePhone(){
    $('.delete-phone').off('click').on('click', function () {
        $(this).parent().remove();
        deleteItem($(this).parents());
    })
}

function deleteItem() {
    swal({
        title: "Excluir",
        text: "Você realmente deseja excluir este telefone?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Sim, prosseguir",
        cancelButtonText: "Não, voltar",
    }).then(result => {
        if (result.value) {
            for (var i = 0; i < $(this).parent(); i++) {
                $('.delete-phone').off('click').on('click', function () {
                    $(this).parent().remove();
                })
            }
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

function modalContatoEdit(){
    $('.edit-item').off('click').on('click', function () {
        let index = $(this).parents('tr').data('index');
        let button = this;
        let id_edit = $($(this).parents('tr').find('td')[0]).find('#id_edit').val();

        $('#contato-modal').modal('show');
        $('#contatocliente-nome').val($($(this).parents('tr').find('td')[0]).find('input').val());
        $('#contatocliente-email').val($($(this).parents('tr').find('td')[1]).find('input').val());
        $('#contatocliente-data_nascimento').val($($(this).parents('tr').find('td')[3]).find('input').val());
        $('#contatocliente-fk_departamento').val($($(this).parents('tr').find('td')[5]).find('option:selected').text());
        $('#contatocliente-fk_cargo').val($($(this).parents('tr').find('td')[4]).find('option:selected').text());

        $('#save-contato-btn').off('click').on('click', function () {
            let contato_nome = $('#contatocliente-nome').val();
            let contato_email = $('#contatocliente-email').val();
            let data_nascimento = $('#contatocliente-data_nascimento').val();
            let cargo_id = $('#contatocliente-fk_cargo').find('option:selected').val();
            let cargo_descricao = $('#contatocliente-fk_cargo').find('option:selected').text();
            let departamento_id = $('#contatocliente-fk_departamento').find('option:selected').val();
            let departamento_descricao = $('#contatocliente-fk_departamento').find('option:selected').text();

            if (contato_nome !== '' && cargo_descricao !== '' && departamento_descricao !== '' ) {
                atualizarContato(button, id_edit);
            } else {
                $.toast({
                    heading: "Atenção",
                    text: "É necessário preencher os campos para adicionar.",
                    position: "top-right",
                    loaderBg: '#ff6849',
                    icon: 'error',
                    hideAfter: 5000,
                });
            }
        });

    })
}

function atualizarContato(button, id_edit){
    let index = $(button).parents('tr').data('index');
    let tr = $('#corpo-contatos').find('tr[data-index="' + index + '"]');
    let foto = $(tr.find('td')[0]).find('#foto').val();

    let td_nome = $(tr.find('td')[0]);
    td_nome.empty();

    let td_email = $(tr.find('td')[1]);
    td_email.empty();

    let td_nascimento = $(tr.find('td')[3]);
    td_nascimento.empty();

    let td_cargo = $(tr.find('td')[4]);
    td_cargo.empty();

    let td_departamento = $(tr.find('td')[5]);
    td_departamento.empty();


    let nome_edit = $('#contatocliente-nome').val();
    let email_edit = $('#contatocliente-email').val();
    let data_nascimento = $('#contatocliente-data_nascimento').val();
    let cargo_id = $('#contatocliente-fk_cargo').find('option:selected').val();
    let cargo_descricao = $('#contatocliente-fk_cargo').find('option:selected').text();
    let departamento_id = $('#contatocliente-fk_departamento').find('option:selected').val();
    let departamento_descricao = $('#contatocliente-fk_departamento').find('option:selected').text();

    td_nome.append(
        "<span onclick='file(this)'><img src='"+foto+"' alt='user-img' class='img-circle'>"+nome_edit+"</span>" +
        "<input type='hidden' name='ContatoCliente["+index+"][nome]' value='"+nome_edit+"'>" +
        "<input type='hidden' id='id_edit' name='ContatoCliente["+index+"][id_edit]' value='"+id_edit+"'>" +
        "<input type='file' class='hide' name='ContatoCliente["+index+"][foto]' onchange='previewImage(this)'>"+
        "<input type='hidden' id='foto' value='"+foto+"'>"
    );

    td_email.append(
        "<input type='hidden' id='ContatoCliente["+index+"][email]' name='ContatoCliente["+index+"][email]' value='"+email_edit+"'>"+email_edit);

    td_nascimento.append(
        "<input type='hidden' name='ContatoCliente["+index+"][data_nascimento]' value='"+data_nascimento+"'>"+ data_nascimento);

    td_cargo.append(
        "<input type='hidden' name='ContatoCliente["+index+"][fk_cargo]' value='"+cargo_id+"'>" +
        "<input type='hidden' id='cargo_descricao' name='ContatoCliente["+index+"][cargo]' value='"+cargo_descricao+"'>" +cargo_descricao);

    td_departamento.append(
        "<input type='hidden' id='departamento_descricao' name='ContatoCliente["+index+"][departamento]' value='"+departamento_descricao+"'>" +
        "<input type='hidden' name='ContatoCliente["+index+"][fk_departamento]' value='"+departamento_id+"'>" + departamento_descricao);

    $('#contato-modal').modal('hide');
}

function file(div){
    $(div).parent().find('input').click();
}

