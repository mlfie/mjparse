# -*- coding: utf-8 -*-
require 'test_helper'

class YakuJudgerTest < Test::Unit::TestCase

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
    @yaku_specimen['ton'] = Mjparse::YakuSpecimen.new('ton','東',1,1)
    @yaku_specimen['nan'] = Mjparse::YakuSpecimen.new('nan','南',1,1)
    @yaku_specimen['sha'] = Mjparse::YakuSpecimen.new('sha','西',1,1)
    @yaku_specimen['pei'] = Mjparse::YakuSpecimen.new('pei','北',1,1)
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
  def test_case_a
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
  def test_case_b
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
  #＠解説南の明刻( 南南南b )の４符加算で30符(24符)。役は鳴き混一色(２飜)と場風(１飜)。ちなみに 3w 6w 7w 8w 9w の多面張待ちで、その中でも１番安目で上がったことになる。それぞれの牌で上がった場合の点数は、 3w の場合、ロン・自摸和了どちらも3900点、 7w 8w の場合、ロン・自摸和了どちらも5200点、 6w 9w の場合、ロン・自摸和了どちらも8000点、とかなり開きがある。特にこういった局面(南４局＝オーラス)では、トップとの点差や自分の着順をよく考え、当たり牌や振りこんでくれる相手を選択するといった戦略が大変需要である。
  def test_case_c
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
    assert_equal 3, teyaku.yaku_list.size
    assert_equal true, teyaku_include?(teyaku, "honitsu")
    assert_equal true, teyaku_include?(teyaku, "nan")
  end

  def teyaku_include?(teyaku,yaku_name)
    teyaku.yaku_list.each{|yaku|
      return true if yaku.name == yaku_name
    }
    return false
  end
end

