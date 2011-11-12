/**
 * 定数
 */
PAI_TYPE_LIST = ["m1","m2","m3","m4","m5","m6","m7","m8","m9","p1","p2","p3","p4","p5","p6","p7","p8","p9","s1","s2","s3","s4","s5","s6","s7","s8","s9","j1","j2","j3","j4","j5","j6","j7","m5-red","p5-red","s5-red"];

//得点計算リクエスト送信先URL
//var  MJT_AGARI_URL= "http://fetaro-mjt.fedc.biz/agaris.json";
var  MJT_AGARI_URL= "http://mjt.fedc.biz/agaris.json";
//var  MJT_AGARI_URL= "http://localhost:8080/agaris.json";

//写真取得・登録先URL
//var MJT_PHOTO_URL = "http://fetaro-mjt.fedc.biz/photos.json";
var MJT_PHOTO_URL = "http://mjt.fedc.biz/photos.json";
//var MJT_PHOTO_URL = "http://localhost:8080/photos.json";


var NO_IMAGE="img/nophoto.jpg";//「手牌画像なし」と書いた画像

//写真タイプ
var PHOTO_TYPE_NONE = "none";//選択なし
var PHOTO_TYPE_BASE64 = "base64";//撮影or選択により、base64で保持している
var PHOTO_TYPE_URL = "url";//urlを指定している

/**
 * 変数
 */
var pictureSource;// 写真ソース
var destinationType;// 戻り値のフォーマット
var photoBase64="";//写真のbase64ストリング
var photoListDlFlag=false;//サーバから写真をダウンロードしたかどうか
var photoType = PHOTO_TYPE_NONE;//写真のタイプ NONE|BASE64|url
var changeTargetPaiIndex = -1;//変更対象の牌のindex

var resData = null;//Ajaxレスポンスデータ

var tehai = null;
var point = null;
var state = null;

var dbgno=0; //デバッグメッセージの行数
var dbgarray = new Array();//デバッグメッセージ格納配列

/**********************************************
 * 共通関数
 **********************************************/

/**
 * DOMロード完了
 */
$(document).ready(function(){
					  state = new State();
                      state.clearData();//アガリ状況初期化
                      state.updateDisplay();//アガリ状況表示初期化
                      makeSelectPanel();
				  });

/**
 * INFOメッセージ
 */
function infomsg(message) {
    $("<div/>")
    .attr("class",'ui-loader ui-overlay-shadow ui-body-b ui-corner-all')
    .css({
        display: "block",
        opacity: 0.9,
        top: window.pageYOffset+300
    })
    .html("<h1>" + message + "<h1>")
    .appendTo("body").delay(500)
    .fadeOut(500, function(){
        $(this).remove();
    });
}

/**
 * エラーメッセージ
 */
function errormsg(message,detail) {
    $("#div_error").html("<p>" + detail +"</p>");

    $("<div/>")
    .attr("id","div_errormsg")
    .attr("class",'ui-loader  ui-overlay-shadow ui-body-b ui-corner-all')
    .css({
        display: "block",
        opacity: 0.9,
        top: window.pageYOffset+100
    })
    .html("<h1>エラー</h1>")
    .append("<p>" + message +"</p>") 
    .append("<button onclick='removeErrorMsg()'>OK</button>")
    .append("<button onclick='removeErrorMsg();$.mobile.changePage(\"#error\")'>詳細</button>")
    .appendTo("body").delay(500);
}

function removeErrorMsg(){
    $("#div_errormsg").fadeOut(500, function(){
        $(this).remove();
    });
}

/**
 * ロード中のメッセージを表示
 */
function showLoadMsg(msg){
    $.mobile.loadingMessage = msg;
    $.mobile.showPageLoadingMsg();
}

/**
 * ロード中のメッセージを消す
 */
function hideLoadMsg(){
    $.mobile.hidePageLoadingMsg();
}


/**
 * アガリ写真とアガリ状況を消す
 */
function clearAll(){
    //内部変数初期化
    photoBase64="";
    photoListDlFlag=false;
    //写真初期化
    photoType = PHOTO_TYPE_NONE;
    $("#img_top_photo").attr("src" , NO_IMAGE);
    $("#img_result_photo").attr("src", NO_IMAGE);
    //状況初期化
    state.clearData();
    state.updateDisplay();

    infomsg("クリア完了");
}


/**********************************************
 * 写真撮影/選択
 **********************************************/

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

/**
 * 写真撮影
 */
function capturePhoto() {
    dbgmsg("capturePhoto","start");
    navigator.camera.getPicture(
        cameraSuccess,
        cameraFail,
        {quality: 50}
    );
}

/**
 * 写真をローカルから選択
 */
function selectPhoto() {
    dbgmsg("selectPhoto","start");
    navigator.camera.getPicture(
        cameraSuccess,
        cameraFail,
        {quality: 50, 
         sourceType: 0,
         targetWidth: 100}
    );
}

