function doAllTest(){
    var pai = new Pai("s1",Pai.DIRECTION_TOP);
    $("#div").append(pai.jq(1.5));
    var pai = new Pai("s1",Pai.DIRECTION_LEFT);
    $("#div").append(pai.jq(3));
}

function setUp() {
}


function testPaiToString() {
    assertEquals("s1t" , new Pai("s1",Pai.DIRECTION_TOP).toString());
    assertEquals("s1b" , new Pai("s1",Pai.DIRECTION_BOTTOM).toString());
    assertEquals("s1l" , new Pai("s1",Pai.DIRECTION_LEFT).toString());
    assertEquals("s1r" , new Pai("s1",Pai.DIRECTION_RIGHT).toString());
    assertEquals("z0t" , new Pai(Pai.TYPE_EMPTY,Pai.DIRECTION_TOP).toString());
    assertEquals("r0t" , new Pai(Pai.TYPE_REVERSE,Pai.DIRECTION_TOP).toString());
}

function testPaiJq() {
    var pai = new Pai("s1",Pai.DIRECTION_TOP);
    assertEquals("img/pai/s1t.gif" , pai.jq().attr("src"));
}

function testPaiJqZoom() {
    var pai = new Pai("s1",Pai.DIRECTION_TOP);
    assertEquals(Pai.HEIGHT * 2+"" , pai.jq(2).attr("height"));
    assertEquals(Pai.WIDTH * 2+"" , pai.jq(2).attr("width"));
}

function testPaiJqZoomYoko() {
    var pai = new Pai("s1",Pai.DIRECTION_LEFT);
    assertEquals(Pai.WIDTH * 0.5 +"", pai.jq(0.5).attr("height"));
    assertEquals(Pai.HEIGHT * 0.5+"" , pai.jq(0.5).attr("width"));
}

function testPaiIsEmpty(){
    assertTrue(new Pai("z0","t").isEmpty());
    assertFalse(new Pai("s1","t").isEmpty());
}

