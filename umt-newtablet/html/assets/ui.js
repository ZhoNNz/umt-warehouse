// $(function () {
//     $(".container").hide();
//       $(".ray_f").hide();
//     function display(bool) {
//         if (bool) {
//             $(".container").fadeIn(1000);
//             $(".system-actions").hide();
//         } else {
//             $(".container").fadeOut(500);
//         }
//     }
//
//     // display(false)
//
//     window.addEventListener('message', function(event) {
//         var item = event.data;
//         if (item.type === "ui") {
//             $(".ray_f").show();
//             // if (item.status == true) {
//                 // display(true)
//             // } else {
//                 // display(false)
//             }
//         }
//     })
//
//     document.onkeyup = function (data) {
//         if (data.which == 27) {
//             $.post('http://umt-newtablet/exit', JSON.stringify({}));
//             return
//         }
//     };
// });

$(function () {
    $(".container").hide();
    function display(bool) {
        if (bool) {
            $(".ray_f").fadeIn(1000);
            $(".system-actions").hide();
        } else {
            $(".container").fadeOut(500);
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                setTimeout(function () {
                  rayshow()
                }, 2400);
            } else {
                display(false)
            }
        }
        
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
          $(".ray_f").hide();
            $.post('http://umt-newtablet/exit', JSON.stringify({}));
            return
        }
    };
});

function passtosc() {
    $(".ray_f").hide();
                $(".container").show();
}

function rayshow() {function makeid(length) {
            var result           = '';
            var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
            var charactersLength = characters.length;
            for ( var i = 0; i < length; i++ ) {
                 result += characters.charAt(Math.floor(Math.random() * charactersLength));
            }
            return result;
        }


        var input_ps = document.getElementById("ps-ray");
        var i_ray = 0;
        var timer_ray = setInterval(inp_ray, 150);
        function inp_ray() {
            if (i_ray < 14) {
                i_ray = i_ray + 1;
                input_ps.value = makeid(i_ray);
            }


        }}
