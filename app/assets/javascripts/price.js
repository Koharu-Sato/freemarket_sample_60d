$(function () {
  $(document).on('keyup', '#selling-price', function () {
    let input = $(this).val();
    if (input >= 300 && input < 10000000) {
      let charge = parseInt(input * 0.1);
      $("#sales-commission").text("¥" + charge.toLocaleString());
      let profit = input - charge;
      $("#sales-profit").text("¥" + profit.toLocaleString());
    }
    else {
      $("#sales-commission").text("-");
      $("#sales-profit").text("-");
    }
  });
});