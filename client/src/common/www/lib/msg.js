var Msg = {};

Msg.info = function(message) {
    $("<div/>")
        .attr("class",'ui-loader ui-overlay-shadow ui-body-b ui-corner-all')
        .css({
            display: "block",
            opacity: 0.9,
            top: window.pageYOffset+100
        })
        .html("<h1>" + message + "<h1>")
        .appendTo("body").delay(500)
        .fadeOut(500, function(){
            $(this).remove();
        });
};

Msg.error = function(message,detail) {
    $("#div_error").html("<p>" + detail +"</p>");

    $("<div/>")
        .attr("id","div_errormsg")
        .attr("class",'ui-loader  ui-overlay-shadow ui-body-b ui-corner-all')
        .css({
            display: "block",
            opacity: 0.9,
            top: window.pageYOffset+100
        })
        .html("<h1>エラー</h1>")
        .append("<p>" + message +"</p>") 
        .append("<button onclick='msg.hide()'>OK</button>")
        .append("<button onclick='msg.hide();$.mobile.changePage(\"#error\")'>詳細</button>")
        .appendTo("body").delay(500);
};

Msg.hide = function(){
    $("#div_errormsg").fadeOut(500, function(){
        $(this).remove();
    });
};

var _dbgNo=0; //デバッグメッセージの行数
Msg.debug = function(tag, msg) {
    $("#content_debug").append(
        $("<p/>")
            .html(_dbgNo + ". " + tag)
            .append($("<button/>")
                    .attr("data-role","none")
                    .html("detail")
                    .click(function (i){
                        return function(){
                            $("#div_dbg_detail" + i).css("display","block");    
                        };
                    }(_dbgNo)))                    
            .append(
                $("<div/>")
                    .attr("id","div_dbg_detail" + _dbgNo)
                    .html(msg)
                    .css("display","none")
            )
    );
    
    _dbgNo++;
};

