$(function(){

  $("#twitter-search").hide();

  $(".twitter-bird").click(function(){
    $("#twitter-search").toggle();
    $("#vimeo-search").hide();
  });

  $("#vimeo-search").hide();

  $(".vimeo-v").click(function(){
    $("#vimeo-search").toggle();
    $("#twitter-search").hide();
  });


});
