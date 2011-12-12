var Photo = {};

Photo.NO_IMAGE =  "img/nophoto.jpg";//「手牌画像なし」と書いた画像
Photo.URL = "#img_url";
Photo.IMG_TOP = "#img_top_photo";
Photo.IMG_RESULT = "#img_result_photo";
Photo.IMG_PAIFIX = "#img_result_photo2";
Photo.base64 ="";

Photo.clear = function(){
    $(Photo.URL).val("");
    $(Photo.IMG_TOP).attr("src" , Photo.NO_IMAGE);
    $(Photo.IMG_RESULT).attr("src", Photo.NO_IMAGE);
    $(Photo.IMG_PAIFIX).attr("src", Photo.NO_IMAGE);
    Photo.base64 ="";
};

Photo.setUrlSrc = function(url,thumUrl){
    Msg.debug("Photo.setUrlSrc",url + "," +thumUrl);
    console.log(Photo);
    $(Photo.URL).val(url);
    $(Photo.IMG_TOP).attr("src" , thumUrl);
    $(Photo.IMG_RESULT).attr("src", thumUrl);
    $(Photo.IMG_PAIFIX).attr("src", thumUrl);
};

Photo.setBase64Src = function(base64){
    Msg.debug("Photo.setBase64Src",base64);
    $(Photo.URL).val(""); 
    $(Photo.IMG_TOP).attr("src" , "data:image/jpeg;base64," + base64);
    $(Photo.IMG_RESULT).attr("src",  "data:image/jpeg;base64," + base64);
    $(Photo.IMG_PAIFIX).attr("src",  "data:image/jpeg;base64," + base64);
    Photo.base64 = base64;
};

Photo.setUrl = function(url){
    Msg.debug("Photo.setUrl",url);
    $(Photo.URL).val(url);
};

Photo.getUrl = function(){
    Msg.debug("Photo.getUrl", $(Photo.URL).val());
    return $(Photo.URL).val();
};

Photo.getBase64 = function(){
    return Photo.base64;
};

Photo.isLocalPhoto = function(){
    return $(Photo.URL).val() == "" && Photo.base64 !="";
};

Photo.isEmpty = function(){
    return $(Photo.URL).val() == "" && Photo.base64 =="";
};

Photo.isServerPhoto = function(){
    return $(Photo.URL).val() != "";
};
