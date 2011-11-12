var Photo = function(){
    var NO_IMAGE="img/nophoto.jpg";//「手牌画像なし」と書いた画像

    //写真タイプ
    var TYPE_NONE = "none";//選択なし
    var TYPE_BASE64 = "base64";//撮影or選択により、base64で保持している
    var TYPE_URL = "url";//urlを指定している

    this.type = Photo.TYPE_NONE

    this.clear = function(){
        this.type=TYPE_NONE
        $("#img_url").val("");
        $("#img_top_photo").attr("src" , NO_IMAGE);
        $("#img_result_photo").attr("src", NO_IMAGE);
    };

    this.setUrlSrc = function(url,thumUrl,){
        this.type=TYPE_URL
        $("#img_url").val(url);
        $("#img_top_photo").attr("src" , thumUrl);
        $("#img_result_photo").attr("src", thumUrl);
    };

    this.setBase64Src = function(base64){
        this.type=TYPE_BASE64
        $("#img_top_photo").attr("src" , "data:image/jpeg;base64," + base64);
        $("#img_result_photo").attr("src",  "data:image/jpeg;base64," + base64);
    };

};