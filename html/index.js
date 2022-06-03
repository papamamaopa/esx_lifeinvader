window.addEventListener("message", function (event) {
  var item = event.data;
  if (item.showUI) {
    $("#wrapper").show();
  } else {
    $("#wrapper").hide();
  }
});
