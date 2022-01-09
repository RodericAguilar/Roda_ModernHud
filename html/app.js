window.addEventListener('load', () => {
    $('.hudanimado').hide()
});


window.addEventListener("message", function(event) {
    var v = event.data 
    var date = new Date;
    var minute = date.getMinutes()
    var hour = date.getHours()
    var year = date.getFullYear();
    var month = date.getMonth(); // beware: January = 0; February = 1, etc.
    var day = date.getDate();
    let dollar = Intl.NumberFormat('en-US');
    var bar1 = new ldBar("#vidap");
    var bar2 = new ldBar("#chalecop")
    var bar3 = new ldBar("#stamina")
    var bar4 = new ldBar("#burger")
    var bar5 = new ldBar("#water")
    var bar6 = new ldBar("#swim")
    if (v.show == true) {
        bar1.set(v.health)
        bar2.set(v.armor)
        bar3.set(v.stamina)
        bar4.set(v.food)
        bar5.set(v.thirst)
        document.getElementById("chaleco").style.setProperty("--percentage", v.armor + '%'); 
        document.getElementById("comida").style.setProperty("--percentage", v.food + '%');
        document.getElementById("agua").style.setProperty("--percentage", v.thirst + '%');
        document.getElementById("cora").style.setProperty("--percentage", v.health + '%');
       document.getElementById("correr").style.setProperty("--percentage", v.stamina + '%');
        $('.toditito').fadeIn(1000)
        $('.pid').html(v.playerid)
        $('.hora').html(hour+':'+minute)
        $('.day').html(day+'.'+month+1+'.'+year)
        $('.totalp').html(v.players+'/'+v.maxplayers)
        
        // Food and Thirst
        // Food and Thirst finish

        if (v.voice == true) {
            $('.microfono').css({'color': '#AFFF48'})
        } else if (v.voice == false) {
            $('.microfono').css({'color': '#8B8888'})
        }
    } else if (v.show == false) {
        $('.toditito').fadeOut(1000)
    }

    if (v.showmoney == true) {
        $('.moneyh').html(' '+dollar.format(v.money))
        $('.bankh').html(' $'+dollar.format(v.bank))
        $('.uidp').html(v.uid)
    }

    if (v.font == true) {
        $('#mostrar').fadeIn(1000)
    } else if(v.font == false) {
        $('#mostrar').fadeOut(1000)
    }

    if (v.coche == true) {
        $('.velocidadtext').html(Math.round(v.vel))
        $('.rellenolinea').css({'width': v.vel/4.5+'%'})
        $('.delante').css({'width': v.vel/4.5+'%'})
        $('.gasotext').html(Math.round(v.gasolina)+'L')
        $('.s1').html(v.s1)
        $('.s2').html(v.s2)
        $('.calle').fadeIn(100)
        $('.rellenogasolina').css({'width': v.gasolina+'%'})
        if (v.cinturon == true) {
            $('.circulocinturon').css({'background-color': 'rgb(0, 255, 34)'})
        } else if (v.cinturon == false) {
            $('.circulocinturon').css({'background-color': 'red'})
        }

        if (v.bateria == true) {
            $('.circulobateria').css({'background-color': 'rgb(0, 255, 34)'})
        } else if (v.bateria == false) {
            $('.circulobateria').css({'background-color': 'red'})
        }

        $('.carhudpe').show()
    } else if (v.coche == false) {
        $('.carhudpe').hide()
        $('.calle').fadeOut(100)
    }

    if (v.showOxigen == true ) {
        $('.stamina').fadeOut(100)
        $('.corriendope').fadeOut(100)
        $('.swim').fadeIn(1000)
        $('.nadandope').fadeIn(1000)
        document.getElementById("nadar").style.setProperty("--percentage", v.oxigen + '%');
        bar6.set(v.oxigen)
    } else if (v.showOxigen == false) {
        $('.swim').fadeOut(1000)
        $('.nadandope').fadeOut(1000)
        $('.corriendope').fadeIn(1000)
        $('.stamina').fadeIn(1000)
    }

    if (v.radioon == true) {
        $('#walkie').css({'color': '#AFFF48'})
    } else if(v.radioon == false) {
        $('#walkie').css({'color': '#8B8888'})
    }

    if (v.hudreal == true) {
        $('.hudanimado').hide()
        $('.hudreal').show()
        $('#mostrar').fadeOut(1000)
    } else if(v.hudfalse == true) {
        $('.hudreal').hide()
        $('.hudanimado').show()
        $('#mostrar').fadeOut(1000)
    }

    if(v.pausa == true) {
        $('.toditito').fadeOut(1000)
    } else if(v.pausa == false) {
        $('.toditito').fadeIn(1000)
    }

    if (v.showweapon == true) {
        $(".armas").fadeIn(100);
        $('.weapon').attr('src', 'weapons/weapon_'+v.arma+'.png');
        $(".balat").html(v.resta);
        $(".balar").html(v.cargada);
    } else if (v.showweapon == false) {
        $(".armas").fadeOut(100);
    }
});


$(document).keyup((e) => {
    if (e.key === "Escape") {
        setTimeout(() => {
            $.post('https://Roda_ModernHud/exit', JSON.stringify({}));
        }, 300);
    }
});
    



$(function() {
$(".boton").click(() => {
    if (numerouno == true) {
        setTimeout(() => {
            $.post('https://Roda_ModernHud/real', JSON.stringify({}));
        }, 300);
    } else if (numerodos == true) {
        setTimeout(() => {
            $.post('https://Roda_ModernHud/animado', JSON.stringify({}));
        }, 300);
    }

});
});

$(function() {
$(".imagen1").click(() => {
    $('.imagen1').css({'width': "20vw", "height": "21vw"})
    $('.imagen2').css({'width': "19vw", "height": "20vw"})
    numerouno = true
    numerodos = false
});
});

$(function() {
$(".imagen2").click(() => {
    $('.imagen2').css({'width': "20vw", "height": "21vw"})
    $('.imagen1').css({'width': "19vw", "height": "20vw"})
    numerouno = false 
    numerodos = true
});
});