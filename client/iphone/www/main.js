var pictureSource; // 写真ソース
var destinationType; // 戻り値のフォーマット
var base64str="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";


// PhoneGapがデバイスと接続するまで待機
function onLoad() {
    document.addEventListener("deviceready", onDeviceReady, false);
    //dbgmsg("plat form name is " + getPlatformName());
}

// PhoneGap準備完了
function onDeviceReady() {
    pictureSource = navigator.camera.PictureSourceType;
    destinationType = navigator.camera.DestinationType;
}

// 写真取得
function capturePhoto() {
    dbgmsg("capturePhoto");	
    navigator.camera.getPicture(onPhotoDataSuccess, onFail, {
        quality: 50
    });
}

// 写真選択
function getPhoto() {
    dbgmsg("getPhoto");	
    navigator.camera.getPicture(onPhotoDataSuccess, onFail, {
        quality: 50,
        sourceType: pictureSource.PHOTOLIBRARY
    });
}

// 写真の撮影に成功した場合
function onPhotoDataSuccess(imageData) {

    // 画像ハンドルを取得
    var smallImage = document.getElementById('smallImage');

    // 画像要素を表示
    smallImage.style.display = 'block';

    // 取得した写真を表示
    // 画像のリサイズにインラインCSSを使用
    smallImage.src = "data:image/jpeg;base64," + imageData;

    //base64の文字列を格納
    base64str = imageData;

    infomsg("写真をサーバに送信してください");
    dbgmsg("Photo Image(base64):" + imageData);

}

// 写真の撮影に失敗した場合
function onFail(mesage) {
    alert('エラーが発生しました: ' + message);
}


function sendPhoto() {
    infomsg("サーバに写真を送信中...");

    var url = "http://fetaro-mjt.fedc.biz/photos";
    var json = "{photo: {base64: \"" + base64str + "\"}}";

    //dbgmsg("<h4>SEND:<\/h4>" + json);

    //リクエスト送信
    $.ajax({
        type: "POST",
        url: url,
        data: json,
        contentType: "application/json",
        success: function (data, textStatus, xhr) {
            infomsg("写真の登録完了(" + data + ")" );
            dbgmsg("<h4>RESPONSE:<\/h4>" + data);
            setImgUrl(data);
            imgload();
        },
        error: function (data) {
            infomsg("写真の登録失敗:" + data.status);
            dbgmsg(data.responseText);
        }
    });

}


function sendData() {
    infomsg("サーバに得点計算リクエストを送信中...")

    var url = "http://fetaro-mjt.fedc.biz/agaris.json";

    //フォームからパラメータ作成
    var param = {
        agari: {}
    };

    $("input:text").each(function () {
        var name = $(this).attr("name");
        param["agari"][name] = $(this).val();
    });
    $("select").each(function () {
        var name = $(this).attr("name");
        var val = $(this).children(":selected").attr("value")
        if (val.match(/^[0-9]+$/)) {
            val = parseInt(val);
        }
        param["agari"][name] = val;
    });
    $("input:checkbox").each(function () {
        var name = $(this).attr("name");
        var val = $(this).attr("checked") == "checked";
        param["agari"][name] = val;
    });
    //dbgmsg(print_r(param));
    //is_parentの計算
    param["agari"]["is_parent"] = param["agari"]["jikaze"] == "ton";

    //JSONに変換 「"」を除く
    var json = toJSON(param);


    dbgmsg("<h4>SEND:<\/h4>" + json);

    //リクエスト送信
    $.ajax({
        type: "POST",
        url: url,
        data: json,
        contentType: "application/json",
        success: function (data, textStatus, xhr) {
            infomsg("得点計算リクエスト正常終了");
            dbgmsg("<h4>RESPONSE:<\/h4>" + toJSON(data));

            $("#resultdiv").html(agariToHtml(data.agari));
        },
        error: function (data) {
            infomsg("得点計算リクエストエラー:" + data.status);
            dbgmsg(data.responseText);
        }
    });

}

function setImgUrl(str) {
    $("#img_url").val(str);
    $("#image").attr('src', str);
}

function imgload() {
    $("#image").attr("src", $('#img_url').val());
}

function infomsg(msg) {
    $("#infodiv").html(msg);
}

function dbgmsg(msg) {
	if (msg.length > 200) {
		msg = msg.substring(0,200) + ".....";
	}
    $("#dbgdiv").append("<hr>" + msg);
}

function agariToHtml(a) {

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
    var html = "<h3>解析結果<\/h3>";

    html += "<p>"
    for (var i = 0; i < 28; i += 2) {
        var paistr = a.tehai_list.slice(i, i + 2);
        if (paistr == "") {
            //解析に失敗したパイがある場合
            paistr = "z0"; //失敗画像のファイル名"z0"を指定
        }
        html += "<img width=17 src=img/" + paistr + ".gif>";
    }

    html += "<\/p>"

    html += "<table>";
    $.each(a.yaku_list, function () {
        html += "<tr><td>" + this.name_kanji + "<\/td><td>" + this.han_num + "飜<\/td><\/tr>";
    });
    html += "<\/table>";

    html += "<p>" + a.total_fu_num + "符　" + manganStr + a.total_han_num + "飜　" + a.total_point + "点<\/p>"

    if (a.is_parent) {
        html += a.child_point + "点　オール"
    } else {
        html += "子" + a.child_point + "点/親" + a.parent_point + "点"
    }
    return html;
};


function getPlatformName() {
    if (typeof android != 'undefined') {
        return "android";
    } else {
        return "pcbrowser";
    }
}

function changeDetailCond(){
	if ( $('#detail_cond').css('display') == 'none' ){;
		$('#detail_cond').css('display', 'inline');
		$('#detail_cond_button').html('▲隠す');
	}else{
		$('#detail_cond').css('display', 'none');		
		$('#detail_cond_button').html('▼その他条件');
	}
}