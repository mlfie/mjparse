var Pai = function(type,direction){

    Pai.WIDTH=23;
    Pai.HEIGHT=32;
    Pai.DIRECTION_TOP="t";
    Pai.DIRECTION_LEFT="l";
    Pai.DIRECTION_RIGHT="r";
    Pai.DIRECTION_BOTTOM="b";
    Pai.TYPE_EMPTY = "z0";
    Pai.TYPE_REVERSE = "r0";
    Pai.TYPE_LIST = [
    "m1","m2","m3","m4","m5","m6","m7","m8","m9",
    "p1","p2","p3","p4","p5","p6","p7","p8","p9",
    "s1","s2","s3","s4","s5","s6","s7","s8","s9",
    "j1","j2","j3","j4","j5","j6","j7",
    Pai.TYPE_REVERSE];

    this.type = type; //牌の種類　"p1" "j2"といった文字列
    this.direction = direction; //牌の向き "t" "b" といった文字列
 
    this.jq = function(zoom){
        var jq = $("<img/>")
            .attr('type',this.type)
            .attr('direction',this.direction)
            .attr('src',"img/pai/" + this.type +  this.direction +".gif");

        if(arguments.length == 1){
            if(this.isTate()){
                jq.attr("width",Pai.WIDTH * zoom);
                jq.attr("height",Pai.HEIGHT * zoom);
            }else{
                jq.attr("width",Pai.HEIGHT * zoom);
                jq.attr("height",Pai.WIDTH * zoom);
            }
        }
        return jq;
    };


    this.isEmpty = function(){
        return this.type == Pai.TYPE_EMPTY;
    };

    this.toString = function(){
        return this.type + this.direction;  
    };

    this.isTate = function(){
        return this.direction == Pai.DIRECTION_TOP || this.direction == Pai.DIRECTION_BOTTOM;
    };
    
};
new Pai();//これをしないとクラス変数が見えない。
