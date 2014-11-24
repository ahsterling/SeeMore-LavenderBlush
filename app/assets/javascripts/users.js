$(function() {
  $(".unsubscribe-button").click(function(e) {
    e.preventDefault();
    var feed = $(this).parents(".feed-wrapper");
    console.log(feed);
    var form = $(this).closest("form");
    var url = form.attr("action");

    $.ajax(url, {
      type: "DELETE",
      data: form.serialize(),
      success: function() {
        console.log("deleted");
        feed.hide();
      }
    });
    console.log("unsubscribe");
  });
});
