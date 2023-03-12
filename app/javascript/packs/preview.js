$(function() {

   // 画像1枚プレビュー
  function readURL(input, img_preview) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        img_preview.attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $(document).on('change', '.img_field', function(){
    readURL(this, $('.img-preview').find('.img_prev'));
  });

  // 複数画像プレビュー
  $(function() {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('.img_prev2').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files);
      }
    }
    $(document).on('change', '.img_field2', function(){
      readURL(this, $('.img-preview').find('.img_prev2'));
    });
  });
  
});