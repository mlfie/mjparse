
var Tehai = {
    PAI_ZOOM: 1.6,
    paiList: null,
    jq: $("<div/>"),
    chJq: $("<div/>")
};

Tehai.setTehaiList = function(tehaiListStr) {

    dbgmsg("Tehai.setTehaiList" , tehaiListStr);

    //変数初期化
    Tehai.paiList = new Array();

    //paiList作成
    for (var i = 0;  i < tehaiListStr.length ; i += 3) {
        //3文字ごとに分ける ex)"s6ts7ts8l"
        var paiTypeStr = tehaiListStr.slice(i, i + 2);
        var paiDirectionStr = tehaiListStr.slice(i + 2, i + 3);
        Tehai.paiList.push(new Pai(paiTypeStr,paiDirectionStr));
    }

    Tehai.updateView();

};

Tehai.updateView = function(){

    Tehai.jq.html("");
    Tehai.chJq.html("");
    
    //JQ作成
    for(i=0; i<Tehai.paiList.length; i++){
        Tehai.jq.append(Tehai.paiList[i].jq().clone());
    };
    
    //編集可能JQ作成
    for(i=0; i<Tehai.paiList.length + 1 ; i++){

        if(i<Tehai.paiList.length){
            var pai=Tehai.paiList[i].jq(Tehai.PAI_ZOOM)
                .click(function (index){
                           return function(){
                               Tehai.viewChangePai(index);    
                           };
                       }(i));
            
        }else{
            var pai=new Pai("z0","t").jq(Tehai.PAI_ZOOM);
        }
        var arrow = $("<img/>")
            .attr("src","img/insert.gif")
            .css("width",35)
            .css("height",35)
            .click(function (index){
                           return function(){
                               Tehai.viewInsertPai(index);    
                            };
                        }(i));

        Tehai.chJq.append(
            $("<span/>").css("float","left").html(
                $("<table/>")
                    .append($("<tr/>").append($("<td/>").css("height",Pai.HEIGHT * Tehai.PAI_ZOOM + 7).html(pai)))
                    .append($("<tr/>").append($("<td/>").html(arrow))
                )
            )
        );

    }
};


Tehai.insertPai = function(index,pai){
    var tmp = Tehai.paiList.slice(0,index);
    tmp.push(pai);
    Tehai.paiList = tmp.concat(Tehai.paiList.slice(index));
    Tehai.updateView();
};

Tehai.deletePai = function(index){
    var tmp = Tehai.paiList.slice(0,index);
    Tehai.paiList = tmp.concat(Tehai.paiList.slice(index+1));
    Tehai.updateView();
};


Tehai.toString = function(){
    var str = "";
    $.each(Tehai.paiList,function(){
               if(! this.isEmpty()){
                   str += this.toString();
               }
           });
    return str;
};


Tehai.viewInsertPai = function(index){

    var jq = $("<div/>")
        .attr("align","center")
        .attr("id","div_selectpanel")
        .attr("class",'ui-loader  ui-overlay-shadow ui-body-b ui-corner-all')
        .css({
                 display: "block",
                 opacity: 0.9,
                 width: 270,
                 padding: 0,
                 top: window.pageYOffset+100
             });
    jq.append("<h1>牌を選択</h1>");
    $.each(Pai.TYPE_LIST,function(){
               var imgJq = new Pai(this,Pai.DIRECTION_TOP).jq(Tehai.PAI_ZOOM)
                   .click(
                       function(){
                           Tehai.insertPai(index,new Pai($(this).attr("type"),"t"));
                           jq.hide();
                       });
               jq.append(imgJq);
           });
    jq.append("<br>");
    jq.append($("<p/>").html($("<button/>")
                             .html("キャンセル")
                             .click(function(){jq.hide();})));
    jq.appendTo("body");
};



Tehai.viewChangePai = function(index){

    var jq = $("<div/>")
        .attr("align","center")
        .attr("id","div_selectpanel")
        .attr("class",'ui-loader  ui-overlay-shadow ui-body-b ui-corner-all')
        .css({
                 display: "block",
                 opacity: 0.9,
                 width: 270,
                 padding: 0,
                 top: window.pageYOffset+100
             });

    jq.append("<h1>牌の向きを変更</h1>");
    jq.append($("<button/>")
              .html("タテ")
              .click(function(){
                         Tehai.paiList[index].direction=Pai.DIRECTION_TOP;
                         Tehai.updateView();
                         jq.hide();
                     }));
    jq.append($("<button/>")
              .html("ヨコ")
              .click(function(){
                         Tehai.paiList[index].direction=Pai.DIRECTION_LEFT;
                         Tehai.updateView();
                         jq.hide();
                     }));
    jq.append("<h1>牌の種類を変更</h1>");
    $.each(Pai.TYPE_LIST,function(){
               var imgJq = new Pai(this,Pai.DIRECTION_TOP).jq(Tehai.PAI_ZOOM)
                   .click(
                       function(){
                           Tehai.paiList[index].type = $(this).attr("type");
                           Tehai.updateView();
                           jq.hide();
                       });
               jq.append(imgJq);
           });
    jq.append("<br/>");
    jq.append($("<button/>")
              .html("削除")
              .click(function(){
                         Tehai.deletePai(index);
                         jq.hide();
                     }));
    jq.append($("<p/>").html($("<button/>")
                             .html("キャンセル")
                             .click(function(){jq.hide();})));
    jq.appendTo("body");
};

