function loadImage(obj, elem)
{
	document.getElementById(elem).innerHTML = '<div><small>↓ 以下の画像を登録します ↓</small></div>';
	for (i = 0; i < obj.files.length; i++) {
		let fileReader = new FileReader();
		//選択したファイルを開いてimgタグ追加
		fileReader.onload = (function (e) {
			document.getElementById(elem).innerHTML += '<img class="img-fluid preview" src="' + e.target.result + '">';
		});
		//画像表示
		fileReader.readAsDataURL(obj.files[i]);
	}
}

//画像が変わった時の処理(1行目)
$('.img_field_member').on('change', function() {
  loadImage(this, 'member-img');
});

$('.img_field_dogs').on('change', function() {
  loadImage(this, 'dog-images');
});

$('.img_field_post').on('change', function() {
  loadImage(this, 'post-img');
});