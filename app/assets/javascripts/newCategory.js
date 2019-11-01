$(document).on('turbolinks:load', function(){
  // カテゴリーボックス
  function appendOption(category) {
    let html = `<option value="${ category.id }", data-category="${ category.id }">${ category.name }</option>`;
    return html;
  }

  function appendChildrenSelectBox(insertHTML) {
    let childrenhtml = '';
    childrenhtml = `<div class="send__main__content__form__box3__content__group1__div__select", id="children_box">
                      <select class="send__main__content__form__box3__content__group1__div__select__show", id="child-form">
                        <option>---</option>
                        ${ insertHTML }
                      </select>
                    </div>`;
    $('#category-form').append(childrenhtml);
  }

  function appendGrandchildrenSelectBox(insertHTML) {
    let grandchildrenhtml = '';
    grandchildrenhtml = `<div class="send__main__content__form__box3__content__group1__div__select", id="grandchildren_box", name="item[category_items_attributes][0][category_id]" >
                      <select class="send__main__content__form__box3__content__group1__div__select__show", id="grandchild-form", name="item[category_items_attributes][0][category_id]" >
                        <option value="---" data-category="---" >---</option>
                        ${ insertHTML }
                      </select>
                    </div>`;
    $('#category-form').append(grandchildrenhtml);
  }

  // search時の孫カテゴリcheckbox
  function appendCheckbox(category) {
    let html = `<div class="left__box__detail__delivery-fee__box__boxes">
                  <input name="q[category_items_id_eq][]" type="hidden" value="${ category.id }">
                  <input type="checkbox" value="${ category.id }" name="q[category_items_id_eq][]" id="q_category_items_id_eq_${ category.id }">
                  <label for="q_${ category.id }">${ category.name }</label>
                </div>`;
    // let html = `<option value="${ category.id }", data-category="${ category.id }">${ category.name }</option>`;
    return html;
  }

  function appendGrandchildrenCheckBox(insertHTML) {
    let grandchildrenhtml = '';
    grandchildrenhtml = `<div class="left__box__detail__category__box", id="grandchildren_box", name="item[category_items_attributes][0][category_id]" >
                            ${ insertHTML }
                        </div>`;
    $('#category-form').append(grandchildrenhtml);
  }

// 親選択時のイベント
  $("#parent-form").on("change",function(){
    let parent = document.getElementById("parent-form").value;
    if (parent != "---") {
      $.ajax({
        url: '/items/get_children',
        type: "GET",
        dataType: 'json',
        data: { parent_id: parent }
      })
      .done(function(children) {
        $('#children_box').remove();
        $('#grandchildren_box').remove();
        // $('#size_box').remove();
        // $('#brand_form').remove();
        let insertHTML = '';
        children.forEach(function(child) {
          insertHTML += appendOption(child)
        });
        appendChildrenSelectBox(insertHTML);
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      })
    } else {
      $('#children_box').remove();
      $('#grandchildren_box').remove();
      // $('#size_box').remove();
      // $('#brand_form').remove();
    }
  });
// 子選択時のイベント
  $('#category-form').on("change", "#child-form", function() {
    let child = document.getElementById("child-form").value;
    if (child != "---"){
      $.ajax({
        url: '/items/get_grandchildren',
        type: 'GET',
        dataType: 'json',
        data: { child_id: child }
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_box').remove();
          // $('#size_box').remove();
          // $('#brand_form').remove();
          let insertHTML = '';
          if (document.URL.match("/items/search")) {
            grandchildren.forEach(function(grandchild) {
              insertHTML += appendCheckbox(grandchild);
            });
            appendGrandchildrenCheckBox(insertHTML);
            // console.log(location.href);
            // console.log(location.pathname);
          } else {
            grandchildren.forEach(function(grandchild) {
              insertHTML += appendOption(grandchild);
            });
            appendGrandchildrenSelectBox(insertHTML);
          }
        }
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました')
      })
    } else {
      $('#grandchildren_box').remove();
      // $('#size_box').remove();
      // $('#brand_form').remove();
    }
  });
});