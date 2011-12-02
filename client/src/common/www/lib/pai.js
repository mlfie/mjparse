var PAI_TYPE_EMPTY = "z0";
var PAI_TYPE_REVERSE = "r0";
var PAI_TYPE_LIST = [
    "m1","m2","m3","m4","m5","m6","m7","m8","m9",
    "p1","p2","p3","p4","p5","p6","p7","p8","p9",
    "s1","s2","s3","s4","s5","s6","s7","s8","s9",
    "j1","j2","j3","j4","j5","j6","j7",
    PAI_TYPE_REVERSE,PAI_TYPE_EMPTY];
var PAI_DIRECTION_TOP="t";
var PAI_DIRECTION_LEFT="l";
var PAI_DIRECTION_RIGHT="r";
var PAI_DIRECTION_BOTTOM="b";

var PAI_WIDTH = 23 * 1.3;
var PAI_HEIGHT = 32 * 1.3;

var _paiId=0;
var _paiList=new Array();

var Pai = function(type,direction){

    this.type = type; //牌の種類　"p1" "j2"といった文字列
    this.direction = direction; //牌の向き "t" "b" といった文字列

    //すべての牌のインスタンスに番号を振り配列に入れておく
    this.id = _paiId++;
    _paiList[this.id]=this;

    this.imgJq = function(){
        return this.jq;
    };

    this.toChangeableJq = function(){
        var tmpPaiId=this.id;
        return this.jq.click(function(){_viewSelectPai(tmpPaiId);});
    };

    this.changeType = function(type){
        dbgmsg("Pai.changeType",type);
        this.type=type;
        this.jq.attr('src',this.imgUrl());
    };

    this.changeDirection = function(direction){
        dbgmsg("Pai.changeDirection",direction);
        this.direction=direction;
        if(this.direction == PAI_DIRECTION_BOTTOM ||
           this.direction == PAI_DIRECTION_TOP ){
               this.jq.attr('width',PAI_WIDTH);   
               this.jq.attr('height',PAI_HEIGHT);   
           }else{
               this.jq.attr('width',PAI_HEIGHT);   
               this.jq.attr('height',PAI_WIDTH);   
           }
        this.jq.attr('src',this.imgUrl());
    };

    this.isEmpty = function(){
        return this.type == PAI_TYPE_EMPTY;
    };

    
    this.imgUrl = function(){
        return "img/pai/" + this.type +  this.direction +".gif";
    };

    this.toString = function(){
        return this.type + this.direction;  
    };

    //コンストラクタの続き
    
    this.jq = $("<img/>")
        .attr('type',this.type)
        .attr('direction',this.direction)
        .attr('src',this.imgUrl())
        .hover(
            function(){
                //マウスオーバー時
                $(this).css("border-color","#990000");
            },
            function(){
                //マウスオーバー解除
                $(this).css("border-color","#ffffff");
            }
        );

    this.changeDirection(this.direction);
    
};

/**
 * 牌選択画面を表示する。
 * 牌が選択されたら、引数のselectPaiIdの牌と交換する
 */
var _viewSelectPai = function(selectPaiId){
    var jq = $("<div/>")
        .attr("align","center")
        .attr("id","div_selectpanel")
        .attr("class",'ui-loader  ui-overlay-shadow ui-body-b ui-corner-all')
        .css({
                 display: "block",
                 opacity: 0.9,
                 width: 270,
                 padding: 0,
                 top: window.pageYOffset+300
             });
    jq.append("<h1>牌の向きを変更</h1>");
    jq.append($("<button/>")
              .html("タテ")
              .click(function(){
                         _paiList[selectPaiId].changeDirection(PAI_DIRECTION_TOP);
                         jq.hide();
                     }));
    jq.append($("<button/>")
              .html("ヨコ")
              .click(function(){
                         _paiList[selectPaiId].changeDirection(PAI_DIRECTION_LEFT);
                         jq.hide();
                     }));
    jq.append("<h1>牌の種類を変更</h1>");
    $.each(PAI_TYPE_LIST,function(){
               var imgJq = new Pai(this,PAI_DIRECTION_TOP)
                   .imgJq()
                   .click(
                       function(){
                           _paiList[selectPaiId].changeType($(this).attr("type"));
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
