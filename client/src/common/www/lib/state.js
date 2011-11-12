var State = function(){

    State.JPN={
        "is_reach": "リーチ",
        "is_ippatsu": "一発",
        "is_haitei": "海底",
        "is_rinshan": "嶺上",
        "is_chankan": "槍槓",
        "is_tenho": "天和",
        "is_chiho": "地和",
        "ton": "東",
        "nan": "南",
        "sha": "西",
        "pei": "北"
    };


    this.clearData = function(){
        dbgmsg("State.clearData","called");
        this.bakaze = "ton";
        this.honba_num = 0;
        this.jikaze = "ton";
        this.is_tsumo = true;
        this.dora_num = 0;
        this.yakuEnableList = {
            "is_reach" : false,
            "is_ippatsu": false,
            "is_haitei": false,
            "is_rinshan": false,
            "is_chankan": false,
            "is_tenho": false,
            "is_chiho": false
        };
    };
    

    this.updateData = function(){
        dbgmsg("State.updateData","called");
        this.bakaze = $("#bakaze").val();
        this.honba_num = $("#honba_num").val();
        this.jikaze = $("#jikaze").val();
        this.dora_num = $("#dora_num").val();
        this.is_tsumo = $("#is_tsumo").val() == "true";
        for(yaku in this.yakuEnableList){
            if ( $("#" + yaku).attr("checked") == "checked" ){
                this.yakuEnableList[yaku] = true;
            }else{
                this.yakuEnableList[yaku] = false;
            }
        }
    };

    this.updateForm = function(){
        $("#bakaze").val(this.bakaze).selectmenu("refresh");
        $("#honba_num").val(this.honba_num).slider("refresh");
        $("#jikaze").val(this.jikaze).selectmenu("refresh");
        $("#is_tsumo").val(this.is_tsumo).slider("refresh");
        $("#dora_num").val(this.dora_num).slider("refresh");        
        for(yaku in this.yakuEnableList){
            if(this.yakuEnableList[yaku]){
                $("#" + yaku).attr("checked","true").checkboxradio("refresh");
            }else{
                $("#" + yaku).removeAttr("checked").checkboxradio("refresh");
            }
        }        
    };

    this.updateDisplay = function(){
        $("#div_state_str").html(this.toHtml());       
    };


    this.toStrList = function(){
        var stateStrList = new Array();
        stateStrList.push( State.JPN[this.bakaze] +"場" + this.honba_num + "本場");
        stateStrList.push( "自風" + State.JPN[this.jikaze]) ;
        if ( this.is_tsumo){
            stateStrList.push("ツモ");
        }else{
            stateStrList.push("ロン");
        }
        stateStrList.push( "ドラ" + this.dora_num) ;
        for(yaku in this.yakuEnableList){
            if(this.yakuEnableList[yaku]){
                stateStrList.push(State.JPN[yaku]);
            }
        }
        return stateStrList;
    };

    this.toString = function(){
        return strArray2Text(this.toStrList());
    };

    this.toHtml = function(){
        return strArray2Html(this.toStrList());
    };

    this.toObj = function(){
        var obj = {
            agari: {}
        };
        obj["agari"]["bakaze"] = this.bakaze;
        obj["agari"]["jikaze"] = this.jikaze;
        obj["agari"]["honba_num"] =this.honba_num;
        obj["agari"]["dora_num"] = this.dora_num;
        obj["agari"]["is_tsumo"]= this.is_tsumo;
        for(yaku in this.yakuEnableList){
            if(this.yakuEnableList[yaku]){
                obj["agari"][yaku] = true;
            }
        }        
        //is_parentの計算
        obj["agari"]["is_parent"] = this.jikaze == "ton";
        
        //リーチのフォーマット変換 is_reach -> reach_num
        var rnum;
        if(obj["agari"]["is_reach"]){
            rnum=1;
        }else{
            rnum=0;
        }
        obj["agari"]["reach_num"] =rnum;
        delete obj["agari"]["is_reach"] ;
        
        return obj;
    };



};