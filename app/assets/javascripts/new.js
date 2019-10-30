$(document).on('turbolinks:load', function(){
  let imagecontent = $('#img-content');
  let imagecontent2 = $('#img-content2');
  let images = [];
  let imagefield = $('#img-field');
  let preview = $('#preview');

  $(document).on('change', 'input[type="file"]#img-file', function() {
    let file = $(this).prop('files')[0];
    let file_reader = new FileReader();
    let img = $(`<div class= "img_view" data-image="${images.length}">
                  <img class="image">
                  <div class="btn_box">
                    <div class="btn_box__edit" id="edit" >編集</div>
                    <div class="btn_box__delete" id="delete" >削除</div>
                  </div>
                </div>`);
    file_reader.onload = function(e) {
      img.find('img').attr({
        src: e.target.result
      })
    }
    file_reader.readAsDataURL(file);
    images.push(img);
    console.log(images);
    if(images.length >= 5) {
      imagecontent2.css({
        'display': 'block'
      })
      imagecontent.css({
        'display': 'none'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
        imagecontent2.css({
          'width': `calc(100% - (124px * ${images.length - 5}))`
        })
      })
    } else {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        imagecontent.css({
          'width': `calc(100% - (124px * ${images.length}))`
        })
      }
    if(images.length == 10) {
      imagecontent2.css({
        'display': 'none'
      })
      return;
    }
    var new_image = $(`<input multiple= "multiple" name="item[images_attributes][${images.length}][image]" class="upload-image${images.length}" data-image= ${images.length} type="file" id="img-file">`);
    imagefield.prepend(new_image);
  });
  $(document).on('click', '#delete', function() {
    let cnt = $('.img_view').length;
    let target_image = $(this).parent().parent();
    $.each(images, function(){
      if ($(this).data('image') == target_image.data('image')){
        $(this).remove();
        let fileimg = $(this).data('image')
        $(".upload-image"+ fileimg).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
      }
    })
    $.each(images, function(index, image) {
      var image = $(this)
      image.attr({
        'data-image': index
      })
      $('input[type= "file"]#img-file:first').after(image)
    })
    if (cnt >= 6) {
      imagecontent2.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      imagecontent2.css({
        'width': `calc(100% - (124px * ${cnt - 6}))`
      })
    } else {
      imagecontent.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      imagecontent.css({
        'width': `calc(100% - (124px * ${cnt - 1 }))`
      })
    }
    if(cnt == 5) {
      imagecontent2.css({
        'display': 'none'
      })
    }
  });

  $(document).on('click', '#delete', function() {
    let target_image = $(this).parent().parent();
    let img_id = target_image.data('id');
    target_image.remove();
    hidden_form = `<input type="hidden", name="[delete_ids][]", value='${img_id}', type="file" >`
    $('.delete_box').append(hidden_form);
  })
});
