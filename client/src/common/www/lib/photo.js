var Photo = function(){
    var NO_IMAGE="img/nophoto.jpg";//「手牌画像なし」と書いた画像
    var IMG_URL = "#img_url";
    
    this.imgUrl = $("#img_url");
    this.topPhoto = $("#img_top_photo");
    this.resultPhoto = $("#img_result_photo");
    this.base64 ="";

    this.clear = function(){
        this.imgUrl.val("");
        this.topPhoto.attr("src" , NO_IMAGE);
        this.resultPhoto.attr("src", NO_IMAGE);
        this.base64 ="";
    };

    this.setUrlSrc = function(url,thumUrl){
        dbgmsg("Photo.setUrlSrc",url + "," +thumUrl);
        this.imgUrl.val(url);
        this.topPhoto.attr("src" , thumUrl);
        this.resultPhoto.attr("src", thumUrl);
    };

    this.setBase64Src = function(base64){
        dbgmsg("Photo.setBase64Src",base64);
        this.imgUrl.val(""); 
        this.topPhoto.attr("src" , "data:image/jpeg;base64," + base64);
        this.resultPhoto.attr("src",  "data:image/jpeg;base64," + base64);
        this.base64 = base64;
    };

    this.setUrl = function(url){
        dbgmsg("Photo.setUrl",url);
        this.imgUrl.val(url);
    };

    this.getUrl = function(){
        dbgmsg("Photo.getUrl", this.imgUrl.val());
        return this.imgUrl.val();
    };

    this.getBase64 = function(){
        return this.base64;
    };

    this.isLocalPhoto = function(){
        return this.imgUrl.val() == "" && this.base64 !="";
    };

    this.isEmpty = function(){
        return this.imgUrl.val() == "" && this.base64 =="";
    };

    this.isServerPhoto = function(){
        return this.imgUrl.val() != "";
    };
};