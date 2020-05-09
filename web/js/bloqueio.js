let index_produto;
let table_produto;

$(document).ready(function () {
    $.extend($.fn.dataTable.defaults, {
        dom: 'B<"datatable-scroll"t><"datatable-footer">',
        autoWidth: false,
        paging: false,
        searching: false,
        ordering: false,
        retrieve: false,
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
                $('input', this.header()).on('keyup change', function () {
                    if (that.search() !== this.value) {
                        that
                            .search(this.value)
                            .draw();
                    }
                });
            })
        }
    });
    let tabela_produto = $('#corpo-produtos');
    table_produto = tabela_produto.parents('table').DataTable();
    index_produto = table_produto.rows().count();
    deleteProduto();

    $('#add-produto-btn').off('click').on('click', function () {
        let produto_id = $('#bloqueioproduto-fk_produto').find('option:selected').val();
        let produto_descricao = $('#bloqueioproduto-fk_produto').find('option:selected').text();

        if(produto_descricao !== '' && produto_id !== ''){
            let tbody_produto = $('#corpo-produtos');
            let exist_produto = tbody_produto.find('tr[data-produto="' + produto_descricao + '"]');

            if (exist_produto.length === 0){
                table_produto.row.add($(
                    "<tr data-index-produto='"+index_produto+"' data-produto='"+produto_descricao+"'>" +
                    "<td><input type='hidden' name='BloqueioProduto["+index_produto+"][fk_produto]' value='"+produto_id+"'>"+produto_descricao+"</td>" +

                    "<td class='text-center'><button type='button' class='btn btn-sm btn-rounded btn-danger delete-produto'><i class='fa fa-trash'></i></button></td>" +
                    "</tr>"
                )[0]).draw(false);

                $.toast({
                    text: "Adicionado com sucesso",
                    position: "top-right",
                    loaderBg: "#ff6849",
                    icon: "success",
                    hideAfter: 2000,
                });
                deleteProduto();
                $('#bloqueioproduto-fk_produto').val('').change();
                index_produto++;
            }else{
                swal({
                    title: "Atenção",
                    text: "Este produto já está na lista.",
                    type: "warning",
                });
            }

        }else{
            $.toast({
                heading: "Atenção",
                text: "É necessário selecionar um produto.",
                position: "top-right",
                loaderBg: '#ff6849',
                icon: 'error',
                hideAfter: 5000,
            });
        }

    });

});

function deleteProduto(){
    $('.delete-produto').off('click').on('click', function () {
        swalParam($(this).parents('tr').data('index-produto'));
    })
}

function swalParam(produto) {
    swal({
        title: "Excluir",
        text: "Você realmente deseja remover este produto?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Sim, prosseguir",
        cancelButtonText: "Não, voltar",
    }).then(result => {
        if (result.value) {
            table_produto.rows("[data-index-produto='"+produto+"']").remove().draw(false);
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


function bloquear(id){
    $('#corpo-produtos').parents('table').DataTable().rows('tr').remove().draw(false);
    $('#bloqueio-fk_cliente').val(id);
    $('#bloqueio-modal').modal('show');

    $.ajax({
        type: 'get',
        url: $('#bloqueio-fk_contrato').data('url'),
        data: {'id': id},
        beforeSend: function(){
            $('#bloqueio-fk_contrato').children('option:not(:first)').remove();
        }
    }).done(function (data){
        var retorno = JSON.parse(data);
        $(retorno.output).each(function (index, element){
            $('#bloqueio-fk_contrato').append('<option value="'+element.id+'">'+element.numero+'</option>')
        });
    });
}

function desbloquear(id){

    $('#corpo-bloqueios').parents('table').DataTable().rows('tr').remove().draw(false);
    $('#cliente').val(id);
    $.ajax({
        type: 'get',
        url: '/crm/web/bloqueio/get-bloqueios-cliente',
        data: {'id' : id},
    }).done(function (data){
       var retorno = JSON.parse(data); console.log(retorno);
       $(retorno.output).each(function (index, element) {

           $('#corpo-bloqueios').parents('table').DataTable().row.add($(
               "<tr data-index='"+index+"' data-bloqueio='"+element.id+"'>" +
               "<td><input type='hidden' name='Bloqueio["+index+"][fk_contrato]' value='"+element.contrato_id+"'>" +
                    "<input type='hidden' name='Bloqueio["+index+"][bloqueio_id]' value='"+element.id+"'>"+element.contrato+"</td>" +
               "<td><ul id='Produtos[" + index + "]'></ul>"+ "</td>" +
               "<td><input type='hidden' name='Bloqueio["+index+"][data_bloqueio]' value='"+element.data_bloqueio+"'>"+element.data_bloqueio+"</td>" +
               "<td><input type='hidden' name='Bloqueio["+index+"][data_limite]' value='"+element.data_limite+"'>"+element.data_limite+"</td>" +
               "<td><input type='hidden' name='Bloqueio["+index+"][fk_usuario]' value='"+element.usuario_id+"'>"+element.usuario+"</td>" +
               "<td class='text-center'><button id='delete-bloqueio' type='button' class='btn btn-sm btn-rounded btn-danger delete-bloqueio' onclick='deleteBloqueio(this)'><i class='fa fa-trash'></i></button></td>" +
               "</tr>"
           )[0]).draw(false);
           $(element.produtos).each(function (index_produto, element_produto) {

               $($('#corpo-bloqueios').children('tr[data-index="' + index + '"]').find('td')[1]).find('ul').append(
                   "<li><input type='hidden' name='BloqueioProduto[" + index_produto + "][fk_produto]' value='" + element_produto.id + "'>" + element_produto.descricao + " </li>"
               );
           });

       });
    });

    $('#desbloqueio-modal').modal('show');
}

function deleteBloqueio(button){
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
            $('#corpo-bloqueios').parents('table').DataTable().rows("[data-index='"+$(button).parents('tr').data('index')+ "']").remove().draw(false);
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

