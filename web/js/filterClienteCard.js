$(document).ready(function () {
    var busca = null;
    var lista_clientes = new Array();

    $('#clientes input:hidden').each(function(){
        lista_clientes.push($(this).val());
    });

    $('#entrada').bind('input', function () {
        busca = $(this).val().toLowerCase();

        if(busca !== ''){
            var corresponde = false;
            var saida = Array();
            var quantidade = 0;

            for(var key in lista_clientes){

                corresponde = lista_clientes[key].toLowerCase().indexOf(busca) >= 0;
                if(corresponde){
                    saida.push(lista_clientes[key]);
                    quantidade += 1;
                }
            }

            if(quantidade){
                $('[data-cliente]').each(function () {
                    $(this).addClass('hide');
                });
                $('#empty').addClass('hide');
               for(var ind in saida){
                   $('[data-cliente="'+saida[ind]+'"]').removeClass('hide');
               }
            }else{
                $('[data-cliente]').each(function () {
                    $(this).addClass('hide');
                });
                $('#empty').removeClass('hide');
            }

        }else{
            $('[data-cliente]').each(function () {
                $(this).removeClass('hide');
            });
        }


    });


});

