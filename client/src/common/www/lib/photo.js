var Photo = function(){
    var NO_IMAGE="img/nophoto.jpg";//「手牌画像なし」と書いた画像
    var IMG_URL = "#img_url";
    
    this.jqImgUrl = $("#img_url");
    this.jqTopPhoto = $("#img_top_photo");
    this.jqResultPhoto = $("#img_result_photo");
    this.base64 ="";

    this.clear = function(){
        this.jqImgUrl.val("");
        this.jqTopPhoto.attr("src" , NO_IMAGE);
        this.jqResultPhoto.attr("src", NO_IMAGE);
        this.base64 ="";
    };

    this.setUrlSrc = function(url,thumUrl){
        dbgmsg("Photo.setUrlSrc",url + "," +thumUrl);
        this.jqImgUrl.val(url);
        this.jqTopPhoto.attr("src" , thumUrl);
        this.jqResultPhoto.attr("src", thumUrl);
    };

    this.setBase64Src = function(base64){
        dbgmsg("Photo.setBase64Src",base64);
        this.jqImgUrl.val(""); 
        this.jqTopPhoto.attr("src" , "data:image/jpeg;base64," + base64);
        this.jqResultPhoto.attr("src",  "data:image/jpeg;base64," + base64);
        this.base64 = base64;
    };

    this.setUrl = function(url){
        dbgmsg("Photo.setUrl",url);
        this.jqImgUrl.val(url);
    };

    this.getUrl = function(){
        dbgmsg("Photo.getUrl", this.jqImgUrl.val());
        return this.jqImgUrl.val();
    };

    this.getBase64 = function(){
        return this.base64;
    };

    this.isLocalPhoto = function(){
        return this.jqImgUrl.val() == "" && this.base64 !="";
    };

    this.isEmpty = function(){
        return this.jqImgUrl.val() == "" && this.base64 =="";
    };

    this.isServerPhoto = function(){
        return this.jqImgUrl.val() != "";
    };
};