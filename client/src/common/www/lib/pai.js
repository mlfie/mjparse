var Pai = function(type,direction){

    this.type = type;
    this.direction = direction;

    this.imgUrl = function(){
        return "img/pai/" + this.type + "-" + this.direction +".gif";
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

};
