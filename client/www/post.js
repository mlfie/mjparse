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

