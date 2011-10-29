/*定数*/

//得点計算リクエスト送信先URL
var  MJT_AGARI_URL= "http://fetaro-mjt.fedc.biz/agaris.json";
//var  MJT_AGARI_URL= "http://fetaro-mjt.fedc.biz/dummy/agaris.json";
//var  MJT_AGARI_URL= "http://mjt.fedc.biz/agaris.json";
//var  MJT_AGARI_URL= "http://localhost:8080/agaris.json";

//写真取得・登録先URL
var MJT_PHOTO_URL = "http://fetaro-mjt.fedc.biz/photos.json";
//var MJT_PHOTO_URL = "http://mjt.fedc.biz/photos.json";
//var MJT_PHOTO_URL = "http://localhost:8080/photos.json";

var PAI_LIST = ["m1","m2","m3","m4","m5","m6","m7","m8","m9","p1","p2","p3","p4","p5","p6","p7","p8","p9","s1","s2","s3","s4","s5","s6","s7","s8","s9","j1","j2","j3","j4","j5","j6","j7","m5-red","p5-red","s5-red"];


/*変数*/

var pictureSource; // 写真ソース
var destinationType; // 戻り値のフォーマット
var base64str="";//写真のbase64ストリング
var dlPhotoData="";//ダウンロードした写真リスト
var dbgno=0; //デバッグメッセージの行数
var dbgarray = new Array();//デバッグメッセージ格納配列

/**********************************************
 * 共通関数
 **********************************************/


/**
 * DOMロード完了
 */ 
$(document).ready(function(){
                      updateStateStr();
                  });


function setImgUrl(str) {
    dbgmsg('setImgUrl',str);
    $("#img_url").val(str);
}

function setImg(str) {
    dbgmsg('setImg',str);
    $("#image").attr("src", str);
    $("#div_photo_img").attr("src", str);
}

function infomsg(message) {    
    $("<div/>")
        .attr("class",'ui-loader ui-overlay-shadow ui-body-b ui-corner-all')
        .css({
                 display: "block",
                 opacity: 0.9,
                 top: window.pageYOffset+100
             })
        .html("<h1>" + message + "<h1>")
        .appendTo("body").delay(800)
        .fadeOut(2000, function(){
                     $(this).remove();
                 });
}

function errmsg(message) {    
    $("<div/>")
        .attr("class",'ui-loader  ui-overlay-shadow ui-body-b ui-corner-all')
        .css({
                 display: "block",
                 opacity: 0.8,
                 top: window.pageYOffset+100
             })
        .html("<h1>エラー</h1>" + message)
        .appendTo("body").delay(800)
        .fadeOut(2000, function(){
                     $(this).remove();
                 })
        .click(function(){
                   $(this).remove();
               });
}

function showLoadMsg(msg){
    $.mobile.loadingMessage = msg;
    $.mobile.showPageLoadingMsg();
}

