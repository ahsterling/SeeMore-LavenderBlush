var attach_events = function(){


  $(window).scroll(function(){
    var url = $(".next_page").attr("href");
    if(url && $(window).scrollTop() > $(document).height() - $(window).height() - 50)
      {
        $('.pagination').text('Fetching more posts...');
        $.getScript(url);
        return false;
      }
  });

};

$(function(){
  attach_events();
});
