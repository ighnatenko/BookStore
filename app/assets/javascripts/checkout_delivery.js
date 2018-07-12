$(document).on("turbolinks:load", function() {
  $('.delivery_row').click(function(event) {
    var obj = $('.delivery_row');
    var total = this.getAttribute("total");
    var delivery_price = this.getAttribute("delivery_price");
    var sum = parseFloat(total) + parseFloat(delivery_price);
    $('.summary-total')[0].innerHTML = "€" + sum.toFixed(1);
  });
});