/**
 * 写真成功時
 */
function cameraSuccess(imageData){
    dbgmsg("cameraSuccess","Photo Image(base64)=" + imageData);
    //base64の文字列を格納
    photoBase64 = imageData;
    //トップ画像を変更
    $("#img_top_photo").attr("src" , "data:image/jpeg;base64," + imageData);
    //解析結果画面の写真も更新
    $("#img_result_photo").attr("src", "data:image/jpeg;base64," + imageData);

    photoType = PHOTO_TYPE_BASE64;

}
/**
 * 写真失敗時
 */
function cameraFail(message){
    errormsg(message);
}

/**********************************************
 * サーバから選択
 **********************************************/

/**
 * サーバ上の写真リスト表示
 */
function showServerPhotoList() {
    if(photoListDlFlag){
        dbgmsg("dlServerPhoto","photos are already downloaded" );
        $.mobile.changePage("#serverselect");
    }else{
        showLoadMsg("サーバから写真リストを取得中...");
        dbgmsg("dlServerPhoto","REQUEST:" + "GET " + MJT_PHOTO_URL );

        //リクエスト送信
        $.ajax({
            type: "GET",
            url: MJT_PHOTO_URL,
            success: function (data, textStatus, xhr) {
                hideLoadMsg();
                dbgmsg("dlPhoto","RESPONSE=" + json2txt(eval(data)));
                photoListDlFlag=true;
                viewPhotoList(data);
                $.mobile.changePage("#serverselect");
            },
            error: function (data) {
                hideLoadMsg();
                errormsg("写真リスト取得失敗:" + data.status,data.responseText);
                dbgmsg("dlPhoto","RESPONSE=" + data.responseText);
            }
        });
    }
}

/**
 * サーバ上の写真リストのダウンロード成功時
 */
