$(document).on('turbolinks:load', function() {
  $(function(){
    Payjp.setPublicKey("pk_test_051cb92c91fa25532f6d5eef");
    const btn = document.getElementById('token_submit'); //IDがtoken_submitの場合に取得されます
    btn.addEventListener("click", (e) => { //ボタンが押されたときに作動します
      e.preventDefault(); //ボタンを一旦無効化します

      //カード情報生成
      const card = {
        number: document.getElementById("card_number").value,
        cvc: document.getElementById("cvc").value,
        exp_month: document.getElementById("exp_month").value,
        exp_year: document.getElementById("exp_year").value
      }; //入力されたデータを取得します。

      //トークン生成
      Payjp.createToken(card, (status, response) => {
        if (status === 200) { //成功した場合
          $("#card_number").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name"); //カード情報を自分のサーバにpostせず削除しま
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          ); //トークンを送信できるように隠しタグを生成
          document.inputForm.submit();
        } else {
          alert("カード情報が正しくありません。"); //確認用
        }
      });
    });
  },false);

  $(function(){
    Payjp.setPublicKey("pk_test_051cb92c91fa25532f6d5eef");
    const btn2 = document.getElementById('token_submit2'); //IDがtoken_submitの場合に取得されます
    btn2.addEventListener("click", (e) => { //ボタンが押されたときに作動します
      e.preventDefault(); //ボタンを一旦無効化します

      //カード情報生成
      const card = {
        number: document.getElementById("card_number").value,
        cvc: document.getElementById("cvc").value,
        exp_month: document.getElementById("exp_month").value,
        exp_year: document.getElementById("exp_year").value
      }; //入力されたデータを取得します。

      //トークン生成
      Payjp.createToken(card, (status, response) => {
        if (status === 200) { //成功した場合
          $("#card_number").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name"); //カード情報を自分のサーバにpostせず削除しま
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          ); //トークンを送信できるように隠しタグを生成
          document.inputForm.submit();
        } else {
          alert("カード情報が正しくありません。"); //確認用
        }
      });
    });
  },false);
});
//   var form = $("#charge-form");
//   Payjp.setPublicKey('pk_test_0383a1b8f91e8a6e3ea0e2a9');

//   $("#charge-form").on("click", "#submit-button", function(e) {
//     e.preventDefault();
//     form.find("input[type=submit]").prop("disabled", true);
//     var card = {
//         number: parseInt($("#payment_card_no").val()),
//         cvc: parseInt($("#payment_card_security_code").val()),
//         exp_month: parseInt($("#payment_card_expire_mm").val()),
//         exp_year: parseInt($("#payment_card_expire_yy").val())
//     };
//     Payjp.createToken(card, function(s, response) {
//       if (response.error) {
//         alert("error")
//         form.find('button').prop('disabled', false);
//       }
//       else {
//         $(".number").removeAttr("name");
//         $(".cvc").removeAttr("name");
//         $(".exp_month").removeAttr("name");
//         $(".exp_year").removeAttr("name");

//         var token = response.id;
//         $("#charge-form").append($('<input type="hidden" name="payjp_token" class="payjp-token" />').val(token));
//         $("#charge-form").get(0).submit();
//       }
//     });
//   });
// });

  // document.addEventListener("DOMContentLoaded", (e) => {