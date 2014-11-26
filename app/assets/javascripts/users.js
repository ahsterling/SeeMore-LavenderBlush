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
    var addBtn = $(this);
    var feed = $(this).parents(".feed-wrapper");
    var form = $(this).parents("form");
    var unBtn = form.siblings("form").find(".btn");

    $.ajax("/feeds", {
      type: "POST",
      data: form.serialize(),
      success: function() {
        console.log("subscribe clicked");
        unBtn.removeClass("hide");
        addBtn.addClass("hide");

      }
    });
  });

  $(".unsubscribe-results").on("click", function(e) {
    e.preventDefault();

    e.preventDefault();
    var unBtn = $(this);
    var feed = $(this).parents(".feed-wrapper");
    var form = $(this).parents("form");
    var addBtn = form.siblings("form").find(".btn");

    $.ajax("/user_feeds", {
      type: "POST",
      data: form.serialize(),
      success: function() {
        console.log("unsubscribe-results clicked");

        addBtn.removeClass("hide");
        unBtn.addClass("hide");


      }
    });
  });

});
