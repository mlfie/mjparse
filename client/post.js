//非同期HTTPリクエスト発行
function createXMLHttpRequest() {
    if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
    } else if (window.ActiveXObject) {
		try {
			return new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				return new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e2) {
				return null;
			}
		}
    } else {
		return null;
    }
}

function toJSON(obj) {
	var ret;
	// null or undefined
	if(obj == null) {
		return "null";
	}
	// array => [value, value, ...]
	if(obj.constructor === Array) {
		ret = "[";
		var comma = "";
		for(var i in obj) {
			ret += comma + toJSON(obj[i]);
			comma = ",";
		}
		return ret + "]";
	}
	// object => {"key":value, "key":value, ...}
	if(obj.constructor === Object) {
		ret = "{";
		var comma = "";
		for(var i in obj) {
			ret += comma + '"' + i + '":' + toJSON(obj[i]);
			comma = ",";
		}
		return ret + "}";
	}
	// number => 0
	if(obj.constructor === Number) {
		return "" + obj;
	}
	// boolean => true / false
	if(obj.constructor === Boolean) {
		return obj?"true": "false";
	}
	// string => "string"
	return '"' + obj + '"';
}


function post(tehai_img_str){
    var url = "http://mjt.fedc.biz/agaris";
    var request = createXMLHttpRequest();
    var param = {agari:
		{
		is_tsumo: true,
		is_haitei: true,
		dora_num: 2,
		bakaze: 'ton',
		jikaze: 'ton',
		honba_num: 9,
		is_rinshan: false,
		is_chankan: false,
		reach_num: 2,
		is_ippatsu: false,
		is_tenho: false,
		is_chiho: false,
		is_parent: true,
		tehai_img: tehai_img_str
		}
	};
    
	
    var json = toJSON(param);
    
    //getAllListのリクエストをAjaxで発行
    var httpObj = createXMLHttpRequest();
	
    //第二引数はtrue=非同期 false=同期
    httpObj.open("POST", url, false);

    httpObj.setRequestHeader("Content-Type","application/json");

    httpObj.send(json);
	
    if(httpObj.status == "200"){
		console.log("SUCCESS")
		finishGetAllList = true;
    }else{
		console.log("[ERROR] Fail \nHTTP Return Status : " + httpObj.status + " \nRequest : " + request );
		return;
    }
    
}
