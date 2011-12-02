/** 
 * 定数
 */
//得点計算リクエスト送信先URL
var MJT_AGARI_URL= MJT_FQDN + "/agaris.json";

//得点再計算リクエスト送信先URL
var MJT_AGARI_UPDATE_URL= MJT_FQDN + "/agaris";

//写真取得・登録先URL
var MJT_PHOTO_URL = MJT_FQDN + "/photos.json";

/**
 * 変数
 */
var pictureSource;// 写真ソース
var destinationType;// 戻り値のフォーマット
var photoListDlFlag=false;//サーバから写真をダウンロードしたかどうか

var resData = null;//Ajaxレスポンスデータ

var tehai = null;
var point = null;
var state = null;
var photo = null;
var msg = null;

/**********************************************
 * 共通関数
 **********************************************/


/**
 * ajaxランチャー
 * ajaxの際の、ロード中メッセージ、ログ出力を一元化する
 */
function ajaxRuncher(requestName,type,url,json,func) {
    $.mobile.loadingMessage = requestName + "中...";
    $.mobile.showPageLoadingMsg();

    dbgmsg("ajaxRuncher " + requestName + "リクエスト",
           "type=" + type +"<br>"
           + "url=" + url +"<br>"
           + "contentType=" + "application/json" + "<br>"
           + "data=" + json
          );
    
    $.ajax({
        type: type,
        url: url,
        data: json,
        contentType: "application/json",
        success: func,
        success: function (data, textStatus, xhr) {
            $.mobile.hidePageLoadingMsg();
            dbgmsg("ajaxRuncher " + requestName +  "成功:レスポンス",json2html(eval(data)));
            func(data);
        },
        error: function (data) {
            $.mobile.hidePageLoadingMsg();
            msg.error(requestName + "に失敗しました。:" + data.status , data.responseText);
            dbgmsg("ajaxRuncher " + requestName + "失敗:レスポンス",data.responseText);
        }
    });
}

/**********************************************
 * 初期化
 **********************************************/

/**
 * DOMロード完了
 */
$(document).ready(function(){
                      photo = new Photo();
                      state = new State();
                      msg = new Msg();
                      //アガリ状況初期化
                      state.clearData();
                      state.updateDisplay();
});

/**
 * PhoneGapがデバイスと接続するまで待機
 */
function onLoad() {
    document.addEventListener("deviceready", onDeviceReady, false);
}

/**
 * PhoneGap準備完了
 */
function onDeviceReady() {
    pictureSource = navigator.camera.PictureSourceType;
    destinationType = navigator.camera.DestinationType;
}



/**********************************************
 * 写真撮影/選択
 **********************************************/


/**
 * 写真を撮影
 * 「撮影」ボタン押下時
 */
function btnCapturePhoto() {
    dbgmsg("btnCapturePhoto","start");
    navigator.camera.getPicture(
        cameraSuccess,
        cameraFail,
        {quality: 50}
    );
}

/**
 * 写真をローカルから選択
 * 「選択」ボタン押下時
 */
function btnSelectPhoto() {
    dbgmsg("btnSelectPhoto","start");
    navigator.camera.getPicture(
        cameraSuccess,
        cameraFail,
        {quality: 50, sourceType: 0}
        //{quality: 50, sourceType: 0,targetWidth: 600}
    );
}

/**
 * 写真成功時
 */
function cameraSuccess(imageData){
    dbgmsg("cameraSuccess","Photo Image(base64)=" + imageData);
    photo.setBase64Src(imageData);
}
/**
 * 写真失敗時
 */
function cameraFail(message){
    msg.error("写真撮影失敗",message);
}

/**********************************************
 * サーバから選択
 **********************************************/

/**
 * サーバ上の写真リスト表示
 * 「サーバ」ボタン押下時
 */
function btnShowServerPhotoList() {
    if(photoListDlFlag){
        $.mobile.changePage("#serverselect");
    }else{
        ajaxRuncher("写真リスト取得",
                    "GET",
                    MJT_PHOTO_URL,
                    "",
                    viewPhotoList);
    }
}

/**
 * サーバ上の写真リストのダウンロード成功時
 */
function viewPhotoList(jsdata) {

    photoListDlFlag=true;

    var data = eval(jsdata);
    for(var i=0; i<data.length; i++) {
        //画像のdomを作成
        //altという属性に、ノーマルの画像のURLをセットし
        //srcには、サムネイルの画像のURLをセットする
        var jqImg = $("<img/>")
        .attr("src",data[i].photo.thum_url)
        .attr("alt",data[i].photo.url)
        .css("border-color","#888888")
        .css("border-width","2px")
        .css("border-style","solid")
        .click(
            function(){
                //写真にURLをセットする
                photo.setUrlSrc($(this).attr('alt'),$(this).attr('src'));

                //画面遷移
                $.mobile.changePage( "#index", { reverse: true} );
            }
        );
        //画像を入れるdivのdom作成
        var jqDiv = $("<div/>")
        .css("float","left")
        .html(data[i].photo.created_at.replace("T"," ").replace("+09:00",""))
        .append("<br>")
        .append(jqImg);
        //本体にDOMを追加
        $("#div_photolist").append(jqDiv);
    }//end for

    $.mobile.changePage("#serverselect");

}