function viewPhotoList(jsdata) {
    var data = eval(jsdata);
    for(var i=0; i<data.length; i++) {
        //画像のdomを作成
        var jqImg = $("<img/>")
        .attr("src",data[i].photo.thum_url)
        .attr("alt",data[i].photo.url)
        .css("border-color","#888888")
        .css("border-width","2px")
        .css("border-style","solid")
        .click(
            function(){//クリック時
                dbgmsg("viewPhotoList","Selected Photo alt=" 
                       + $(this).attr('alt') 
                       + " src=" +$(this).attr('src'));
                $("#img_url").val($(this).attr('alt'));
                //トップ画面の写真を更新
                $("#img_top_photo").attr("src", $(this).attr('src'));
                //解析結果画面の写真も更新
                $("#img_result_photo").attr("src", $(this).attr('src'));

                photoType = PHOTO_TYPE_URL;
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
}

/**********************************************
 * アガリ状況
 **********************************************/
function showChangePage(){
    $.mobile.changePage("#state");
    state.updateForm();
}

/**
 * 変更ボタン押下時
 */
function changeState(){
    state.updateData();
    state.updateDisplay();
    $.mobile.changePage( "#index", { reverse: true} );
}

/**
 * クリアボタン押下時
 */
function clearState(){
    state.clearData();
    state.updateForm();
    state.updateDisplay();
}

/**********************************************
 * 得点計算
 **********************************************/


/**
 * 得点計算ボタン押した場合
 */
function calcPoint(){

    if(photoType == PHOTO_TYPE_BASE64){
        sendPhoto();
    }else if(photoType == PHOTO_TYPE_URL){
        sendCalcData();
    }else{
        errormsg("解析対象の写真がありません");
        dbgmsg("calcPoint","img_url is empty");
        return ;
    }
}

/**
 * 写真をサーバに投稿
 */
function sendPhoto() {
    showLoadMsg("サーバに写真を送信中...");

    var json = "{photo: {base64: \"" + photoBase64 + "\"}}";

    dbgmsg("sendPhoto" , "REQUEST=" +MJT_PHOTO_URL + json);

    //リクエスト送信
    $.ajax({
        type: "POST",
        url: MJT_PHOTO_URL,
        data: json,
        contentType: "application/json",
        success: function (data, textStatus, xhr) {
            dbgmsg("sendPhoto","RESPONSE=" + json2txt(eval(data)));
            $("#img_url").val(eval(data).photo.url);
            photoType=PHOTO_TYPE_URL;
            hideLoadMsg();
            sendCalcData();
        },
        error: function (data) {
            hideLoadMsg();
            errormsg("写真の登録失敗 " + data.status, data.responseText);
            dbgmsg("sendPhoto","RESPONSE=" + data.responseText);
        }
    });
}



/**
 * 得点計算リクエスト送信
 */
function sendCalcData(){
    showLoadMsg("得点計算中...");

    var obj = state.toObj();

    obj["agari"]["img_url"] = $("#img_url").val();

    //JSONに変換 「"」を除く
    var json = toJSON(obj);
    
    dbgmsg("sendCalcData","REQUEST=" + MJT_AGARI_URL  + json);
    //リクエスト送信
    $.ajax(
        {
            type: "POST",
            url: MJT_AGARI_URL,
            data: json,
            contentType: "application/json",
            success: function (data, textStatus, xhr) {
                dbgmsg("sendCalcData","RESPONSE:" + json2txt(eval(data)));

                //data格納
                resData = data;

                //得点表示
                point = new Point(data.agari);
                $("#div_point").html(point.toHtml());

                //画像解析結果表示
                //$("#div_analized_img").html(makePaiImgJq(data.agari.tehai_list));
                tehai = new Tehai(data.agari.tehai_list);
                $("#div_analized_img").html(tehai.toJq());
                
                //ロード中メッセージ除去
                hideLoadMsg();

                //画面遷移
                $.mobile.changePage('#result');
            },
            error: function (data) {
                hideLoadMsg();
                dbgmsg("calcPoint","RESPONSE:" + data.responseText);
                errormsg("得点計算リクエストが失敗しました:" + data.status, data.responseText);
            }
        });
}




/**********************************************
 * 画像解析
 **********************************************/

function makeSelectPanel(paiImgJq) {

    var jq = $("<div/>")
    .attr("id","div_selectpanel")
    .attr("class",'ui-loader  ui-overlay-shadow ui-body-b ui-corner-all')
    .css({
        display: "block",
        opacity: 0.9,
        top: window.pageYOffset+100
    })
    .html("<h1>牌を選んでください</h1>");

    $.each(PAI_TYPE_LIST,function(){
               var imgJq = new Pai(this,"top")
                   .imgJq()
                   .click(
                       function(){
                           dbgmsg("makeSelectPanel","selected pai=" + $(this).attr("type"));
                           //外部変数changeTargetPaiIndexに変更対象の牌が入っている
                           tehai.changePai(changeTargetPaiIndex,$(this).attr("type"));
                           jq.hide();
                       });

               jq.append(imgJq);
           });

    jq.appendTo("body").hide();

}

/**********************************************
 * リトライ
 *********************************************/

/**
 * リトライ得点計算リクエスト送信
 */
function sendRetry(){
    showLoadMsg("得点計算中...");

    var obj = state.toObj();

    obj["agari"]["img_url"] = $("#img_url").val();
    obj["agari"]["id"] = redData.agari.id;
    obj["agari"]["tehai_list"] = tehai.toString();

    //JSONに変換 「"」を除く
    var json = toJSON(obj);
    
    dbgmsg("sendRetry","REQUEST=" + MJT_AGARI_URL  + json);
    //リクエスト送信
    $.ajax(
        {
            type: "PUT",
            url: MJT_AGARI_URL,
            data: json,
            contentType: "application/json",
            success: function (data, textStatus, xhr) {
                dbgmsg("sendRetry","RESPONSE:" + json2txt(eval(data)));
                //得点表示
                point = new Point(data.agari);
                $("#div_point").html(point.toHtml());
                //ロード中メッセージ除去
                hideLoadMsg();
            },
            error: function (data) {
                hideLoadMsg();
                dbgmsg("sendRetry","RESPONSE:" + data.responseText);
                errormsg("得点計算リクエストが失敗しました:" + data.status, data.responseText);
            }
        });
}



/**********************************************
 * テスト・デバッグ用
 **********************************************/


function dbgmsg(tag, msg) {
    if (msg.length > 1000) {
        printmsg = msg.substring(0,1000)
            + "<button data-role='none' onclick='dbgDetail("+ dbgno + ")'>(メッセージ全文)</button>";
    }else{
        printmsg=msg;
    }
    $("#content_debug").append("<b>" + dbgno + "." + tag + "</b><p>" + printmsg +"</p>");
    dbgarray[dbgno]=msg;
    dbgno++;
}

function dbgDetail(i){
    alert(dbgarray[i]);
}


function dummyPhoto(){
    //ダミーの写真（テスト用）
    imageData="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";

    dbgmsg("dummyPhoto","Photo Image(base64)=" + imageData);
    photoBase64 = imageData;
    $("#img_top_photo").attr("src" , "data:image/jpeg;base64," + imageData);
    $("#img_result_photo").attr("src", "data:image/jpeg;base64," + imageData);

    photoType = PHOTO_TYPE_BASE64;
}

function calcPointDummy(){
    $("#img_url").val($(this).attr('http://fetaro-mjt.fedc.biz/img/1.jpg'));
    $("#img_top_photo").attr("src", "http://fetaro-mjt.fedc.biz/img/1.thum.jpg");
    $("#img_result_photo").attr("src", "http://fetaro-mjt.fedc.biz/img/1.thum.jpg");
    photoType=PHOTO_TYPE_URL;
    calcPoint();
}