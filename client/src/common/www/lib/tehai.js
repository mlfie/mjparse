var Tehai = function(tehaiListStr) {

    var PAI_NUMBER=14;

    this.paiList = new Array();
    this.changeIndex = -1; // 変更対象の牌の場所

    dbgmsg("Tehai.new","tehaiListStr = " + tehaiListStr);
    //3文字ごとに分ける ex)"s6ts7ts8t"    
    for (var i = 0; i < tehaiListStr.length || i < PAI_NUMBER*3 ; i += 3) {
        var paiTypeStr = tehaiListStr.slice(i, i + 2);
        var paiDirectionStr = tehaiListStr.slice(i + 2, i + 3);
        if (paiTypeStr == "") {
            //解析に失敗したパイがある場合
            paiTypeStr = PAI_TYPE_UNANALYZABLE;
            paiDirectionStr=PAI_DIRECTION_TOP;
        }
        this.paiList.push(new Pai(paiTypeStr,paiDirectionStr));
    }
    
    this.toJq = function(){
        var divJq = $("<div/>");
        for(var i = 0 ; i<this.paiList.length ; i++){
            var imgJq = this.paiList[i].imgJq()
                .attr("id","tehai" + i)
                .attr("index",i)
                .click(
                function(){
                    //牌がクリックされた場合、自分のindexをグローバル変数に渡す
                    changeTargetPaiIndex = $(this).attr("index");
                    $("#div_selectpanel").show();
                });
            
            divJq.append(imgJq); 
            
        }

        return divJq;
    };

    this.changePai = function(index,type){
        dbgmsg("Tehai.changePai",index + " " + type);
        this.paiList[index].changeType(type);
    };

    this.changeDirection = function(index,direction){
        dbgmsg("Tehai.changeDirection",index + " " + direction);
        this.paiList[index].changeDirection(direction);
    };

    this.toString = function(){
        var str = "";
        $.each(this.paiList,function(){
                   str += this.type + this.direction;
               });
        return str;
    };
};
