$(function() {
  $(".unsubscribe").click(function(e) {
    e.preventDefault();
    var feed = $(this).parents(".feed-wrapper");
    console.log(feed);
    var form = $(this).parents("form");
    console.log(form);
    console.log(form.serialize());
    var url = form.attr("action");
    console.log(url);

    $.ajax("/user_feeds", {
      type: "POST",
      data: form.serialize(),
      success: function() {
        console.log("deleted");
        feed.hide();
      }

    });
  });

  $(".subscribe").on("click", function(e) {
    e.preventDefault();
    var btn = $(this);
    var feed = $(this).parents(".feed-wrapper");
    var form = $(this).parents("form");

    $.ajax("/feeds", {
      type: "POST",
      data: form.serialize(),
      success: function() {
        console.log("subscribe clicked");
        btn.toggleClass("btn-danger btn-info");
        btn.toggleClass("unsubscribe subscribe");
        console.log(btn.attr("class"));
        btn.val("Unsubscribe");
        form.attr("action", "/user_feeds");
      }
    });
  });

  // $(".unsubscribe-results").on("click", function(e) {
  //   e.preventDefault();
  //   var btn = $(this);
  //   // var feed = $(this).parents(".feed-wrapper");
  //   var form = $(this).parents("form");
  //
  //   $.ajax("/user_feeds", {
  //     type: "POST",
  //     data: form.serialize(),
  //     success: function() {
  //       console.log("unsubscribe-results clicked");
  //       btn.toggleClass("subscribe unsubscribe-results");
  //       btn.toggleClass("btn-info btn-danger");
  //       btn.val("Add Feed");
  //       form.attr("action", "/feeds");
  //
  //     }
  //   });
  // });

});
