/**
 * 文字列配列をHTMLに変換する
 */
function strArray2Html(array){
  var str="";
  var debugstr="";
  $.each(array,function() {
           debugstr += this + ",";
           str += "<div style='float:left;margin: 2px; padding: 1px; border: 1px dotted gray;'>"
             + this
             + "</div>";
         });
  dbgmsg("array2Html",debugstr);
  str += "<div style='clear:left'></div>";
  return str;
}

/**
 * 文字列配列をTextに変換する
 */
function strArray2Txt(array){
  var str="";
  $.each(array,function() {
           str += this + ",";
         });
  return str;
}


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
      ret += comma + '"' + i + '": ' + toJSON(obj[i]);
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

/**
 * @param obj Javascriptのオブジェクト
 * @return 整形されたJSONのHTML
 */
function json2html(obj) {
  var baseIndent = 1;
  var buff = [];
  var addIndent = function(buff, indent) {
    for (i=0; i<indent; i++) {
      buff.push(' &nbsp');
    }
  };
  var read = function(o, indent) {
    if (typeof(o) == "string" || o instanceof String) {
      return '"' + o + '"';
    }   else if (typeof(o) == "number" || o instanceof Number) {

      return o;
    } else if (o instanceof Array) {
      if (o) {
        buff.push('[');
        for (idx in o) {
          buff.push(read(o[idx], indent + baseIndent));
          buff.push(', ');
        }
        if (o.length > 0)
          delete buff[buff.length - 1];
        buff.push(']');
      }
    } else if (o instanceof Object) {
      if (o) {
        buff.push('{<br>\n');
        for (key in o) {
          addIndent(buff, indent + baseIndent);
          buff.push('"' + key + '": ');
          buff.push(read(o[key], indent + baseIndent));
          buff.push(',<br>\n');
        }
        delete buff[buff.length - 1];
        buff.push('<br>\n');
        addIndent(buff, indent);
        buff.push('}');
      }
    }
  };
  read(obj, 0);
  return buff.join('');
}


/**
 * @param obj Javascriptのオブジェクト
 * @return 整形されたJSONのTXT
 */
function json2txt(obj) {
  var baseIndent = 1;
  var buff = [];
  var addIndent = function(buff, indent) {
    for (i=0; i<indent; i++) {
      buff.push(' ');
    }
  };
  var read = function(o, indent) {
    if (typeof(o) == "string" || o instanceof String) {
      return '"' + o + '"';
    }   else if (typeof(o) == "number" || o instanceof Number) {

      return o;
    } else if (o instanceof Array) {
      if (o) {
        buff.push('[');
        for (idx in o) {
          buff.push(read(o[idx], indent + baseIndent));
          buff.push(', ');
        }
        if (o.length > 0)
          delete buff[buff.length - 1];
        buff.push(']');
      }
    } else if (o instanceof Object) {
      if (o) {
        buff.push('{\n');
        for (key in o) {
          addIndent(buff, indent + baseIndent);
          buff.push('"' + key + '": ');
          buff.push(read(o[key], indent + baseIndent));
          buff.push(',\n');
        }
        delete buff[buff.length - 1];
        buff.push('\n');
        addIndent(buff, indent);
        buff.push('}');
      }
    }
  };
  read(obj, 0);
  return buff.join('');
};

/**
 * 画像のDomNodeからdata URL scheme文字列を取得する
 * (data URL scheme:RFC2397参照)
 *
 * @param {String} imgDom 画像のDomNode
 * @return {String} 画像の表示されている大きさのdata URL scheme
 */
var imgDomToDataUrl = function(imgDom){
  var canvas=document.createElement('canvas');
  canvas.width=imgDom.width;
  canvas.height=imgDom.height;
  var context = canvas.getContext('2d');
  context.drawImage(imgDom,0,0);
  return canvas.toDataURL("image/jpeg");
};

/**
 * data URL schemeの画像文字列をリサイズする
 * (data URL scheme:RFC2397参照)
 *
 * @param {String} dataUrl 画像のdata URL scheme
 * @param {String} type 画像のmime type(jpegならば"image/jpeg")
 * @param {String} width 幅
 * @param {String} height 高さ
 * @return {String} リサイズしたdata URL scheme
 */
var dataUrlResize = function (dataUrl,type,width,height){
  var img = document.createElement('img');
  img.src = dataUrl;
  var canvas=document.createElement('canvas');
  canvas.width=width;
  canvas.height=height;
  var context = canvas.getContext('2d');
  context.drawImage(img,0,0,width,height);
  return canvas.toDataURL(type);
};
