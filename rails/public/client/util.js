function print_r(obj, maxlevel, maxitem) {
  if (!maxlevel)
    maxlevel = 4;
  if (!maxitem)
    maxitem = 150;
  var txt = "";
  var count_obj = 0;
  function _output(str) {
    txt += str + "<br/>";
  }

  function _print_r(obj, name, level) {
    var s = "";
    if (obj == undefined || level > maxlevel)
      return;
    for (var i = 0; i < level; i++) {
      s += " | ";
    }
    s += " - " + name + ":" + typeof(obj) + "=" + obj;
    _output(s);
    if (name == "document" || typeof(obj) != "object")
      return;
    for (var key in obj ) {
      if (count_obj++ > maxitem)
        return;
      _print_r(obj[key], key, level + 1);
    }
  }

  _print_r(obj, "*", 0);
  return txt;
}

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