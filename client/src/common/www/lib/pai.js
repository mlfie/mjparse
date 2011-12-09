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

var Pai = function(type,direction){

    this.type = type; //牌の種類　"p1" "j2"といった文字列
    this.direction = direction; //牌の向き "t" "b" といった文字列

    this.jq = function(){
        return $("<img/>")
            .attr('type',this.type)
            .attr('direction',this.direction)
            .attr('src',"img/pai/" + this.type +  this.direction +".gif");
    };


    this.isEmpty = function(){
        return this.type == PAI_TYPE_EMPTY;
    };

    this.toString = function(){
        return this.type + this.direction;  
    };

    
};

