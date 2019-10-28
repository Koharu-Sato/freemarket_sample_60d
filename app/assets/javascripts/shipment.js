    // 配送方法
    $(document).on('turbolinks:load', function(){
      function appendMethod(method) {
        let html = `<option value=${method}>${method}</option>`
        return html;
      }
    
      function appendDeliveryMethodSelect(insertHTML){
        let delivery =`<div class="send__main__content__form__box4__content__group2" id="delivery-method">
                        <label id="title">配送の方法</label>
                        <span id="mark">必須</span>
                        <div class="send__main__content__form__box4__content__group2__select">
                          <select class="send__main__content__form__box4__content__group2__select__show" name="item[delivery_method]">
                            <option>---</option>
                            ${insertHTML}
                          </select>
                        </div>
                      </div>`
        $('#shipment-box').append(delivery);
      }
    
      $('#shipment-form').on("change", ".send__main__content__form__box4__content__group1__select", function() {
        let fee = document.getElementById('item_delivery_fee').value;
        $('#delivery-method').remove();
        methods1 = ["未定","らくらくメルカリ便","ゆうメール","レターパック","普通郵便（定形、定形外）","クロネコヤマト","ゆうパック","クリックポスト","ゆうパケット"];
        methods2 = ["未定","クロネコヤマト","ゆうパック","ゆうメール"];
        let insertHTML = '';
        if ( fee == "送料込み（出品者負担）"){
          methods1.forEach(function(method){
            insertHTML += appendMethod(method);
          })
          appendDeliveryMethodSelect(insertHTML);
        } else {
          methods2.forEach(function(method){
            insertHTML += appendMethod(method);
          })
          appendDeliveryMethodSelect(insertHTML);
        }
      })
    });