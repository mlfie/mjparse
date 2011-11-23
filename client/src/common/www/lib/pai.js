var PAI_TYPE_EMPTY = "z0";
var PAI_TYPE_REVERSE = "r0";
var PAI_DIRECTION_TOP="t";
var PAI_DIRECTION_LEFT="l";
var PAI_DIRECTION_RIGHT="r";
var PAI_DIRECTION_BOTTOM="b";

var Pai = function(type,direction){

    this.type = type; //牌の種類　"p1" "j2"といった文字列
    this.direction = direction; //牌の向き "t" "b" といった文字列

    this.imgUrl = function(){
        return "img/pai/" + this.type +  this.direction +".gif";
    };
   

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

    this.imgJq = function(){
        return this.jq;
    };

    this.changeType = function(type){
        dbgmsg("Pai.changeType",type);
        this.type=type;
        this.jq.attr('src',this.imgUrl());
    };

    this.changeDirection = function(direction){
        dbgmsg("Pai.changeDirection",direction);
        this.direction=direction;
        this.jq.attr('src',this.imgUrl());
    };

    this.isEmpty = function(){
        return this.type == PAI_TYPE_EMPTY;
    }

};
