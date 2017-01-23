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
//= require turbolinks
//= require materialize-sprockets
//= require materialize/extras/nouislider
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require social-share-button
//= require Chart.bundle
//= require chartkick
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('.modal').modal();
  $('.carousel').carousel();

  function autoplay() {
    $('.carousel').carousel('next');
  }

  $(function() {
    var interval = setInterval(autoplay, 4000);
    $('.carousel-item').hover(function() {
      clearInterval(interval);
    }, function() {
      interval = setInterval(autoplay, 4000);
    });
  });

  $(function(){
    $('#show-limit').on('change', function(){
      $(this).closest('form').trigger('submit');
    });
  });

  $(function(){
    $('.admin-update-order').on('change', function(){
      $(this).closest('form').trigger('submit');
    });
  });

  $('.carousel-item').each(function(){
    $(this).click(function(e){
      e.preventDefault();
    })
  });
});
