# -*- coding: utf-8 -*-
require 'test_helper'
require 'yaml'
class TotalTestByYaml < Test::Unit::TestCase

  TON = Mjparse::Kyoku::KYOKU_KAZE_TON
  NAN = Mjparse::Kyoku::KYOKU_KAZE_NAN
  SHA = Mjparse::Kyoku::KYOKU_KAZE_SHA
  PEI = Mjparse::Kyoku::KYOKU_KAZE_PEI

  KAZE = { "ton" => TON, "nan" => NAN, "sha" => SHA, "pei" => PEI}

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


  def test_1; sub(1); end
  def test_2; sub(2); end
  def test_3; sub(3); end
  def test_4; sub(4); end
  def test_5; sub(5); end
  def test_6; sub(6); end
  def test_7; sub(7); end
  def test_8; sub(8); end
  def test_9; sub(9); end
  def test_10; sub(10); end
  def test_11; sub(11); end
  def test_12; sub(12); end
  def test_13; sub(13); end
  def test_14; sub(14); end
  def test_15; sub(15); end
  def test_16; sub(16); end
  def test_17; sub(17); end
  def test_18; sub(18); end
  def test_19; sub(19); end
  def test_20; sub(20); end
  def test_21; sub(21); end
  def test_22; sub(22); end
  def test_23; sub(23); end
  def test_24; sub(24); end
  def test_25; sub(25); end
  def test_26; sub(26); end
  def test_27; sub(27); end
  def test_28; sub(28); end
  def test_29; sub(29); end
  def test_30; sub(30); end
  def test_31; sub(31); end
  def test_32; sub(32); end
  def test_33; sub(33); end
  def test_34; sub(34); end
  def test_35; sub(35); end
  def test_36; sub(36); end
  def test_37; sub(37); end
  def test_38; sub(38); end
  def test_39; sub(39); end
  def test_40; sub(40); end
  def test_41; sub(41); end
  def test_42; sub(42); end
  def test_43; sub(43); end
  def test_44; sub(44); end
  def test_45; sub(45); end
  def test_46; sub(46); end
  def test_47; sub(47); end
  def test_48; sub(48); end
  def test_49; sub(49); end
  def test_50; sub(50); end
  def test_51; sub(51); end
  def test_52; sub(52); end
  def test_53; sub(53); end
  def test_54; sub(54); end
  def test_55; sub(55); end
  def test_56; sub(56); end
  def test_57; sub(57); end
  def test_58; sub(58); end
  def test_59; sub(59); end
  def test_60; sub(60); end
  def test_61; sub(61); end
  def test_62; sub(62); end
  def test_63; sub(63); end
  def test_64; sub(64); end
  def test_65; sub(65); end
  def test_66; sub(66); end
  def test_67; sub(67); end
  def test_68; sub(68); end
  def test_69; sub(69); end
  def test_70; sub(70); end
  def test_71; sub(71); end
  def test_72; sub(72); end
  def test_73; sub(73); end
  def test_74; sub(74); end
  def test_75; sub(75); end
  def test_76; sub(76); end
  def test_77; sub(77); end
  def test_78; sub(78); end
  def test_79; sub(79); end
  def test_80; sub(80); end
  def test_81; sub(81); end
  def test_82; sub(82); end
  def test_83; sub(83); end
  def test_84; sub(84); end
  def test_85; sub(85); end
  def test_86; sub(86); end
  def test_87; sub(87); end
  def test_88; sub(88); end
  def test_89; sub(89); end
  def test_90; sub(90); end
  def test_91; sub(91); end
  def test_92; sub(92); end
  def test_93; sub(93); end
  def test_94; sub(94); end
  def test_95; sub(95); end
  def test_96; sub(96); end
  def test_97; sub(97); end
  def test_98; sub(98); end
  def test_99; sub(99); end
  def test_100; sub(100); end
  def test_101; sub(101); end
  def test_102; sub(102); end
  def test_103; sub(103); end
  def test_104; sub(104); end
  def test_105; sub(105); end
  def test_106; sub(106); end
  def test_107; sub(107); end
  def test_108; sub(108); end
  def test_109; sub(109); end
  def test_110; sub(110); end
  def test_111; sub(111); end
  def test_112; sub(112); end
  def test_113; sub(113); end
  def test_114; sub(114); end
  def test_115; sub(115); end
  def test_116; sub(116); end
  def test_117; sub(117); end
  def test_118; sub(118); end
  def test_119; sub(119); end
  def test_120; sub(120); end
  def test_121; sub(121); end
  def test_122; sub(122); end
  def test_123; sub(123); end
  def test_124; sub(124); end
  def test_125; sub(125); end
  def test_126; sub(126); end
  def test_127; sub(127); end
  def test_128; sub(128); end
  def test_129; sub(129); end
  def test_130; sub(130); end
  def test_131; sub(131); end
  def test_132; sub(132); end
  def test_133; sub(133); end
  def test_134; sub(134); end
  def test_135; sub(135); end
  def test_136; sub(136); end
  def test_137; sub(137); end
  def test_138; sub(138); end
  def test_139; sub(139); end
  def test_140; sub(140); end
  def test_141; sub(141); end
  def test_142; sub(142); end
  def test_143; sub(143); end
  def test_144; sub(144); end
  def test_145; sub(145); end
  def test_146; sub(146); end
  def test_147; sub(147); end
  def test_148; sub(148); end
  def test_149; sub(149); end
  def test_150; sub(150); end
  def test_151; sub(151); end
  def test_152; sub(152); end
  def test_153; sub(153); end
  def test_154; sub(154); end
  def test_155; sub(155); end
  def test_156; sub(156); end
  def test_157; sub(157); end
  def test_158; sub(158); end
  def test_159; sub(159); end
  def test_160; sub(160); end
  def test_161; sub(161); end
  def test_162; sub(162); end
  def test_163; sub(163); end
  def test_164; sub(164); end
  def test_165; sub(165); end
  def test_166; sub(166); end
  def test_167; sub(167); end
  def test_168; sub(168); end
  def test_169; sub(169); end
  def test_170; sub(170); end
  def test_171; sub(171); end
  def test_172; sub(172); end
  def test_173; sub(173); end
  def test_174; sub(174); end
  def test_175; sub(175); end
  def test_176; sub(176); end
  def test_177; sub(177); end
  def test_178; sub(178); end
  def test_179; sub(179); end
  def test_180; sub(180); end
  def test_181; sub(181); end
  def test_182; sub(182); end
  def test_183; sub(183); end
  def test_184; sub(184); end
  def test_185; sub(185); end
  def test_186; sub(186); end
  def test_187; sub(187); end
  def test_188; sub(188); end
  def test_189; sub(189); end
  def test_190; sub(190); end
  def test_191; sub(191); end
  def test_192; sub(192); end
  def test_193; sub(193); end
  def test_194; sub(194); end
  def test_195; sub(195); end
  def test_196; sub(196); end
  def test_197; sub(197); end
  def test_198; sub(198); end
  def test_199; sub(199); end
  def test_200; sub(200); end
  def test_201; sub(201); end
  def test_202; sub(202); end
  def test_203; sub(203); end
  def test_204; sub(204); end
  def test_205; sub(205); end
  def test_206; sub(206); end
  def test_207; sub(207); end
  def test_208; sub(208); end
  def test_209; sub(209); end
  def test_210; sub(210); end
  def test_211; sub(211); end
  def test_212; sub(212); end
  def test_213; sub(213); end
  def test_214; sub(214); end
  def test_215; sub(215); end
  def test_216; sub(216); end
  def test_217; sub(217); end
  def test_218; sub(218); end
  def test_219; sub(219); end
  def test_220; sub(220); end
  def test_221; sub(221); end
  def test_222; sub(222); end
  def test_223; sub(223); end
  def test_224; sub(224); end
  def test_225; sub(225); end
  def test_226; sub(226); end
  def test_227; sub(227); end
  def test_228; sub(228); end
  def test_229; sub(229); end
  def test_230; sub(230); end



  def sub(test_no)
    yaml = YAML.load(File.open("test/fixtures/#{test_no}.yaml"))
    #pp yaml
    
    # input
    pai_items = yaml[:pai][:menzen].join("")
    pai_items += yaml[:pai][:agari]
    pai_items += yaml[:pai][:naki].join("")
    
    kyoku = Mjparse::Kyoku.new
    kyoku.is_tsumo   = yaml[:kyoku][:is_tsumo]
    kyoku.is_haitei  = yaml[:kyoku][:is_haitei]
    kyoku.dora_num   = yaml[:kyoku][:dora_num].to_i
    kyoku.bakaze     = KAZE[yaml[:kyoku][:bakaze]]
    kyoku.jikaze     = KAZE[yaml[:kyoku][:jikaze]]
    kyoku.honba_num  = 0
    kyoku.is_rinshan = yaml[:kyoku][:is_rinshan]
    kyoku.is_chankan = yaml[:kyoku][:is_rinshan]
    kyoku.reach_num  = yaml[:kyoku][:reach_num]
    kyoku.is_ippatsu = yaml[:kyoku][:is_ippatsu]
    kyoku.is_tenho   = yaml[:kyoku][:is_tenho]
    kyoku.is_chiho   = yaml[:kyoku][:is_chiho]
    kyoku.is_parent  = kyoku.jikaze == TON
    # run
    td = Mjparse::TeyakuDecider.new
    td.get_agari_teyaku(pai_items,kyoku,@yaku_specimen)
    teyaku = td.teyaku
    # check
    assert_equal 0, td.result_code
    assert_equal yaml[:score][:fu_nam], teyaku.fu_num, "TestNo#{test_no}.符が違う"
    assert_equal yaml[:score][:han_num], teyaku.han_num,"TestNo#{test_no}.翻数が違う"
    assert_equal yaml[:score][:total_point], teyaku.total_point,"TestNo#{test_no}.合計点が違う"
    assert_equal yaml[:score][:yaku].size, teyaku.yaku_list.size,"TestNo#{test_no}.役の数違う（ドラは除く）"
    yaml[:score][:yaku].each do | yakuname |
      assert_equal true, teyaku_include?(teyaku, yakuname),"TestNo#{test_no}.役「#{yakuname}」が有るべきだが無い"
    end
  end


  def teyaku_include?(teyaku,yaku_name)
    teyaku.yaku_list.each{|yaku|
      return true if yaku.name == yaku_name
    }
    return false
  end


end

