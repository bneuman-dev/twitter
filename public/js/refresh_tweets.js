function refresh_tweets() {
  var username = $("#username").data().username;
  console.log(username);

  $.ajax({
    url: "/refresh_tweets",
    data: {"username": username},
    success: function (response) {
      console.log(response);
      var old_html = $(".container").html();
      $(".container").html(old_html + response);
      $("#waiting").hide();
    }
  });
}

$(document).ready(function() {
  refresh_tweets();
});
