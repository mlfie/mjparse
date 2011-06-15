var pictureSource;   // 写真ソース
var destinationType; // 戻り値のフォーマット

var base64str="";

// PhoneGapがデバイスと接続するまで待機
//
function onLoad() {
  document.addEventListener("deviceready",onDeviceReady,false);
}

// PhoneGap準備完了
//
function onDeviceReady() {
  pictureSource=navigator.camera.PictureSourceType;
  destinationType=navigator.camera.DestinationType;
}

function capturePhoto() {
  // 撮影した写真をBase64形式の文字列として取得する
  navigator.camera.getPicture(onPhotoDataSuccess, onFail, {
    quality: 50
  });
}

function selectPhoto() {
  navigator.camera.getPicture(onPhotoDataSuccess, onFail, {
    quality: 50,
    sourceType: Camera.PictureSourceType.PHOTOLIBRARY
  });
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

function sendPhoto() {
  console.log("start sendding photo...");
  infomsg("start sendding photo...")

  var url = "http://mjt.fedc.biz/agaris";
  var request = createXMLHttpRequest();
  var param = {
    agari: {
      is_tsumo: false,
      is_haitei: false,
      dora_num: 0,
      bakaze: 'ton',
      jikaze: 'nan',
      honba_num: 0,
      is_rinshan: false,
      is_chankan: false,
      reach_num: 0,
      is_ippatsu: false,
      is_tenho: false,
      is_chiho: false,
      is_parent: false,
      tehai_img: base64str
    }
  };
  var json = toJSON(param);

  var httpObj = createXMLHttpRequest();

  httpObj.open("POST", url, false);
  httpObj.setRequestHeader("Content-Type","application/json");
  httpObj.send(json);
  if(httpObj.status == "200") {
    console.log("success to send")
    infomsg("success to send")
  } else {
    console.log("!!! fail to send !!!  error code:" + httpObj.status  );
    infomsg("!!! fail to send !!!  error code:" + httpObj.status )
  }
}

function infomsg(msg) {
  // 画像表示
  var image = document.getElementById('label');
  image.innerHTML = msg;

}