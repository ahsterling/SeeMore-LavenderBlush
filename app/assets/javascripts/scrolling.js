var attach_events = function(){

  $(".pagination a").click(function(){
    var url = $(this).attr("href");
    console.log(url);
    $.getScript(url);
    return false;
  });

};

$(function(){
  attach_events();  
});
