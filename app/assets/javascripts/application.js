// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(document).ready(function(){
    $("#signin").click(function() {
        window.location.href = "/signin";
    })

    $("#signup").click(function() {
        window.location.href = "/signup";
    })

    $("#logout").click(function() {
        window.location.href = '/logout';
    })

    if ($("#buy_it_now").is(":checked")) {
        $("#start_price").show();
    } else {
        $("#start_price").hide();
        $('#start_prices').val('');
    }

    if ($("#auction").is(":checked")) {
        $("#start_auction").show();
    } else {
        $("#start_auction").hide();
        $('#start_bidding').val('');
    }
    $(function () {
       $("#buy_it_now").click(function () {
           if ($(this).is(":checked")) {
               $("#start_price").show();
           } else {
               $("#start_price").hide();
               $('#start_prices').val('');
           }
       });
   });

    $(function () {
       $("#auction").click(function () {
           if ($(this).is(":checked")) {
               $("#start_auction").show();
           } else {
             $('#start_bidding').val('');
               $("#start_auction").hide();

           }
       });
   });

   $(function () {
      $("#reader").click(function () {
        add_checkout()
      });
  });

})

function add_checkout(){

  $.ajax({
      url: "/ajaxtest",
      data : {
        passing: "true"
      },
      dataType: "script",
  });
}
