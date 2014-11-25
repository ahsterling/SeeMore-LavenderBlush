$(function() {
  $(".unsubscribe-button").click(function(e) {
    e.preventDefault();
    var feed = $(this).parents(".feed-wrapper");
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
  });

  $(".unsubscribe-button-search").click(function(e) {
    console.log("Unsubscribe");
    e.preventDefault();
    console.log("Unsubscribe");
    var feed = $(this).parents(".feed-wrapper");
    var form = $(this).closest("form");
    var url = form.attr("action");

    $.ajax("/user_feeds", {
      type: "DELETE",
      data: form.serialize(),
      success: function() {
        var btn = form.find(".delete");
        console.log(btn);
        btn.toggleClass("btn-info btn-danger");
        btn.toggleClass("delete add");
        btn.val("Add Feed");
        form.children(".unsubscribe-button-search").toggleClass("subscribe-button unsubscribe-button-search");
      },

    });

  });

  $(".subscribe-button").click(function(e) {
    e.preventDefault();
    var feed = $(this).parents(".feed-wrapper");
    var form = $(this).closest("form");
    var url = form.attr("action");

    $.ajax(url, {
      type: "POST",
      data: form.serialize(),
      success: function() {
        var btn = form.find(".add");
        btn.toggleClass("btn-danger btn-info");
        btn.toggleClass("add delete");
        btn.val("Unsubscribe");
        form.children(".subscribe-button").toggleClass("unsubscribe-button-search subscribe-button");
      }
    });
  });
});
