# -*- coding: utf-8 -*-
require 'test_helper'

class TotalTest < Test::Unit::TestCase

  TON = Mjparse::Kyoku::KYOKU_KAZE_TON
  NAN = Mjparse::Kyoku::KYOKU_KAZE_NAN
  SHA = Mjparse::Kyoku::KYOKU_KAZE_SHA
  PEI = Mjparse::Kyoku::KYOKU_KAZE_PEI

  def setup
    @yaku_specimen = Hash.new
    @yaku_specimen['reach'] = Mjparse::YakuSpecimen.new('reach','立直',1,0)
    @yaku_specimen['ippatsu'] = Mjparse::YakuSpecimen.new('ippatsu','一発',1,0)
    @yaku_specimen['tanyao'] = Mjparse::YakuSpecimen.new('tanyao','断幺九',1,1)
    @yaku_specimen['pinfu'] = Mjparse::YakuSpecimen.new('pinfu','平和',1,0)
    @yaku_specimen['sanshoku'] = Mjparse::YakuSpecimen.new('sanshoku','三色同順',2,1)
    @yaku_specimen['sanshokudouko'] = Mjparse::YakuSpecimen.new('sanshokudouko','三色同刻',2,2)
    @yaku_specimen['iipeikou'] = Mjparse::YakuSpecimen.new('iipeikou','一盃口',1,0)
    @yaku_specimen['tsumo'] = Mjparse::YakuSpecimen.new('tsumo','自摸',1,0)
    @yaku_specimen['haku'] = Mjparse::YakuSpecimen.new('haku','白',1,1)
    @yaku_specimen['hatsu'] = Mjparse::YakuSpecimen.new('hatsu','發',1,1)
    @yaku_specimen['chun'] = Mjparse::YakuSpecimen.new('chun','中',1,1)
    @yaku_specimen['jikazeton'] = Mjparse::YakuSpecimen.new('jikazeton','東',1,1)
    @yaku_specimen['bakazeton'] = Mjparse::YakuSpecimen.new('bakazeton','東',1,1)
    @yaku_specimen['jikazenan'] = Mjparse::YakuSpecimen.new('jikazenan','南',1,1)
    @yaku_specimen['bakazenan'] = Mjparse::YakuSpecimen.new('bakazenan','南',1,1)
    @yaku_specimen['jikazesha'] = Mjparse::YakuSpecimen.new('jikazesha','西',1,1)
    @yaku_specimen['bakazesha'] = Mjparse::YakuSpecimen.new('bakazesha','西',1,1)
    @yaku_specimen['jikazepei'] = Mjparse::YakuSpecimen.new('jikazepei','北',1,1)
    @yaku_specimen['bakazepei'] = Mjparse::YakuSpecimen.new('bakazepei','北',1,1)
    @yaku_specimen['rinshan'] = Mjparse::YakuSpecimen.new('rinshan','嶺上開花',1,1)
    @yaku_specimen['ikkitsukan'] = Mjparse::YakuSpecimen.new('ikkitsukan','一気通貫',2,1)
    @yaku_specimen['chanta'] = Mjparse::YakuSpecimen.new('chanta','混全帯?九',2,1)
    @yaku_specimen['toitoihou'] = Mjparse::YakuSpecimen.new('toitoihou','対々和',2,2)
    @yaku_specimen['sanankou'] = Mjparse::YakuSpecimen.new('sanankou','三暗刻',2,2)
    @yaku_specimen['honroutou'] = Mjparse::YakuSpecimen.new('honroutou','混老頭',2,2)
    @yaku_specimen['sankantsu'] = Mjparse::YakuSpecimen.new('sankantsu','三槓子',2,2)
    @yaku_specimen['shousangen'] = Mjparse::YakuSpecimen.new('shousangen','小三元',2,2)
    @yaku_specimen['doublereach'] = Mjparse::YakuSpecimen.new('doublereach','ダブル立直',2,0)
    @yaku_specimen['chitoitsu'] = Mjparse::YakuSpecimen.new('chitoitsu','七対子',2,2)
    @yaku_specimen['honitsu'] = Mjparse::YakuSpecimen.new('honitsu','混一色',3,2)
    @yaku_specimen['junchan'] = Mjparse::YakuSpecimen.new('junchan','純全帯?九',3,2)
    @yaku_specimen['ryanpeikou'] = Mjparse::YakuSpecimen.new('ryanpeikou','二盃口',3,0)
    @yaku_specimen['chinitsu'] = Mjparse::YakuSpecimen.new('chinitsu','清一色',6,5)
    @yaku_specimen['chankan'] = Mjparse::YakuSpecimen.new('chankan','槍槓',1,1)
    @yaku_specimen['haitei'] = Mjparse::YakuSpecimen.new('haitei','海底摸月',1,1)
    @yaku_specimen['houtei'] = Mjparse::YakuSpecimen.new('houtei','河底撈魚',1,1)
    @yaku_specimen['kokushi'] = Mjparse::YakuSpecimen.new('kokushi','国士無双',13,0)
    @yaku_specimen['suuankou'] = Mjparse::YakuSpecimen.new('suuankou','四暗刻',13,0)
    @yaku_specimen['daisangen'] = Mjparse::YakuSpecimen.new('daisangen','大三元',13,13)
    @yaku_specimen['tsuuiisou'] = Mjparse::YakuSpecimen.new('tsuuiisou','字一色',13,13)
    @yaku_specimen['shousuushii'] = Mjparse::YakuSpecimen.new('shousuushii','小四喜',13,13)
    @yaku_specimen['daisuushii'] = Mjparse::YakuSpecimen.new('daisuushii','大四喜',13,13)
    @yaku_specimen['ryuuiisou'] = Mjparse::YakuSpecimen.new('ryuuiisou','緑一色',13,13)
    @yaku_specimen['chinroutou'] = Mjparse::YakuSpecimen.new('chinroutou','清老頭',13,13)
    @yaku_specimen['suukantsu'] = Mjparse::YakuSpecimen.new('suukantsu','四槓子',13,13)
    @yaku_specimen['chuurennpoutou'] = Mjparse::YakuSpecimen.new('chuurennpoutou','九蓮宝燈',13,0)
    @yaku_specimen['tenhou'] = Mjparse::YakuSpecimen.new('tenhou','天和',13,0)
    @yaku_specimen['chihou'] = Mjparse::YakuSpecimen.new('chihou','地和',13,0)
    @yaku_specimen['dora'] = Mjparse::YakuSpecimen.new('dora','ドラ',1,1)

    @resolver = Mjparse::MentsuResolver.new

  end

  def teardown
  end

  #http://homepage2.nifty.com/syusui/majyn/mondai.html
  #親の40符３飜は7700点
  #嵌張待ち( 4w 6w )の２符で40符(32符)になる。
  #役は立直(１飜)と一気通貫親(２飜)。もし自摸っていれば12000点。
  def test_case_1_a
    # input
    pai_items = "m1 m2 m3 m4 m6 m7 m8 m9 p3 p4 p5 j3 j3 m5 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false
    kyoku.is_haitei  = false
    kyoku.dora_num   = 0
    kyoku.bakaze     = NAN
    kyoku.jikaze     = TON
    kyoku.honba_num  = 0
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    kyoku.reach_num  = 1
    kyoku.is_ippatsu = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_parent  = true
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 40, teyaku.fu_num
    assert_equal 3, teyaku.han_num
    assert_equal 0, teyaku.mangan_scale
    assert_equal 7700, teyaku.total_point
    assert_equal 0, teyaku.parent_point
    assert_equal 0, teyaku.child_point
    assert_equal 7700, teyaku.ron_point
    assert_equal 2, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "reach")
    assert_equal true, teyaku_include?(teyaku, "ikkitsukan")
  end

  #http://homepage2.nifty.com/syusui/majyn/mondai.html
  #子の30符２飜は2000点
  #＠解説平和のロン和了は30符。役は平和(１飜)とドラ１(１飜)。
  #一見、「嵌張待ち( 1w 3w )に取ることが出来るから40符(32符)だ！」
  #と勘違いしがちだが、平和はロン和了の場合は必ず30符、
  #自摸和了の場合は必ず20符になる。→特殊な例もし自摸っていれば
  #2600点(実際はいわゆるナナ・トーサンで計2700点になる)。
  def test_case_1_b
    # input
    pai_items = "m1 m2 m3 m3 m4 p4 p5 p6 s5 s6 s7 s7 s7 m2 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false
    kyoku.dora_num   = 1
    kyoku.bakaze     = TON
    kyoku.honba_num  = 0
    kyoku.jikaze     = SHA
    kyoku.is_parent  = false
    kyoku.reach_num  = 0
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 30, teyaku.fu_num
    assert_equal 2, teyaku.han_num
    assert_equal 0, teyaku.mangan_scale
    assert_equal 2000, teyaku.total_point
    assert_equal 0, teyaku.parent_point
    assert_equal 0, teyaku.child_point
    assert_equal 2000, teyaku.ron_point
    assert_equal 1, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "pinfu")
  end

  #http://homepage2.nifty.com/syusui/majyn/mondai.html
  #解答(c)
  #子の30符３飜は3900点
  #＠解説南の明刻( 南南南b )の４符加算で30符(24符)。役は鳴き混一色(２飜)と
  #場風(１飜)。ちなみに 3w 6w 7w 8w 9w の多面張待ちで、その中でも
  #１番安目で上がったことになる。それぞれの牌で上がった場合の点数は、 
  #3w の場合、ロン・自摸和了どちらも3900点、 7w 8w の場合、ロン・自摸和了
  #どちらも5200点、 6w 9w の場合、ロン・自摸和了どちらも8000点、
  #とかなり開きがある。
  def test_case_1_c
    # input
    pai_items = "m4 m5 m6 m7 m7 m8 m8 m9 m9 m9 m3 j2 j2 j2l".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false
    kyoku.dora_num   = 0
    kyoku.bakaze     = NAN
    kyoku.honba_num  = 0
    kyoku.jikaze     = SHA
    kyoku.is_parent  = false
    kyoku.reach_num  = 0
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 30, teyaku.fu_num
    assert_equal 3, teyaku.han_num
    assert_equal 0, teyaku.mangan_scale
    assert_equal 3900, teyaku.total_point
    assert_equal 0, teyaku.parent_point
    assert_equal 0, teyaku.child_point
    assert_equal 3900, teyaku.ron_point
    assert_equal 2, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "honitsu")
    assert_equal true, teyaku_include?(teyaku, "bakazenan")
  end


  #http://homepage2.nifty.com/syusui/majyn/mondai.html
  #解答(d)
  #子の70符３飜は満貫(8000点)＋600点
  #＠解説　５索の明刻( 5s5s5sb )の２符＋９萬の暗槓( 裏9w9w裏 )の
  #32符＋西の暗刻( 西西西 )の８符＝42符で符ハネして70符(62符)。
  #役は自風(１飜)とドラ２(２飜)。２本場なので600点加算されることを見逃してはダメ。
  def test_case_1_d
    # input
    pai_items = "m4 m4 m5 m6 j3 j3 j3 m9 m9 m9 m9 m7 s5 s5 s5l".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false
    kyoku.dora_num   = 2
    kyoku.bakaze     = TON
    kyoku.honba_num  = 2
    kyoku.jikaze     = SHA
    kyoku.is_parent  = false
    kyoku.reach_num  = 0
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 70, teyaku.fu_num
    assert_equal 3, teyaku.han_num
    assert_equal 1, teyaku.mangan_scale
    assert_equal 8600, teyaku.total_point
    assert_equal 0, teyaku.parent_point
    assert_equal 0, teyaku.child_point
    assert_equal 8600, teyaku.ron_point
    assert_equal 1, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "jikazesha")
  end


  #http://homepage2.nifty.com/syusui/majyn/mondai.html
  #解答(e)
  #親の80符３飜は満貫(12000点)
  #＠解説　南の暗槓( 裏南南裏 )の32符＋３筒の明槓( 3p3p3p3pb )の
  #８符＋１筒の暗刻( 1p1p1p )の８符＋５筒単騎待ちの２符＋和了の符の
  #２符＝52符で符ハネして80符(72符)。役は鳴き混一色(２飜)と場風(１飜)。
  #ロン和了の場合も70符で満貫、 8p であがっても同じく満貫。
  #(この場合自摸は70符、ロンも70符(68符)だから。) 
  def test_case_1_e
    # input
    pai_items = "p1 p1 p1 p5 p5 p6 p7 r0 j2 j2 r0 p5 p3 p3 p3 p3l".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = true
    kyoku.dora_num   = 0
    kyoku.bakaze     = NAN
    kyoku.honba_num  = 0
    kyoku.jikaze     = TON
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.reach_num  = 0
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 80, teyaku.fu_num
    assert_equal 3, teyaku.han_num
    assert_equal 1, teyaku.mangan_scale
    assert_equal 12000, teyaku.total_point
    assert_equal 0, teyaku.parent_point
    assert_equal 4000, teyaku.child_point
    assert_equal 0, teyaku.ron_point
    assert_equal 2, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "bakazenan")
    assert_equal true, teyaku_include?(teyaku, "honitsu")
  end

  #http://homepage2.nifty.com/syusui/majyn/mondai.html
  #解答(f)
  #親の50符２飜は4800点＋900点
  #＠解説　七対子は50符１飜(25符２飜でも可)で計算する。
  #→特殊な例　役は立直(１飜)と七対子(１飜)。３本場なの
  #で900点を忘れてはダメ。もし自摸っていれば9600点＋900点。 
  def test_case_1_f
    # input
    pai_items = "m2 m2 m3 m3 m4 m4 p8 p8 s2 s2 s4 s8 s8 s4 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false
    kyoku.dora_num   = 0
    kyoku.bakaze     = TON
    kyoku.honba_num  = 3
    kyoku.jikaze     = TON
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.reach_num  = 0
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 25, teyaku.fu_num
    assert_equal 3, teyaku.han_num
    assert_equal 0, teyaku.mangan_scale
    assert_equal 5700, teyaku.total_point
    assert_equal 0, teyaku.parent_point
    assert_equal 0, teyaku.child_point
    assert_equal 5700, teyaku.ron_point
    assert_equal 2, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "tanyao")
    assert_equal true, teyaku_include?(teyaku, "chitoitsu")
  end

  #http://homepage2.nifty.com/syusui/majyn/mondai.html
  #解答(g)
  #子の40符３飜は5200点
  #＠解説　雀頭( 東東 )の２符＋９萬の暗刻( 9w9w9w )の８符＋和了の符の２符
  #＝12符で符ハネして40符(32符)。役は三色(２飜)と自摸(１飜)。ロン和了なら
  #2600点と寂しい。もし 東 を自摸っていれば満貫(8000点)、この場合ロンでも
  #40符(34符)で5200点となる。 
  def test_case_1_g
    # input
    pai_items = "m5 m6 m7 m9 m9 p5 p6 p7 s5 s6 s7 j1 j1 m9 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = true
    kyoku.dora_num   = 0
    kyoku.bakaze     = TON
    kyoku.honba_num  = 0
    kyoku.jikaze     = PEI
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.reach_num  = 0
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 40, teyaku.fu_num
    assert_equal 3, teyaku.han_num
    assert_equal 0, teyaku.mangan_scale
    assert_equal 5200, teyaku.total_point
    assert_equal 2600, teyaku.parent_point
    assert_equal 1300, teyaku.child_point
    assert_equal 0, teyaku.ron_point
    assert_equal 2, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "tsumo")
    assert_equal true, teyaku_include?(teyaku, "sanshoku")
  end


  #http://homepage2.nifty.com/syusui/majyn/mondai.html
  #解答(h)
  #子の70符２飜は4500点
  #＠解説　中の暗槓( 裏中中裏 )の32符＋９萬の明刻( 9w9w9wb )の４符＋４萬の
  #明刻( 4w4w4wb )の２符＋雀頭( 南南 )の４符＝42符は符ハネして70符(62符)。
  #役は三元牌(中)(１飜)とドラ１(１飜)。連風牌の雀頭は４符になることに注意。
  #しかしこの手、かなり派手に動いた割には寒い。とてもドラそばが出てくるとは
  #思えん。('-'; 
  def test_case_1_h
    # input
    pai_items = "s5 s6 j2 j2 j7 j7 j7 j7 s4 m4 m4 m4lm9 m9 m9l".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false
    kyoku.dora_num   = 1
    kyoku.bakaze     = NAN
    kyoku.honba_num  = 0
    kyoku.jikaze     = NAN
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.reach_num  = 0
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 70, teyaku.fu_num
    assert_equal 2, teyaku.han_num
    assert_equal 0, teyaku.mangan_scale
    assert_equal 4500, teyaku.total_point
    assert_equal 0, teyaku.parent_point
    assert_equal 0, teyaku.child_point
    assert_equal 4500, teyaku.ron_point
    assert_equal 1, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "chun")
  end


  #http://homepage2.nifty.com/syusui/majyn/mondai.html
  #解答(i)
  #子の50符２飜は3200点＋900点
  #＠解説　白の明刻( 白白白b )の４符＋９萬の暗刻( 9w9w9w )の８符＋９筒の暗刻
  #( 9p9p9p )の８符＋辺張待ち( 8s9s )の２符＝22符は符ハネして50符(42符)。
  #役は三元牌(白)(１飜)と鳴き全帯(１飜)。３本場の900点を忘れてはダメ。
  #自摸っても同じ点数ですが、もし 8s であがれば、三色同刻と三暗刻と対々和
  #という役がつくので一気に跳満(12000点)＋900点になりますし、 8s の代わりに
  #ヤオ九牌をうまく手にいれる事が出来れば混老頭という役までつくので倍満
  #(16000点)＋900点にまで化けてしまいます。なんかもったいないですね。('▽'; 
  def test_case_1_i
    # input
    pai_items = "m9 m9 m9 p9 p9 p9 s8 s9 s9 s9 s7 j5 j5 j5l".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false
    kyoku.dora_num   = 0
    kyoku.bakaze     = NAN
    kyoku.honba_num  = 3
    kyoku.jikaze     = PEI
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.reach_num  = 0
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 50, teyaku.fu_num
    assert_equal 2, teyaku.han_num
    assert_equal 0, teyaku.mangan_scale
    assert_equal 4100, teyaku.total_point
    assert_equal 0, teyaku.parent_point
    assert_equal 0, teyaku.child_point
    assert_equal 4100, teyaku.ron_point
    assert_equal 2, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "haku")
    assert_equal true, teyaku_include?(teyaku, "chanta")
  end




  #http://homepage2.nifty.com/syusui/majyn/mondai.html
  # 解答(j)
  #親の110符１飜は5300点
  #＠解説　北の暗槓( 裏北北裏 )の32符＋９索の暗槓( 裏9s9s裏 )の32符＋
  #発の明刻( 発発発b )の４符＋雀頭( 東東 )の４符＝72符は符ハネしまくりで
  #110符(102符)。役は三元牌(発)(１飜)。う～ん、１飜の最高役です、
  #これ以上の符(110符以上)はありません。
  def test_case_1_j
    # input
    pai_items = "m6 m7 m8 j1 j1 j6 j6 s9 s9 s9 s9 j4 j4 j4 j4 j6 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false
    kyoku.dora_num   = 0
    kyoku.bakaze     = TON
    kyoku.honba_num  = 0
    kyoku.jikaze     = TON
    kyoku.is_parent  = true
    kyoku.reach_num  = 0
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 110, teyaku.fu_num
    assert_equal 1, teyaku.han_num
    assert_equal 0, teyaku.mangan_scale
    assert_equal 5300, teyaku.total_point
    assert_equal 0, teyaku.parent_point
    assert_equal 0, teyaku.child_point
    assert_equal 5300, teyaku.ron_point
    assert_equal 1, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "hatsu")
  end


  #http://mjclv.com/calc/mondai03.html
  # 回答：50符2ハンの3200点
  #解説：役牌×2。メンゼンロン30符に東(1,9,字牌)の暗刻+8符と、西の暗刻+8符なので合計46符となり、切り上げて50符となる（補足：数牌（2～8牌）の暗刻は+4符）。
  def test_case_2_1_1
    # input
    pais = "j1 j1 j1 j3 j3 j3 s3 s3 s3 s4 s5 p4 p5 p6 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false # ツモ？
    kyoku.bakaze     = TON   # 場風
    kyoku.honba_num  = 0     # 本場
    kyoku.dora_num   = 0     # ドラ
    kyoku.reach_num  = 0     # リーチ
    kyoku.jikaze     = SHA   # 自風
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pais,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 50, teyaku.fu_num , "符"
    assert_equal 2, teyaku.han_num , "翻"
    assert_equal 0, teyaku.mangan_scale , "○倍満"
    assert_equal 3200 , teyaku.total_point , "総得点"
    assert_equal 2, teyaku.yaku_list.size, "役の数"
    assert_equal true, teyaku_include?(teyaku, "jikazesha")
    assert_equal true, teyaku_include?(teyaku, "bakazeton")
  end

  #http://mjclv.com/calc/mondai03.html
  # 回答：40符3ハンの1300点2600点
  #解説：役牌×2+ツモ。20符に暗刻の+16符と、ツモ+2符なので38符となり、切り上げて40符となる。
  def test_case_2_1_1
    # input
    pais = "j1 j1 j1 j3 j3 j3 s3 s3 s3 s4 s5 p4 p5 p6 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = true # ツモ？
    kyoku.bakaze     = TON   # 場風
    kyoku.honba_num  = 0     # 本場
    kyoku.dora_num   = 0     # ドラ
    kyoku.reach_num  = 0     # リーチ
    kyoku.jikaze     = SHA   # 自風
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pais,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 40, teyaku.fu_num , "符"
    assert_equal 3, teyaku.han_num , "翻"
    assert_equal 0, teyaku.mangan_scale , "○倍満"
    assert_equal 5200 , teyaku.total_point , "総得点"
    assert_equal 3, teyaku.yaku_list.size, "役の数"
    assert_equal true, teyaku_include?(teyaku, "jikazesha")
    assert_equal true, teyaku_include?(teyaku, "bakazeton")
    assert_equal true, teyaku_include?(teyaku, "tsumo")
  end

  #http://mjclv.com/calc/mondai03.html
  # 回答：40符2ハンの2600点
  # 解説：役牌+イーペイコー。メンゼンロン30符に東の暗刻+8符に西(役牌)のトイツ+2符なので40符となる。
  # 補足：オタ風のトイツは+0符
  def test_case_2_2_1
    # input
    pais = "j1 j1 j1 j3 j3 s3 s3 s4 s4 s5 s5 p7 p8 p9 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false # ツモ？
    kyoku.bakaze     = TON   # 場風
    kyoku.honba_num  = 0     # 本場
    kyoku.dora_num   = 0     # ドラ
    kyoku.reach_num  = 0     # リーチ
    kyoku.jikaze     = SHA   # 自風
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pais,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 40, teyaku.fu_num , "符"
    assert_equal 2, teyaku.han_num , "翻"
    assert_equal 0, teyaku.mangan_scale , "○倍満"
    assert_equal 2600 , teyaku.total_point , "総得点"
    assert_equal 2, teyaku.yaku_list.size, "役の数"
    assert_equal true, teyaku_include?(teyaku, "iipeikou")
    assert_equal true, teyaku_include?(teyaku, "bakazeton")
  end

  #http://mjclv.com/calc/mondai03.html
  #回答：40符3ハンの1300点2600点
  #解説：役牌+イーペイコー+ツモ。20符に役牌の8符と、役牌トイツの2符と、ツモの2符なので32符となり、切り上げて40符となる。
  def test_case_2_2_2
    # input
    pais = "j1 j1 j1 j3 j3 s3 s3 s4 s4 s5 s5 p7 p8 p9 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = true # ツモ？
    kyoku.bakaze     = TON   # 場風
    kyoku.honba_num  = 0     # 本場
    kyoku.dora_num   = 0     # ドラ
    kyoku.reach_num  = 0     # リーチ
    kyoku.jikaze     = SHA   # 自風
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pais,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 40, teyaku.fu_num , "符"
    assert_equal 3, teyaku.han_num , "翻"
    assert_equal 0, teyaku.mangan_scale , "○倍満"
    assert_equal 5200 , teyaku.total_point , "総得点"
    assert_equal 3, teyaku.yaku_list.size, "役の数"
    assert_equal true, teyaku_include?(teyaku, "iipeikou")
    assert_equal true, teyaku_include?(teyaku, "bakazeton")
    assert_equal true, teyaku_include?(teyaku, "tsumo")
  end


  #http://mjclv.com/calc/mondai03.html
  # 回答：40符1ハンの1300点
  #解説：役牌のみ。メンゼンロン30符に字牌の暗刻+8符とカンチャンの+2符なので40符となる。（北はオタ風のトイツなので+0符）
  def test_case_2_3_1
    # input
    pais = "j1 j1 j1 j4 j4 s3 s4 s5 p2 p3 p4 p6 p8 p7 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = false # ツモ？
    kyoku.bakaze     = TON   # 場風
    kyoku.honba_num  = 0     # 本場
    kyoku.dora_num   = 0     # ドラ
    kyoku.reach_num  = 0     # リーチ
    kyoku.jikaze     = SHA   # 自風
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pais,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 40, teyaku.fu_num , "符"
    assert_equal 1, teyaku.han_num , "翻"
    assert_equal 0, teyaku.mangan_scale , "○倍満"
    assert_equal 1300 , teyaku.total_point , "総得点"
    assert_equal 1, teyaku.yaku_list.size, "役の数"
    assert_equal true, teyaku_include?(teyaku, "bakazeton")
  end

  #http://mjclv.com/calc/mondai03.html
  #回答：40符2ハンの700点1300点
  #解説:役牌+ツモ。20符に字牌の暗刻+8符と、カンチャンの+2符と、ツモの2符なので32符となり、切り上げて40符となる。
  def test_case_2_3_2
    # input
    pais = "j1 j1 j1 j4 j4 s3 s4 s5 p2 p3 p4 p6 p8 p7 ".gsub!(" ","t")
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = true # ツモ？
    kyoku.bakaze     = TON   # 場風
    kyoku.honba_num  = 0     # 本場
    kyoku.dora_num   = 0     # ドラ
    kyoku.reach_num  = 0     # リーチ
    kyoku.jikaze     = SHA   # 自風
    kyoku.is_parent  = kyoku.jikaze == TON
    kyoku.is_ippatsu = false
    kyoku.is_haitei  = false
    kyoku.is_tenho   = false
    kyoku.is_chiho   = false
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pais,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal 40, teyaku.fu_num , "符"
    assert_equal 2, teyaku.han_num , "翻"
    assert_equal 0, teyaku.mangan_scale , "○倍満"
    assert_equal 2700 , teyaku.total_point , "総得点"
    assert_equal 2, teyaku.yaku_list.size, "役の数"
    assert_equal true, teyaku_include?(teyaku, "bakazeton")
    assert_equal true, teyaku_include?(teyaku, "tsumo")
  end




  def teyaku_include?(teyaku,yaku_name)
    teyaku.yaku_list.each{|yaku|
      return true if yaku.name == yaku_name
    }
    return false
  end


end

