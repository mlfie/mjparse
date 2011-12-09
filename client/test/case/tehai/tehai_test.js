function onLoad(){
    Tehai.setTehaiList("s1rs2bs3lj1tj1lm2rm3bm4tm5tm6tm7tp1tp1tp1t");
    console.log(Tehai.toString());
    //$("#div").append(Tehai.jq);
    $("#div").append(Tehai.chJq);
}

function setUp() {
}


function testTehaiInsert1() {
    Tehai.setTehaiList("s1ts2ts3t");
    Tehai.insertPai(0,new Pai("j1","t"));
    assertEquals("j1ts1ts2ts3t",Tehai.toString());
}
function testTehaiInsert2() {
    Tehai.setTehaiList("s1ts2ts3t");
    Tehai.insertPai(1,new Pai("j1","t"));
    assertEquals("s1tj1ts2ts3t",Tehai.toString());
}
function testTehaiInsert3() {
    Tehai.setTehaiList("s1ts2ts3t");
    Tehai.insertPai(3,new Pai("j1","t"));
    assertEquals("s1ts2ts3tj1t",Tehai.toString());
}