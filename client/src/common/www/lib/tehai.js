var Tehai = function(tehaiListStr) {

    var PAI_MAX_NUMBER=18;//牌の最大枚数

    this.paiList = new Array();

    dbgmsg("Tehai.new","tehaiListStr = " + tehaiListStr);
    //3文字ごとに分ける ex)"s6ts7ts8l"
    for (var i = 0;  i < PAI_MAX_NUMBER * 3 ; i += 3) {
        var paiTypeStr = tehaiListStr.slice(i, i + 2);
        var paiDirectionStr = tehaiListStr.slice(i + 2, i + 3);
        if (paiTypeStr == "") {
            //解析に失敗したパイがある場合
            paiTypeStr = PAI_TYPE_EMPTY;
            paiDirectionStr=PAI_DIRECTION_TOP;
        }
        this.paiList.push(new Pai(paiTypeStr,paiDirectionStr));
    }

    this.toJq = function(){
        var divJq = $("<div/>");
        $.each(this.paiList,function(){
            divJq.append(this.toChangeableJq());
        });
        return divJq;
    };

    this.toString = function(){
        var str = "";
        $.each(this.paiList,function(){
            if(! this.isEmpty()){
                str += this.toString();
            }
        });
        return str;
    };
};