/**********************************************
 * アガリ状況
 **********************************************/

/**
 * アガリ状況変更画面表示
 * トップ画面の「変更」ボタン押下時
 */
function btnShowStatusChangePage(){
    $.mobile.changePage("#state");
    state.updateForm();
}

/**
 * 変更確定
 * アガリ状況変更画面の「変更」ボタン押下時
 */
function btnCommitStateChange(){
    state.updateData();
    state.updateDisplay();
    $.mobile.changePage( "#index", { reverse: true} );
}

/**
 * 状況クリア
 * アガリ状況変更画面の「クリア」ボタン押下時
 */
function btnClearState(){
    state.clearData();
    state.updateForm();
    state.updateDisplay();
}

/**********************************************
 * 得点計算
 **********************************************/


/**
 * 得点計算リクエスト送信
 * 「得点計算」ボタン押下時
 */
function btnCalcPoint(){

    if(photo.isEmpty()){
        msg.error("解析対象の写真がありません");
        dbgmsg("btnCalcPoint","img_url is empty");
        return ;
    }else if(photo.isLocalPhoto()){
        //まだ写真をサーバに登録してない場合
        //写真を登録したのちに、得点計算リクエストを送る
        var json = "{photo: {base64: \"" + photo.getBase64() + "\"}}";

        ajaxRuncher("写真をサーバに送信",
                    "POST",
                    MJT_PHOTO_URL,
                    json,
                    function (data){
                        //写真URLセット
                        photo.setUrl(eval(data).photo.url);
                        //得点計算リクエスト送信
                        sendCalcData();
                    });
        
    }else if(photo.isServerPhoto()){
        //すでに写真をサーバに登録している場合は
        //得点計算リクエストを送る
        sendCalcData();
    }else{
        msg.error("写真の状態が不正です");
        return ;
    }
}

/**
 * 得点計算リクエスト送信
 */
function sendCalcData(){
    //アガリ状況をオブジェクトにする
    var obj = state.toObj();
    //オブジェクトにimg_urlを追加
    obj["agari"]["img_url"] = photo.getUrl();
    //JSONに変換 「"」を除く
    var json = toJSON(obj);

    ajaxRuncher("得点計算",
                "POST",
                MJT_AGARI_URL,
                json,
                function (data){
                    //data格納
                    resData = data;
                    
                    //得点表示
                    point = new Point(data.agari);
                    $("#div_point").html(point.toHtml());
                    
                    //画像解析結果表示
                    tehai = new Tehai(data.agari.tehai_list);
                    $("#div_analized_img").html(tehai.toJq());
                    
                    //画面遷移
                    $.mobile.changePage('#result');
                });
}


/**********************************************
 * リトライ
 *********************************************/

/**
 * リトライ得点計算リクエスト送信
 * 「訂正後の手牌で得点計算」ボタン押下時
 */
function btnRetryCalcPoint(){
    //アガリ状況をオブジェクトにする
    var obj = state.toObj();
    //オブジェクトにimg_url,idおよび修正したtehai_listを追加
    obj["agari"]["img_url"] = photo.getUrl();
    obj["agari"]["id"] = resData.agari.id;
    obj["agari"]["tehai_list"] = tehai.toString();
    //JSONに変換 「"」を除く
    var json = toJSON(obj);
    
    //url生成 url = ***/agaris/id.json
    var url = MJT_AGARI_UPDATE_URL + "/" + resData.agari.id + ".json";

    ajaxRuncher("得点再計算",
                "PUT",
                url,
                json,
                function (data){
                    //得点表示
                    point = new Point(data.agari);
                    $("#div_point").html(point.toHtml());
                });
}

/**********************************************
 * 全てクリア
 **********************************************/

/**
 * アガリ写真とアガリ状況を消す
 * 「すべてクリア」ボタン押下時
 */
function btnClearAll(){
    //内部変数初期化
    photoListDlFlag=false;
    //写真初期化
    photo.clear();

    //状況初期化
    state.clearData();
    state.updateDisplay();

    msg.info("クリア完了");
}



/**********************************************
 * テスト・デバッグ用
 **********************************************/
var dbgno=0; //デバッグメッセージの行数
function dbgmsg(tag, msg) {
    $("#content_debug").append(
        $("<p/>")
        .html(dbgno + ". " + tag)
        .append("<button data-role='none' onclick='dbgDetail("+ dbgno + ")'>detail</button>")
        .append(
            $("<div/>")
            .attr("id","div_dbg_detail" + dbgno)
            .html(msg)
            .css("display","none")));
    dbgno++;
}

function dbgDetail(i){
    $("#div_dbg_detail" + i).css("display","block");
}


function btnDummyPhoto(){
    //ダミーの写真（テスト用）
    imageData="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";

    photo.setBase64Src(imageData); 

}

function btnCalcPointDummy(){

    photo.setUrlSrc('http://fetaro-mjt.fedc.biz/img/1.jpg',"http://fetaro-mjt.fedc.biz/img/1.thum.jpg");

    btnCalcPoint();

}