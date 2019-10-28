$(document).on('turbolinks:load',(function(){

  //親表示
  function appendCategories(categories){
    $('#categoryBox__box').empty();
    let num = 0;
    categories.forEach(function(category){
      var html = `<a href="/categories/${category.id}" class="categoryList", data-child="${num}">${category.category}</a>`
      $('#categoryBox__box').append(html);
      num++;
    });
    var listhtml = `<a href="/categories" class="categoryList">カテゴリー一覧</a>`
    $('#categoryBox__box').append(listhtml);

    $(".categoryList").on("mouseover",function(e){
      let datachild = $(this).data('child');
      let parentdata = categories[datachild]
      e.preventDefault();
      appendChildCategories(parentdata);
    });
  };

  //子表示
  function appendChildCategories(parentdata){
    $("#categoryBox__childbox").empty();
    parentdata.children.forEach(function(childCategory){
      var childhtml = `<a href="/categories/${childCategory.id}" class="childcategoryList", data-parent="${childCategory.ancestry}", data-grandchild="${childCategory.id}">${childCategory.category}</a>`
      $('#categoryBox__childbox').append(childhtml);
    });

    $(".childcategoryList").on("mouseover",function(e){
      let datagrand = $(this).data('grandchild');
      e.preventDefault();
      appendGrandChildCategories(datagrand);
    });
  }

  //孫表示
  function appendGrandChildCategories(datagrand){
    $.ajax({
      type: "GET",
      url: "/items/getAllCategory",
      data: {child_id: datagrand},
      dataType: "json"
    })
    .done(function(categories){
      $("#categoryBox__grandchildbox").empty();
      categories.forEach(function(grandchildCategory){
        var childhtml = `<a href="/categories/${grandchildCategory.id}" class="grandchildcategoryList">${grandchildCategory.category}</a>`
        $('#categoryBox__grandchildbox').append(childhtml);
      });
    })
    .fail(function(){
      alert("通信エラー...");
    });
  }

  function scroller(id){
    var target = $("[data-name=" + id + "]");
    var position = target.offset().top
    $("*").animate({
      scrollTop: position
    }, 300, 'swing');
  };

  //:hover
  $('.header__box__lower__list-categories__category').on("mouseover",function(){
    $.ajax({
      type: 'GET',
      url:   '/items/getCategory',
      dataType: 'json' 
    })
    .done(function(categories){
      appendCategories(categories);
      $('#categoryBox').css("display", "flex");
    })
    .fail(function(){
      alert("通信エラー");
    });
  });

  $(".category__top__contents__box__rank").click(function(){
    var id = $(this).data('id');
    scroller(id);
  });
  $(".categories__box__root__category").click(function(){
    var id = $(this).data('id');
    scroller(id);
  });

  $("#categoryBox__box").on("mouseover",function(){
    $("#categoryBox__grandchildbox").empty();
  });

  $("#categoryBox").on("mouseleave",function(){
    $("#categoryBox").css("display", "none");
  });

  $("#categoryAll").on("mouseleave",function(){
    $("#categoryBox").css("display", "none");
  });


}));