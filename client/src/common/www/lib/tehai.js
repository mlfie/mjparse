var Tehai = function(tehaiList) {

    var DIRE_MAP={
        "t" : "top",
        "l" : "left",
        "r" : "right",
        "b" : "bottom"
    };

    var DIRE_R_MAP={
        "top" : "t",
        "left" : "l",
        "right" : "r",
        "bottom" : "b"
    };

    this.paiList = new Array();
    this.changeIndex = -1;

    if(typeof tehaiList == "string" ){
        dbgmsg("makePaiImgUrlList","type is string = " + tehaiList);
        //tehai_listが文字列形の場合
        //3文字ごとに分ける ex)"s6ts7ts8t"
        for (var i = 0; i < 14 * 3 ; i += 3) {
            var paistr = tehaiList.slice(i, i + 2);
            var dstr = tehaiList.slice(i + 2, i + 3);
            if (paistr == "") {
                //解析に失敗したパイがある場合
                paistr = "z0";
                dstr="t";
            }
            this.paiList.push(new Pai(paistr,DIRE_MAP[dstr]));
        }
    }else{
        dbgmsg("makePaiImgUrlList","type is list ");
        //tehai_listが配列の場合
        $.each(tehaiList,function(){
                   this.paiList.push(
                       new Pai(this.type + this.number,this.direction)
                       );
               });
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

    this.toString = function(){
        var str = "";
        $.each(this.paiList,function(){
                   str += this.type + DIRE_R_MAP[this.direction];
               });
        return str;
    };
};
