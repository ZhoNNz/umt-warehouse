var houseCategorys = {};

var selectedObject = null;

var selectedObjectData = null;

$(".container").hide();
$("#display").hide();
$("#computer").hide();

$('document').ready(function() {

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type == "toggle") { 
            if (item.status == true) {
                $(".container").fadeIn(250);
            } else {
                $(".container").fadeOut(250);
            }
        }
        if (event.data.type == "enableui") {
            // $('#display').css('display', event.data.enable ? "block" : "none")
            if (event.data.enable)
            $("#display").show();
            else
            $("#display").hide();

        }
        if (item.type == "setupContract") {
            $("#welcome-name").html(item.firstname + " " + item.lastname)
            $("#property-adress").html(item.street)
            $("#property-price").html("$ " + item.houseprice);
            $("#property-brokerfee").html("$ " + item.brokerfee);
            $("#property-bankfee").html("$ " + item.bankfee);
            $("#property-taxes").html("$ " + item.taxes);
            $("#property-totalprice").html("$ " + item.totalprice);
        }

        if (item.type == "openObjects") {
            Decorations.Open(item);
            houseCategorys = item.furniture;
        }

        if (item.type == "closeUI") {
            Decorations.Close();
        }

        if (item.type == "buyOption") {
            $(".decorate-confirm").css("display", "block");
            $(".decorate-confirm").find("p").html("Weet je zeker dat je het object wilt kopen voor €"+selectedObjectData.price+"?");
        }

        if (item.type == "objectLoaded") {
            $(".decorate-item").css({'pointer-events': 'auto'});
            $(".object-load-status").css("display", "none");
        }

        if (item.type == "frontcam") {
            if (item.toggle) {
                $("#house-cam").fadeIn(150);
                $("#cam-label").html(item.label);
            } else {
                $("#house-cam").fadeOut(150)
            }
        }
    })

})

var currentCode = "";
$(".property-accept").click(function(e){
    $.post('http://umt-warehouse/buy', JSON.stringify({}))
    setTimeout(10)
    $.post('http://umt-warehouse/exit', JSON.stringify({}));
    
});

$(".property-cancel").click(function(e){
    $.post('http://umt-warehouse/exit', JSON.stringify({}));
});





//  KEYPAD KISMI

var currentCode = "";
var audioPlayer = null;

document.addEventListener('keydown', logKey);

function logKey(e) {
    if (e.isComposing ||e.keyCode === 96) {
        audioPlayer.play();
        currentCode = currentCode + "0";
      };
    if (e.isComposing ||e.keyCode === 97) {
        audioPlayer.play();
        currentCode = currentCode + "1";
      };
      if (e.isComposing ||e.keyCode === 98) {
        audioPlayer.play();
        currentCode = currentCode + "2";
      };
      if (e.isComposing ||e.keyCode === 99) {
        audioPlayer.play();
        currentCode = currentCode + "3";
      }
      if (e.isComposing ||e.keyCode === 100) {
        audioPlayer.play();
        currentCode = currentCode + "4";
      };
      if (e.isComposing ||e.keyCode === 101) {
        audioPlayer.play();
        currentCode = currentCode + "5";
      };
      if (e.isComposing ||e.keyCode === 102) {
        audioPlayer.play();
        currentCode = currentCode + "6";
      };
      if (e.isComposing ||e.keyCode === 103) {
        audioPlayer.play();
        currentCode = currentCode + "7";
      };
      if (e.isComposing ||e.keyCode === 104) {
        audioPlayer.play();
        currentCode = currentCode + "8";
      };
      if (e.isComposing ||e.keyCode === 105) {
        audioPlayer.play();
        currentCode = currentCode + "9";
      };
    //   if (e.isComposing ||e.keyCode === 13) {
    //     audioPlayer.play();
    //     $.post('http://umt-warehouse/try', JSON.stringify({
    //         code: currentCode
    //     }));

    //     currentCode = "";  
    //   };
      if (e.isComposing ||e.keyCode === 8) {
        audioPlayer.play();
        currentCode = "";

        currentCode = "";  
      };


}

$(document).ready(function(){  

    if (audioPlayer != null) {
        audioPlayer.pause();
    }



    audioPlayer = new Howl({src: ["numField.mp3"]});
    audioPlayer.volume(0.1);
    
    $("#key1").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "1";
    }); 
    $("#key2").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "2";
    }); 
    $("#key3").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "3";
    }); 
    $("#key4").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "4";
    }); 
    $("#key5").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "5";
    }); 
    $("#key6").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "6";
    }); 
    $("#key7").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "7";
    }); 
    $("#key8").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "8";
    }); 
    $("#key9").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "9";
    }); 
    $("#key0").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "0";
    }); 

    $("#keyCancel").click(function(){
        audioPlayer.play();
        // $('3display').css('display', "none")
        $("#display").hide();
        $.post('http://umt-warehouse/escape', JSON.stringify({}));
    }); 

    $("#keyClear").click(function(){
        audioPlayer.play();
        currentCode = "";
    });

    $("#keyEnter").click(function(){
        audioPlayer.play();
        $("#display").hide();
        $.post('http://umt-warehouse/try', JSON.stringify({
            code: currentCode
            
        }));

        currentCode = "";        
    });
});
