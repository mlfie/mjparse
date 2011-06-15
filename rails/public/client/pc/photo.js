var pictureSource;   // 写真ソース
var destinationType; // 戻り値のフォーマット

var base64str="";

// PhoneGapがデバイスと接続するまで待機
//
function onLoad() {
}

// PhoneGap準備完了
//
function onDeviceReady() {
}

function capturePhoto() {
  window.open('pc/take_photo.html','a','width=300,menubar=no,toolbar=no'); 
}

function selectPhoto() {
  window.open('pc/take_photo.html','a','width=300,menubar=no,toolbar=no'); 
}

// 写真の撮影に失敗した場合
function onFail(mesage) {
  alert('エラーが発生しました: ' + message);
}

// 写真の撮影に成功した場合
function onPhotoDataSuccess(imageData) {
  // 下記のコメントを外すことでBase64形式のデータをログに出力
  //console.log(imageData);
  console.log("scucess to take a photo. Let's send");
  infomsg("scucess to take a photo. Let's send")

  base64str = imageData;

  // 画像表示
  var smallImage = document.getElementById('image');
  smallImage.style.display = 'block';
  smallImage.src = "data:image/jpeg;base64," + imageData;

}