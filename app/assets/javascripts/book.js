$(document).on("turbolinks:load", function() {
  var input = $('#items_quantity');
  var val = parseInt(input.val());

  $('#decrement-book-quantity').on('click', function(event) {
    event.preventDefault();
    if (val > 1) {
      val -= 1;
      input.val(val);
    }
  });

  $('#increment-book-quantity').on('click', function(event) {
    event.preventDefault();
    val += 1;
    input.val(val);
  });
});