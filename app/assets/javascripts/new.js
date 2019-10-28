$(document).on('turbolinks:load', function(){
  var imagecontent = $('#img-content');
  var imagecontent2 = $('#img-content2');
  var images = [];
  var imagefield = $('#img-field');
  var preview = $('#preview');
  var preview2 = $('#preview2');

  $(document).on('change', 'input[type="file"]#img-file', function() {
    let file = $(this).prop('files')[0];
    let file_reader = new FileReader();
    let img = $(`<div class= "img_view">
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

    if(images.length >= 5) {
      imagecontent2.css({
        'display': 'block'
      })
      imagecontent.css({
        'display': 'none'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
        imagecontent2.css({
          'width': `calc(100% - (130px * ${images.length - 5}))`
        })
      })
      if (images.length == 4) {

      }
    } else {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        imagecontent.css({
          'width': `calc(100% - (130px * ${images.length}))`
        })
      }
    if(images.length == 10) {
      imagecontent2.css({
        'display': 'none'
      })
      return;
    }
    var new_image = $(`<input multiple= "multiple" name="item[images_attributes][${images.length}][image]" class="upload-image" data-image= ${images.length} type="file" id="img-file">`);
    imagefield.prepend(new_image);
  });
  $(document).on('click', '#delete', function() {
    let target_image = $(this).parent().parent();
    $.each(images, function(){
      if ($(this).data('image') == target_image.data('image')){
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
        if(images.length == 0) {
          $('input[type= "file"]#img-file').attr({
            'data-image': 0
          })
        }
      }
    })
    $('input[type= "file"]#img-file:first').attr({
      'data-image': images.length
    })
    $.each(images, function(index, image) {
      var image = $(this)
      image.attr({
        'data-image': index
      })
      $('input[type= "file"]#img-file:first').after(image)
    })
    if (images.length >= 5) {
      imagecontent2.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
      })
      imagecontent2.css({
        'width': `calc(100% - (130px * ${images.length - 5}))`
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
        'width': `calc(100% - (130px * ${images.length}))`
      })
    }
    if(images.length == 4) {
      imagecontent2.css({
        'display': 'none'
      })
    }
  });
});


