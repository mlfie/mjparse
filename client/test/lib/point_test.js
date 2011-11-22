String.prototype.contain = function(reg){
    return this.match(reg) != null;
};

function doTest(){
}

function testStatus200() {

    var agari = {
        "is_parent": true,
        "is_tsumo": true,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 1000,
        "ron_point": 2000,
        "child_point": 3000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        "yaku_list": []
    };

    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/30符6飜.*3000点オール/i));
}

function testStatus400() {

    var agari = {
        "is_parent": true,
        "is_tsumo": true,
        "status_code": 500,
        "mangan_scale": 1,
        "parent_point": 1000,
        "ron_point": 2000,
        "child_point": 3000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        "yaku_list": []
    };

    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/失敗/i));
}

function testStatus500() {

    var agari = {
        "is_parent": true,
        "is_tsumo": true,
        "status_code": 500,
        "mangan_scale": 1,
        "parent_point": 1000,
        "ron_point": 2000,
        "child_point": 3000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        "yaku_list": []
    };

    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/失敗/i));
}

function testStatusNull() {

    var agari = {
        "is_parent": true,
        "is_tsumo": true,
        "status_code": "",
        "mangan_scale": 1,
        "parent_point": 1000,
        "ron_point": 2000,
        "child_point": 3000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        "yaku_list": []
    };

    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/失敗/i));
}


function testDora1() {
    var agari={
        "is_parent": true,
        "is_tsumo": true,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 0,
        "ron_point": 0,
        "child_point": 6000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        'yaku_list':[
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
        ]
        
    };
    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/ドラ1\<\/td\>\<td\>1飜/i));
}

function testDora3() {
    var agari={
        "is_parent": true,
        "is_tsumo": true,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 0,
        "ron_point": 0,
        "child_point": 6000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        'yaku_list':[
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
        ]
        
    };
    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/ドラ3\<\/td\>\<td\>3飜/i));
}


function testDora1andYaku1() {
    var agari={
        "is_parent": true,
        "is_tsumo": true,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 0,
        "ron_point": 0,
        "child_point": 6000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        'yaku_list':[
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
        ]
        
    };
    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/ドラ1\<\/td\>\<td\>1飜/i));
    assertTrue(html.contain(/一盃口\<\/td\>\<td\>1飜/i));
}

function testDora1Yaku2() {
    var agari={
        "is_parent": true,
        "is_tsumo": true,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 0,
        "ron_point": 0,
        "child_point": 6000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        'yaku_list':[
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
        ]
        
    };
    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/ドラ1\<\/td\>\<td\>1飜/i));
    assertTrue(html.contain(/一盃口\<\/td\>\<td\>1飜/i));
    assertTrue(html.contain(/混一色\<\/td\>\<td\>3飜/i));
}

function testParentTsumo() {
    var agari={
        "is_parent": true,
        "is_tsumo": true,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 2000,
        "child_point":  1000,
        "ron_point":    4000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        'yaku_list':[
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
        ]
    };
    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/1000点オール/i));
}

function testChildTsumo() {
    var agari={
        "is_parent": false,
        "is_tsumo": true,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 2000,
        "child_point":  1000,
        "ron_point":    4000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        'yaku_list':[
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
        ]
    };
    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/子1000点\/親2000点/i));
}

function testParentRon() {
    var agari={
        "is_parent": true,
        "is_tsumo": false,
        "is_furo": false,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 2000,
        "child_point":  1000,
        "ron_point":    4000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        'yaku_list':[
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
        ]
    };
    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/4000点/i));
}

function testChildRon() {
    var agari={
        "is_parent": false,
        "is_tsumo": false,
        "is_furo": false,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 2000,
        "child_point":  1000,
        "ron_point":    4000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        'yaku_list':[
            {
                'han_num':1,
                'naki_han_num':1,
                'name':'dora',
                'name_kana':'ドラ',
                'name_kanji':'ドラ'
            }
        ]
    };
    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/4000点/i));
}


function testFuro() {
    var agari={
        "is_parent": true,
        "is_tsumo": false,
        "is_furo": true,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 2000,
        "child_point":  1000,
        "ron_point":    4000,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        'yaku_list':[
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
        ]
    };
    var html =  new Point(agari).toHtml();
    console.log(html);
    assertTrue(html.contain(/混一色\<\/td\>\<td\>2飜/i));
    assertFalse(html.contain(/一盃口/i));
    assertTrue(html.contain(/ドラ1\<\/td\>\<td\>1飜/i));
}


    var agari = {
        "id": 441,
        "bakaze": "ton",
        "jikaze": "ton",
        "dora_num": 0,
        "honba_num": 0,
        "created_at": "2011-11-23T00:25:22+09:00",
        "img_url": "http://mjt.fedc.biz/img/1.jpg",
        "is_chankan": false,
        "is_chiho": false,
        "is_furo": false,
        "is_haitei": false,
        "is_ippatsu": false,
        "is_parent": false,
        "is_rinshan": false,
        "is_tenho": false,
        "is_tsumo": false,
        "status_code": 200,
        "mangan_scale": 1,
        "parent_point": 0,
        "reach_num": 0,
        "ron_point": 0,
        "child_point": 6090,
        "total_fu_num": 30,
        "total_han_num": 6,
        "total_point": 18270,
        "tehai_img": false,
        "tehai_list": "j7tj7tj7tp1tp1tp2tp2tp3tp3tp4tp4tp4tp5tp6t",
        "updated_at": "2011-11-23T00:25:22+09:00",
        "yaku_list": [{
                          "created_at": "2011-05-14T14:57:26+09:00",
                          "han_num": 3,
                          "id": 26,
                          "naki_han_num": 2,
                          "name": "honitsu",
                          "name_kana": "ホンイツ",
                          "name_kanji": "混一色",
                          "updated_at": "2011-10-08T16:10:43+09:00"
                      }, {
                          "created_at": "2011-05-14T14:37:09+09:00",
                          "han_num": 1,
                          "id": 7,
                          "naki_han_num": 0,
                          "name": "iipeikou",
                          "name_kana": "イーペーコー",
                          "name_kanji": "一盃口",
                          "updated_at": "2011-10-08T16:07:36+09:00"
                      }, {
                          "created_at": "2011-05-14T14:38:01+09:00",
                          "han_num": 1,
                          "id": 8,
                          "naki_han_num": 0,
                          "name": "tsumo",
                          "name_kana": "ツモ",
                          "name_kanji": "自摸",
                          "updated_at": "2011-10-08T16:07:43+09:00"
                      }, {
                          "created_at": "2011-05-14T14:41:41+09:00",
                          "han_num": 1,
                          "id": 11,
                          "naki_han_num": 1,
                          "name": "chun",
                          "name_kana": "チュン",
                          "name_kanji": "中",
                          "updated_at": "2011-10-08T16:08:06+09:00"
                      }]
    };
