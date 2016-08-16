// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(document).on('ready page:load', function(){
  $("#login-button").click(function(event){
    event.preventDefault();

    $('form').fadeOut(500);
    $('.login-wrapper').addClass('form-success');
  });

  $("#user_username").blur(function(){
    $(this).attr('placeholder', 'Username');
  });

  $('form, input').focus(function(){
    $(this).removeAttr('placeholder');
  });

  $("#user_username").on("blur", function(){
    $("#username-length").hide();
  }).on("focus", function(){
    $("#username-length").show();
  });

  $("#password-length").hide();

  $("#user_password").on("focus", function(){
    $("#password-length").show();
  });

  $("#user_password").on("blur", function(){
    $("#password-length").hide();
  });

  $('#user_email').blur(function(){
    $(this).attr('placeholder', 'Email');
  });

  $('#user_password').blur(function(){
    $(this).attr('placeholder', 'Password');
  });

  $("#user_zip").blur(function(){
    $(this).attr('placeholder', 'Zipcode');
  });

  $('form, input').focus(function(){
    $(this).removeAttr('placeholder');
  });

  $("#user_password_confirmation").blur(function(){
    $(this).attr('placeholder', 'Password Confirmation');
  });

  $('form, input').focus(function(){
    $(this).removeAttr('placeholder');
  });
});
