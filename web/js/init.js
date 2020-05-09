$(window).on('load', function () {
    $.fn.modal.Constructor.prototype.enforceFocus = function () {
    };

    $(':radio[readonly]:not(:checked)').attr('disabled', true);
});

var original;
$(document).ready(function () {
    original = $("#side-menu").find('li.active').last();
});

yii.confirm = function (message, okCallback, cancelCallback) {
    swal({
        title: message,
        type: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Cancelar',
        confirmButtonText: 'Sim',
        allowOutsideClick: true
    }).then((willDelete) => {
        if(willDelete.value === true) {
        !okCallback || okCallback();
    }else {
        return false;
    }
});
};

Number.prototype.format = function (n, x, s, c) {
    let re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\D' : '$') + ')',
        num = this.toFixed(Math.max(0, ~~n));
    return (c !== undefined ? num.replace('.', c) : num).replace(new RegExp(re, 'g'), '$&' + ((s === undefined) ? ',' : s));
};

function diferencaFirstLast(source) {
    if (source.length > 1)
        return (source[source.length - 1] - source[0]).format(2, 3, '.', ',');
    else
        return (0).format(2, 3, '.', ',');
}

function avgWithNull(data) {
    let n = data && data.length || 0, out = 0;
    for (i = 0; i < n; i++) {
        if (isNaN(data[i]))
            out += 0;
        else
            out += data[i];
    }
    return (out / n).format(3, 3, '.', ',');
}

function avgWithoutNull(data) {
    let n = data && data.length || 0, out = 0, qnt = n;
    for (i = 0; i < n; i++) {
        if (isNaN(data[i])) {
            out += 0;
            qnt--;
        }
        else
            out += data[i];
    }

    if (qnt !== 0)
        return (out / qnt).format(3, 3, '.', ',');
    else
        return (0).format(3, 3, '.', ',');
}

String.prototype.converteMoedaFloat = function () {
    if (this === "") {
        valor = 0;
    } else {
        valor = this.replace(".", "");
        valor = valor.replace(",", ".");
        valor = parseFloat(valor);
    }
    return valor;
};

function searchSideMenu() {
    var input, filter, ul;
    input = $("#search-menu");
    filter = input.val().toUpperCase();
    ul = $("#side-menu");
    resetMenu(ul);

    if (filter !== '') {
        var a, i, li;
        li = ul.find("li");
        for (i = 0; i < li.length; i++) {
            a = $(li[i]).find("span.hide-menu").first();
            console.log(a.html(), li[i], $(li[i]).hasClass('nav-small-cap') );
            if ($(li[i]).hasClass('nav-small-cap') || a.html().indexOf('<span class="fa arrow"></span>') > -1) {
                $(li[i]).attr('data-found', 0);
            } else if (a.html().toUpperCase().indexOf(filter) > -1) {
                $(li[i]).attr('data-found', 1);
            } else {
                $(li[i]).attr('data-found', 0);
            }
        }

        for (i = 0; i < li.length; i++) {
            var li_filhos = $(li[i]).find('li[data-found="1"]');
            //console.log(li_filhos);
            if (li_filhos.length !== 0) {
                $(li[i]).attr('data-found', 1);
                $(li[i]).addClass('active');
                $(li[i]).find('ul').first().addClass('in');
            }
        }
    } else {
        original.parents('li').addClass('active');
        original.parents('li').children('ul').addClass('in');
    }
}

function resetMenu(ul) {
    ul.find('li').removeAttr('data-found');
    ul.find('li').removeClass('active');
    ul.find('li').children('ul').removeClass('in');
}