function hideLoadMsg(){
    $.mobile.hidePageLoadingMsg();
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
 * 写真取得
 */ 
function capturePhoto() {
    dbgmsg("capturePhoto", "start");
    navigator.camera.getPicture(onPhotoDataSuccess, onFail, {
                                    quality: 50
                                });
}

/**
 * 写真選択
 */ 
function selectPhoto() {
    dbgmsg("getPhoto", "start");
    navigator.camera.getPicture(onPhotoDataSuccess, onFail, {
                                    quality: 50,
                                    sourceType: pictureSource.PHOTOLIBRARY
                                });
}

/**
 * 写真の撮影/取得に成功した場合
 */ 
function onPhotoDataSuccess(imageData) {
    dbgmsg("onPhotoDataSuccess", "start");

    // 画像ハンドルを取得
    var image = document.getElementById('confirm');

    // 画像要素を表示
    image.style.display = 'block';

    // 取得した写真を表示
    // 画像のリサイズにインラインCSSを使用
    image.src = "data:image/jpeg;base64," + imageData;

    //base64の文字列を格納
    base64str = imageData;
    dbgmsg("onPhotoDataSuccess","Photo Image(base64)=" + imageData);

    changePanel('confirm');
    infomsg("この写真でよろしいですか？");

}

/**
 * 写真の撮影に失敗した場合
 */
function onFail(mesage) {
    errormsg('写真の撮影に失敗しました: ' + message);
}

/**
 * 写真をサーバに投稿
 */
function sendPhoto() {
    infomsg("サーバに写真を送信中...");

    var json = "{photo: {base64: \"" + base64str + "\"}}";

    dbgmsg("sendPhoto" , "REQUEST=" +MJT_PHOTO_URL + json);

    //リクエスト送信
    $.ajax({
               type: "POST",
               url: MJT_PHOTO_URL,
               data: json,
               contentType: "application/json",
               success: function (data, textStatus, xhr) {
                   infomsg("写真の登録完了" );
                   dbgmsg("sendPhoto","RESPONSE=" + json2txt(eval(data)));
                   setImgUrl(eval(data).photo.url);
                   setImg(eval(data).photo.thum_url);
                   changePanel('top');
                   //送信ボタンを活性化
                   $('#btn_send').removeAttr('disabled');
                   
               },
               error: function (data) {
                   infomsg("写真の登録失敗 " + data.status);
                   dbgmsg("sendPhoto","RESPONSE=" + data.responseText);
               }
           });

}


/**********************************************
 * サーバから選択
 **********************************************/

/**
 * サーバ上の写真リスト表示
 */
function showServerPhotoList() {
    if(dlPhotoData != ""){
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
                       dlPhotoData=data;
                       viewPhotoList(data);

                       $.mobile.changePage("#serverselect");

                   },
                   error: function (data) {
                       errormsg("写真リスト取得失敗:" + data.status);
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
        var jqImg = $("<img/>")
            .attr("src",data[i].photo.thum_url)
            .attr("alt",data[i].photo.url)
            .css("border-color","#888888")
            .css("border-width","2px")
            .css("border-style","solid")        
            .click(
                function(){
                    //クリック時
                    dbgmsg("viewPhotoList","Selected Photo alt=" + $(this).attr('alt') 
                           + " src=" +$(this).attr('src'));
                    setImgUrl($(this).attr('alt'));
                    setImg($(this).attr('src'));
                    $.mobile.changePage("index");
                }
            );

        var jqDiv = $("<div/>")
            .css("float","left")
            .html(data[i].photo.created_at.replace("T"," ").replace("+09:00",""))
            .append("<br>")
            .append(jqImg);
        $("#div_photolist").append(jqDiv);
        
    }//end for
}

/**********************************************
 * 状況変更
 **********************************************/

function changeState(){
    updateStateStr();
    $.mobile.changePage('#index','pop');
}

/**
 * アガリ状況文字列更新
 */
function updateStateStr(){

    var japanese= {
        "is_reach": "リーチ",
        "is_2reach": "ダブリー",
        "is_ippatsu": "一発",
        "is_haitei": "海底",
        "is_rinshan": "嶺上",
        "is_chankan": "槍槓",
        "is_tenho": "天和",
        "is_chiho": "地和",
        "ton": "東",
        "nan": "南",
        "sha": "西",
        "pei": "北"
    };


    var tmpArray = new Array();
    tmpArray.push( japanese[$("#bakaze").val()] +"場" + $("#honba_num").val() + "本場");
    tmpArray.push( "自風" + japanese[$("#jikaze").val()]) ;
    tmpArray.push( "ドラ" + $("#dora_num").val()) ;
    if ( $("#is_tsumo").val() == "true"){
        tmpArray.push("ツモ");
    }else{
        tmpArray.push("ロン");
    }
    $("input:checkbox").each( 
        function () {
            if ( $(this).attr("checked") == "checked" ){
                tmpArray.push(japanese[$(this).attr("name")]);
            }
        });
    var str="";
    var dstr="";
    $.each(tmpArray,function() {
               dstr += this + ",";
               str += "<div style='float:left;margin: 2px; padding: 1px; border: 1px dotted gray;'>" 
                   + this
                   + "</div>";
           });
    dbgmsg("updateStateStr",dstr);
    str += "<div style='clear:left'></div>";
    $("#div_state_str").html(str);
}


/**********************************************
 * 得点計算
 **********************************************/


/**
 * 得点計算リクエスト送信
 */
function calcPoint(){

    if($("#img_url").val() == "" ){
        errmsg("解析対象の写真が選択されていません");
        dbgmsg("calcPoint","img_url is empty");
        return ;
    }

    showLoadMsg("得点計算中...");

    //フォームからパラメータ作成
    var param = {
        agari: {}
    };

    param["agari"]["bakaze"] = $("#bakaze").val();
    param["agari"]["jikaze"] = $("#jikaze").val();
    param["agari"]["honba_num"] = parseInt($("#honba_num").val());
    param["agari"]["dora_num"] = parseInt($("#dora_num").val());
    param["agari"]["is_tsumo"]= $("#is_tsumo").val() == "true";

    $("input:checkbox").each( 
        function () {
            var name = $(this).attr("name");
            var val = $(this).attr("checked") == "checked";
            param["agari"][name] = val;
        });

    //is_parentの計算
    param["agari"]["is_parent"] = param["agari"]["jikaze"] == "ton";
    
    
    //リーチのフォーマット変換 is_reach -> reach_num
    var rnum;
    if(param["agari"]["is_reach"]){
        rnum=1;
    }else{
        rnum=0;
    }
    param["agari"]["reach_num"] =rnum;
    delete param["agari"]["is_reach"] ;

    //JSONに変換 「"」を除く
    var json = toJSON(param);
    
    dbgmsg("calcPoint","REQUEST=" + MJT_AGARI_URL  + json);
    //リクエスト送信
    $.ajax(
        {
            type: "POST",
            url: MJT_AGARI_URL,
            data: json,
            contentType: "application/json",
            success: function (data, textStatus, xhr) {
                dbgmsg("calcPoint","RESPONSE:" + json2txt(eval(data)));

                //ロード中メッセージ除去
                hideLoadMsg();

                //アガリ結果表示
                $("#div_analized_img").html(agariToAnalizedImgHtml(data.agari));
                //$("#div_analized_img").html(agariToEditableImgJq(data.agari));
                $("#div_point").html(agariToPointHtml(data.agari));
                
                //画面遷移
                $.mobile.changePage('#result');
            },
            error: function (data) {
                $.mobile.hidePageLoadingMsg();
                dbgmsg("calcPoint","RESPONSE:" + data.responseText);
                errormsg("得点計算リクエストが失敗しました:" + data.status);
            }
        });
}

function agariToAnalizedImgHtml(agari) {

    //HTML生成
    var html = "";


    for (var i = 0; i < 28; i += 2) {
        
        var paistr = agari.tehai_list.slice(i, i + 2);
        if (paistr == "") {
            
            //解析に失敗したパイがある場合
            paistr = "z0"; //失敗画像のファイル名"z0"を指定
        }
        html += "<img width=17 src=img/pai/" + paistr + "-top.gif>";
    }
    
    return html;
}


function agariToPointHtml(a) {

    var manganStr = "";
    switch (a.mangan_scale) {
    case 0:
        manganStr = "";
        break;
    case 1:
        manganStr = "満貫 ";
        break;
    case 1.5:
        manganStr = "跳満 ";
        break;
    case 2:
        manganStr = "倍満 ";
        break;
    case 3:
        manganStr = "三倍満 ";
        break;
    case 4:
        manganStr = "役満 ";
        break;
    case 8:
        manganStr = "ダブル役満 ";
        break;
    case 12:
        manganStr = "トリプル役満 ";
        break;
    case 16:
        manganStr = "四倍役満 ";
        break;
    }

    //HTML生成
    var html = "";

    html += "<table>";
    $.each(a.yaku_list, function () {
               html += "<tr><td>" + this.name_kanji + "<\/td><td>" + this.han_num + "飜<\/td><\/tr>";
           });
    html += "<\/table>";

    html += "<p>" + a.total_fu_num + "符　" + manganStr + a.total_han_num + "飜　" + a.total_point + "点<\/p>";

    if (a.is_parent) {
        html += a.child_point + "点　オール";
    } else {
        html += "子" + a.child_point + "点/親" + a.parent_point + "点";
    }
    return html;
};


/**********************************************
 * 画像解析結果編集
 **********************************************/

function agariToEditableImgJq(a) {

    //HTML生成
    var jqSpan = $("<span/>");
    var i=0;
    $.each(a.tehai_list, function () {
               var jqImg = $("<img/>")
                   .attr("id","pai" + i)
                   .attr("src","img/pai/" + this.type + "-" + this.direction + ".gif")
                   .attr("alt",this.type + "-" + this.direction)
               
                   .css("zoom","0.7")
                   .click(
                       function(){
                           //クリック時
                           dbgmsg("viewPhotoList","Selected Pai = "
                                  + $(this).attr('id') + ":"
                                  + $(this).attr('alt')
                                 );
                           createPaiSelectDiv($(this));
                           changePanel('selectpai');
                       }
                   );
               
               i++;
               jqSpan.append(jqImg);

           });//endeach
    jqSpan.append("<br><font size=-3>牌をタッチすると解析結果を修正できます</font>");
    return jqSpan;
}

function createPaiSelectDiv(jq){
    $("#div_selectpai").html("");
    $.each(PAI_LIST, function () {
               dbgmsg("createPaiSelectDiv","add pai " + this);
               var jqImg = $("<img/>")
                   .attr("src","img/pai/" + this + "-top.gif")
                   .attr("alt",this)
                   .css("border-width","1px")
                   .css("border-style","solid")     
                   .css("border-color","#ffffff")       
                   .hover(
                       function(){
                           //マウスオーバー時
                           $(this).css("border-color","#990000");
                       },
                       function(){
                           //マウスオーバー解除
                           $(this).css("border-color","#ffffff");
                       }
                   )
                   .click(
                       function(){
                           //クリック時
                           dbgmsg("viewPhotoList","Selected Pai = "
                                  + $(this).attr('alt')
                                 );
                           //引数のjqueryオブジェクトにパイをセット
                           jq.attr("src",$(this).attr('src'));
                           changePanel("top");
                       }
                   );

               $("#div_selectpai").append(jqImg);
           });//end each
}





/**********************************************
 * テスト・デバッグ用
 **********************************************/


function dbgmsg(tag, msg) {
    if (msg.length > 1000) {
        printmsg = msg.substring(0,1000)
            + "<button class=small onclick='dbgDetail("+ dbgno + ")'>(メッセージ全文)</button>";
    }else{
        printmsg=msg;
    }
    $("#content_debug").append("<b>" + dbgno + "." + tag + "</b><pre>" + printmsg +"</pre>");
    dbgarray[dbgno]=msg;
    dbgno++;
}

function dbgDetail(i){
    alert(dbgarray[i]);
}


function sendPhotoDummy(){
    //ダミーの写真（テスト用）
    var base64str="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";


    showLoadMsg("サーバに写真を送信中...");

    var json = "{photo: {base64: \"" + base64str + "\"}}";

    dbgmsg("sendDymmy" , "REQUEST: " +MJT_PHOTO_URL + json2txt(eval(json)));

    //リクエスト送信
    $.ajax({
               type: "POST",
               url: MJT_PHOTO_URL,
               data: json,
               contentType: "application/json",
               success: function (data, textStatus, xhr) {
                   dbgmsg("sendDymmy" , "RESPONSE: " + json2txt(eval(data)));
                   setImgUrl(eval(data).photo.url);
                   setImg(eval(data).photo.thum_url);
               },
               error: function (data) {
                   errormsg("写真の登録失敗 " + data.status);
                   dbgmsg("sendDymmy" , "RESPONSE: " + data.responseText);
               }
           });


}

function calcPointDummy(){
    setImgUrl("http://fetaro-mjt.fedc.biz/img/1.jpg");
    setImg("http://fetaro-mjt.fedc.biz/img/1.thum.jpg");
    calcPoint();
}