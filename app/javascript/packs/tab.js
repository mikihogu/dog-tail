// $('.tab-menu[id != "tab1"]').hide();

// $('.tab-menu a').on('click', function(event) {
//   $(".tab-area").hide();
//   $(".tab-menu .active").removeClass("active");
//   $(this).addClass("active");
//   $($(this).attr("href")).show();
//   event.preventDefault();
// });

//任意のタブにURLからリンクするための設定
// function getHashID (hashIDName){
// 	if(hashIDName){
// 		//タブ設定
// 		$('.tab-menu li').find('a').each(function() { //タブ内のaタグ全てを取得
// 			let idName = $(this).attr('href'); //タブ内のaタグのリンク名（例）#lunchの値を取得	
// 			if(idName == hashIDName){ //リンク元の指定されたURLのハッシュタグ（例）http://example.com/#lunch←この#の値とタブ内のリンク名（例）#lunchが同じかをチェック
// 				let parentElm = $(this).parent(); //タブ内のaタグの親要素（li）を取得
// 				$('.tab-menu li').removeClass("active"); //タブ内のliについているactiveクラスを取り除き
// 				$(parentElm).addClass("active"); //リンク元の指定されたURLのハッシュタグとタブ内のリンク名が同じであれば、liにactiveクラスを追加
// 				//表示させるエリア設定
// 				$(".tab-area").removeClass("is-active"); //もともとついているis-activeクラスを取り除き
// 				$(hashIDName).addClass("is-active"); //表示させたいエリアのタブリンク名をクリックしたら、表示エリアにis-activeクラスを追加	
// 			}
// 		});
// 	}
// }

//タブをクリックしたら
$('.tab-menu a').on('click', function(event) {
	let idName = $(this).attr('href'); //タブ内のリンク名を取得	
	getHashID (idName);//設定したタブの読み込みと
	return false;//aタグを無効にする
});


// 上記の動きをページが読み込まれたらすぐに動かす
$(window).on('load', function () {
    $('.tab-menu li:first-of-type').addClass("active"); //最初のliにactiveクラスを追加
    $('.tab-area:first-of-type').addClass("is-active"); //最初の.tab-areaにis-activeクラスを追加
	var hashName = location.hash; //リンク元の指定されたURLのハッシュタグを取得
	// getHashID (hashName);//設定したタブの読み込み
});