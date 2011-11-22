String.prototype.contain = function(reg){
    return this.match(reg) != null;
};

var agari = null;
var html = "";

function setUp(){ 
    html = "";
    agari={
        "is_parent": true,
        "is_tsumo": true,
        "is_furo": false,
        "status_code": 200,
        "mangan_scale": 0,
        "parent_point": 2000,
        "child_point":  1000,
        "ron_point":    4000,
        "total_fu_num": 30,
        "total_han_num": 2,
        "total_point": 1500,
        'yaku_list':[
            {
                'han_num':1,
                'naki_han_num':0,
                'name':'tsumo',
                'name_kana':'ツモ',
                'name_kanji':'ツモ'
            }
        ]
    };    
}

function tearDown(){
    console.log(html);
}


function doTest(){
}

function testDefault() {
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/30符2飜.*1000点オール/i));
    assertTrue(html.contain(/ツモ/i));
}

function testStatus400() {
    agari["status_code"]=400;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/クライアントエラー/i));
}

function testStatus500() {
    agari["status_code"]=500;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/サーバーエラー/i));
}

function testStatusNull() {
    agari["status_code"]="";
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/Unknown Status Code/i));
}

function testYaku0() {
    agari["yaku_list"]=[];
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/役無しです/i));
}

function testDora1() {
    agari["yaku_list"]=[
        {
            'han_num':1,
            'naki_han_num':1,
            'name':'dora',
            'name_kana':'ドラ',
            'name_kanji':'ドラ'
        }
    ];
    
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/ドラ1\<\/td\>\<td\>1飜/i));
}

function testDora3() {
    agari["yaku_list"]=[
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
            ,
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
            ,
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
        ];
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/ドラ3\<\/td\>\<td\>3飜/i));
}

function testDora1andYaku1() {
    agari["yaku_list"]=[
            {
                "han_num": 1,
                "naki_han_num": 0,
                "name": "iipeikou",
                "name_kana": "イーペーコー",
                "name_kanji": "一盃口"
            }
            ,
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
        ];
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/ドラ1\<\/td\>\<td\>1飜/i));
    assertTrue(html.contain(/一盃口\<\/td\>\<td\>1飜/i));
}

function testDora1Yaku2() {
    agari["yaku_list"]=[
            {
                "han_num": 1,
                "naki_han_num": 0,
                "name": "iipeikou",
                "name_kana": "イーペーコー",
                "name_kanji": "一盃口"
            }
            ,
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
            ,
            {
                "han_num": 3,
                "naki_han_num": 2,
                "name": "honitsu",
                "name_kana": "ホンイツ",
                "name_kanji": "混一色"
            }
        ];
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/ドラ1\<\/td\>\<td\>1飜/i));
    assertTrue(html.contain(/一盃口\<\/td\>\<td\>1飜/i));
    assertTrue(html.contain(/混一色\<\/td\>\<td\>3飜/i));
}

function testParentTsumo() {
    agari["is_parent"]=true;
    agari["is_tsumo"]=true;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/1000点オール/i));
}

function testChildTsumo() {
    agari["is_parent"]=false;
    agari["is_tsumo"]=true;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/子1000点\/親2000点/i));
}

function testParentRon() {
    agari["is_parent"]=true;
    agari["is_tsumo"]=false;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/4000点/i));
}

function testChildRon() {
    agari["is_parent"]=false;
    agari["is_tsumo"]=false;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/4000点/i));
}

function testFuro() {
    agari["is_furo"]=true;
    agari["yaku_list"]=[
            {
                "han_num": 3,
                "naki_han_num": 2,
                "name": "honitsu",
                "name_kana": "ホンイツ",
                "name_kanji": "混一色"
            }, {
                "han_num": 1,
                "naki_han_num": 0,
                "name": "iipeikou",
                "name_kana": "イーペーコー",
                "name_kanji": "一盃口"
            }
            ,
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
    ];
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/混一色\<\/td\>\<td\>2飜/i));
    assertFalse(html.contain(/一盃口/i));
    assertTrue(html.contain(/ドラ1\<\/td\>\<td\>1飜/i));
}


function testMangan0() {
    agari["mangan_scale"]=0;
    html =  new Point(agari).toHtml();
    assertFalse(html.contain(/満貫/i));
}

function testMangan1() {
    agari["mangan_scale"]=1;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/満貫/i));
}

function testMangan15() {
    agari["mangan_scale"]=1.5;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/跳満/i));
}

function testMangan2() {
    agari["mangan_scale"]=2;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/倍満/i));
}

function testMangan3() {
    agari["mangan_scale"]=3;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/三倍満/i));
}

function testMangan4() {
    agari["mangan_scale"]=4;
    html =  new Point(agari).toHtml();
    assertTrue(html.contain(/役満/i));
}
