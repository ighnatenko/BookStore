$(document).on("turbolinks:load", function() {
  var input = $('#items_quantity');
  var val = input.val();

  $('#decrement-book-quantity').on('click', function(event) {
    event.preventDefault();
    if (input.val() > 1) {
      val = +val - 1
      input.val(val);
      return val;
    }
  });

  $('#increment-book-quantity').on('click', function(event) {
    event.preventDefault();
    val = +val + 1
    input.val(val);
    return val;
  });
});