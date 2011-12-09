function dbgmsg(tag, msg) {
    $("#content_debug").append("<b>" +  tag + "</b><p>" + msg +"</p>");
}

function assertInclude(str,regexp){
    assertTrue("\"" + regexp + "\" should be included in \"" + str +"\"",  
               str.match(regexp) != null);
}
function assertNotInclude(str,regexp){
    assertTrue("\"" + regexp + "\" should NOT be included in \"" + str +"\"",  
               str.match(regexp) == null);
}

function sleep(time) {
    
    var d1 = new Date().getTime();
    var d2 = new Date().getTime();
    while (d2 < d1 + time) {
        
        d2 = new Date().getTime();
        }
    return;
}
