var State = {};

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

State.clearData = function(){
    Msg.debug("State.clearData","called");
    State.bakaze = "ton";
    State.honba_num = 0;
    State.jikaze = "ton";
    State.is_tsumo = true;
    State.dora_num = 0;
    State.yakuEnableList = {
        "is_reach" : false,
        "is_ippatsu": false,
        "is_haitei": false,
        "is_rinshan": false,
        "is_chankan": false,
        "is_tenho": false,
        "is_chiho": false
    };
};

State.updateData = function(){
    Msg.debug("State.updateData","called");
    State.bakaze = $("#bakaze").val();
    State.honba_num = $("#honba_num").val();
    State.jikaze = $("#jikaze").val();
    State.dora_num = $("#dora_num").val();
    State.is_tsumo = $("#is_tsumo").val() == "true";
    for(yaku in State.yakuEnableList){
        if ( $("#" + yaku).attr("checked") == "checked" ){
            State.yakuEnableList[yaku] = true;
        }else{
            State.yakuEnableList[yaku] = false;
        }
    }
};

State.updateForm = function(){
    $("#bakaze").val(State.bakaze).selectmenu("refresh");
    $("#honba_num").val(State.honba_num).slider("refresh");
    $("#jikaze").val(State.jikaze).selectmenu("refresh");
    $("#is_tsumo").val(State.is_tsumo).slider("refresh");
    $("#dora_num").val(State.dora_num).slider("refresh");        
    for(yaku in State.yakuEnableList){
        if(State.yakuEnableList[yaku]){
            $("#" + yaku).attr("checked","true").checkboxradio("refresh");
        }else{
            $("#" + yaku).removeAttr("checked").checkboxradio("refresh");
        }
    }        
};

State.updateDisplay = function(){
    $("#div_state_str").html(State.toHtml());       
};


State.toStrList = function(){
    var stateStrList = new Array();
    stateStrList.push( State.JPN[State.bakaze] +"場" + State.honba_num + "本場");
    stateStrList.push( "自風" + State.JPN[State.jikaze]) ;
    if ( State.is_tsumo){
        stateStrList.push("ツモ");
    }else{
        stateStrList.push("ロン");
    }
    stateStrList.push( "ドラ" + State.dora_num) ;
    for(yaku in State.yakuEnableList){
        if(State.yakuEnableList[yaku]){
            stateStrList.push(State.JPN[yaku]);
        }
    }
    return stateStrList;
};

State.toString = function(){
    return strArray2Text(State.toStrList());
};

State.toHtml = function(){
    return strArray2Html(State.toStrList());
};

State.toObj = function(){
    var obj = {
        agari: {}
    };
    obj["agari"]["bakaze"] = State.bakaze;
    obj["agari"]["jikaze"] = State.jikaze;
    obj["agari"]["honba_num"] =State.honba_num;
    obj["agari"]["dora_num"] = State.dora_num;
    obj["agari"]["is_tsumo"]= State.is_tsumo;
    for(yaku in State.yakuEnableList){
        if(State.yakuEnableList[yaku]){
            obj["agari"][yaku] = true;
        }
    }        
    //is_parentの計算
    obj["agari"]["is_parent"] = State.jikaze == "ton";
    
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