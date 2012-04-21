#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-
require 'pp'
require 'hpricot'
require 'yaml'

WORD = {
  "東" => "ton",
  "南" => "nan",
  "西" => "sha",
  "北" => "pei",
  "１" => "1",
  "２" => "2",
  "３" => "3",
  "４" => "4",
  "５" => "5",
  "６" => "6",
  "７" => "7",
  "８" => "8",
  "９" => "9",
  "p1" => "p1t",
  "p2" => "p2t",
  "p3" => "p3t",
  "p4" => "p4t",
  "p5" => "p5t",
  "p6" => "p6t",
  "p7" => "p7t",
  "p8" => "p8t",
  "p9" => "p9t",
  "s1" => "s1t",
  "s2" => "s2t",
  "s3" => "s3t",
  "s4" => "s4t",
  "s5" => "s5t",
  "s6" => "s6t",
  "s7" => "s7t",
  "s8" => "s8t",
  "s9" => "s9t",
  "m1" => "m1t",
  "m2" => "m2t",
  "m3" => "m3t",
  "m4" => "m4t",
  "m5" => "m5t",
  "m6" => "m6t",
  "m7" => "m7t",
  "m8" => "m8t",
  "m9" => "m9t",
  "p1y" => "p1l",
  "p2y" => "p2l",
  "p3y" => "p3l",
  "p4y" => "p4l",
  "p5y" => "p5l",
  "p6y" => "p6l",
  "p7y" => "p7l",
  "p8y" => "p8l",
  "p9y" => "p9l",
  "s1y" => "s1l",
  "s2y" => "s2l",
  "s3y" => "s3l",
  "s4y" => "s4l",
  "s5y" => "s5l",
  "s6y" => "s6l",
  "s7y" => "s7l",
  "s8y" => "s8l",
  "s9y" => "s9l",
  "m1y" => "m1l",
  "m2y" => "m2l",
  "m3y" => "m3l",
  "m4y" => "m4l",
  "m5y" => "m5l",
  "m6y" => "m6l",
  "m7y" => "m7l",
  "m8y" => "m8l",
  "m9y" => "m9l",
  "gton" => "j1t",
  "gnan" => "j2t",
  "gsya" => "j3t",
  "gpei" => "j4t",
  "ghaku" => "j5t",
  "ghatsu" => "j6t",
  "gtyun" => "j7t",
  "gtony" => "j1l",
  "gnany" => "j2l",
  "gsyay" => "j3l",
  "gpeiy" => "j4l",
  "ghakuy" => "j5l",
  "ghatsuy" => "j6l",
  "gtyuny" => "j7l",
  "ura" => "z0t",
  "平和" => "pinfu",
  '立直'=>'reach',
  'リーチ'=>'reach',
  '一発'=>'ippatsu',
  '断幺九'=>'tanyao',
  'タンヤオ'=>'tanyao',
  '平和'=>'pinfu',
  '三色同順'=>'sanshoku',
  '三色同刻'=>'sanshokudouko',
  '一盃口'=>'iipeikou',
  '自摸'=>'tsumo',
  'ツモ'=>'tsumo',
  '白'=>'haku',
  '發'=>'hatsu',
  '中'=>'chun',
  '嶺上開花'=>'rinshan',
  '一気通貫'=>'ikkitsukan',
  '一通'=>'ikkitsukan',
  '混全帯'=>'chanta',
  'チャンタ'=>'chanta',
  '対々和'=>'toitoihou',
  'トイトイ'=>'toitoihou',
  '三暗刻'=>'sanankou',
  '混老頭'=>'honroutou',
  '三槓子'=>'sankantsu',
  '小三元'=>'shousangen',
  'ダブル立直'=>'doublereach',
  'Ｗリーチ'=>'doublereach',
  '七対子'=>'chitoitsu',
  '混一色'=>'honitsu',
  'ホンイツ'=>'honitsu',
  'メンホン'=>'honitsu',
  '純チャン'=>'junchan',
  '二盃口'=>'ryanpeikou',
  'ニ盃口'=>'ryanpeikou',
  '清一色'=>'chinitsu',
  'チンイツ'=>'chinitsu',
  '槍槓'=>'chankan',
  '海底摸月'=>'haitei',
  'ハイテイ'=>'haitei',
  '河底撈魚'=>'houtei',
  'ホウテイ'=>'houtei',
  '国士無双'=>'kokushi',
  '四暗刻'=>'suuankou',
  '大三元'=>'daisangen',
  '字一色'=>'tsuuiisou',
  '小四喜'=>'shousuushii',
  '大四喜'=>'daisuushii',
  '緑一色'=>'ryuuiisou',
  '清老頭'=>'chinroutou',
  '四槓子'=>'suukantsu',
  '九蓮宝燈'=>'chuurennpoutou',
  '天和'=>'tenhou',
  '地和'=>'chihou',
  'ドラ'=>'dora',
  "dummy" => "dummy"
}

def term(key)
  if WORD.key?(key)
    return WORD[key]
  else
    raise "unknown key #{key}"
  end
end

#http://dora12.com/2/yakuten/3mon.php
def parse(file)

  hash = {:kyoku => {} ,:pai => {} ,:score => {}, :info=> {}}
  hash[:info][:url] = "http://dora12.com/2/yakuten/" + file

  html= File.open(file).read()

  hash[:score][:yaku] = []
  hash[:pai][:menzen] = []
  hash[:pai][:naki] = []

  html.split("\n").each do |line|
    # "[東場][南家]"
    if /\[.場\]\[.家\]/ =~ line
      hash[:kyoku][:bakaze] = term($&[1,1])
      hash[:kyoku][:jikaze] = term($&[5,1])
    end

    # "<img src=\"../../image/p1.gif\" border=\"0\" alt=\"1筒\"><img src=\"../../image/p2.gif\" border=\"0\" alt=\"2筒\"><img src=\"../../image/p4.gif\" border=\"0\" alt=\"4筒\"><img src=\"../../image/p4.gif\" border=\"0\" alt=\"4筒\"><img src=\"../../image/p6.gif\" border=\"0\" alt=\"6筒\"><img src=\"../../image/p7.gif\" border=\"0\" alt=\"7筒\"><img src=\"../../image/p8.gif\" border=\"0\" alt=\"8筒\">　<img src=\"../../image/p8y.gif\" border=\"0\" alt=\"8筒\"><img src=\"../../image/p6.gif\" border=\"0\" alt=\"6筒\"><img src=\"../../image/p7.gif\" border=\"0\" alt=\"7筒\"><img src=\"../../image/gpei.gif\" border=\"0\" alt=\"北\"><img src=\"../../image/gpeiy.gif\" border=\"0\" alt=\"北\"><img src=\"../../image/gpei.gif\" border=\"0\" alt=\"北\"><br>"
    if /(<img .*>　*){13,}/ =~ line
      menzen = $&.split("　")[0]
      doc = Hpricot(menzen)
      doc.search("img").each do | tag |
        hash[:pai][:menzen] << term(tag.attributes['src'].split("/")[3].split(".")[0])
      end
      if $&.split("　").size == 2
        naki = $&.split("　")[1] 
        doc = Hpricot(naki)
        doc.search("img").each do | tag |
          hash[:pai][:naki] << term(tag.attributes['src'].split("/")[3].split(".")[0])
        end
      end
    end

    # "ロン：<img src=\"../../image/m4.gif\" border=\"0\" alt=\"4萬\"><br>"
    if /^ツモ：.*/ =~ line || /^ロン：.*/ =~ line
      doc = Hpricot($&)
      doc.search("img").each do | tag |
        hash[:pai][:agari] = term(tag.attributes['src'].split("/")[3].split(".")[0])
      end
      if /^ツモ：.*/ =~ line
        hash[:kyoku][:is_tsumo] = true
      else
        hash[:kyoku][:is_tsumo] = false
      end
    end

    # "リーチ：有り<br>"
    if /リーチ：有り/ =~ line
      hash[:kyoku][:reach_num] = 1
    end
    # "Ｗリーチ：有り<br>"
    if /Ｗリーチ：有り/ =~ line
      hash[:kyoku][:reach_num] = 2
    end
    # "ハイテイ：有り<br>"
    if /ハイテイ：有り/ =~ line
      hash[:kyoku][:is_haitei] = true
    end

    # "<a href=\"../../1/yaku/pinhu.php\">平和</a><br>"
    if  /.*href.*\/yaku\/.*/ =~ line
      doc = Hpricot($&)
      doc.search("a").each do | tag |
        if tag.innerHTML == "門風牌"
          hash[:score][:yaku] << "jikaze" + hash[:kyoku][:jikaze]
        elsif tag.innerHTML == "荘風牌"
          hash[:score][:yaku] << "bakaze" + hash[:kyoku][:bakaze]
        elsif tag.innerHTML == "飜牌"
          if /發/ =~ line
            hash[:score][:yaku] << "hatsu"
          elsif /中/ =~ line
            hash[:score][:yaku] << "chun"
          elsif /白/ =~ line
            hash[:score][:yaku] << "haku"
          elsif
            pais = []
            pais.concat(hash[:pai][:menzen])
            pais.concat(hash[:pai][:naki])
            pais.push(hash[:pai][:agari])
            pais = pais.map {|e| e[0,2]}
            sangen = ["j5","j6","j7","z0"]
            sangen_no = {"j5" =>0 ,"j6" =>0 ,"j7" =>0 ,"z0" => 0}
            pais.each do |pai|
              sangen.each do |san|
                sangen_no[san] += 1 if pai == san
              end
            end

            if sangen_no["j5"] > 2
              hash[:score][:yaku] << "haku"
            elsif sangen_no["j6"] > 2
              hash[:score][:yaku] << "hatsu"
            elsif sangen_no["j7"] > 2
              hash[:score][:yaku] << "chun"
            else
p hash[:pai][:naki].index("z0t") + 1
              if sangen_no["j5"] == 2 && sangen_no["z0"] > 1  &&
                  hash[:pai][:naki][(hash[:pai][:naki].index("z0t") + 1)] == "j5t"
                hash[:score][:yaku] << "haku"
              elsif sangen_no["j6"] == 2 && sangen_no["z0"] > 1 &&
                  hash[:pai][:naki][(hash[:pai][:naki].index("z0t") + 1)] == "j6t"
                hash[:score][:yaku] << "hatsu"
              elsif sangen_no["j7"] == 2 && sangen_no["z0"] > 1 &&
                  hash[:pai][:naki][(hash[:pai][:naki].index("z0t") + 1)] == "j7t"
                hash[:score][:yaku] << "chun"
              elsif /^110/ =~ file
                hash[:score][:yaku] << "haku"
              elsif /^124/ =~ file
                hash[:score][:yaku] << "jikazeton"
              elsif /^83/ =~ file
                hash[:score][:yaku] << "chun"
              else
                hash[:score][:yaku] << "TODO"
              end
            end
          end
        else
          hash[:score][:yaku] << term(tag.innerHTML)
        end
      end
    end

    # "ドラ１<br>"
    if  /^ドラ.<br>/ =~ line
      hash[:kyoku][:dora_num] = term($&[2])
    end

    # "30符１飜"
    if /\d+符.*飜/ =~ line
      hash[:score][:fu_nam] = $&.split("符")[0].to_i
      hash[:score][:han_num] = term($&.split("符")[1].split("飜")[0]).to_i
    end

    if /\d+00点/ =~ line
      hash[:score][:total_point] =  $&.split("点")[0].to_i
    end
  end
  hash[:kyoku][:reach_num] = 0 if hash[:kyoku][:reach_num].nil?
  hash[:kyoku][:dora_num] = 0 if hash[:kyoku][:dora_num].nil?
  hash[:kyoku][:is_haitei] = false if hash[:kyoku][:is_haitei].nil?

  hash[:kyoku][:is_rinshan] = false
  hash[:kyoku][:is_chankan] = false
  hash[:kyoku][:honba_num] = false
  hash[:kyoku][:is_ippatsu] = false
  hash[:kyoku][:is_tenho]   = false
  hash[:kyoku][:is_chiho]   = false
  hash[:kyoku][:is_parent]  =  hash[:kyoku][:jikaze] == "ton"

  return hash
end


print  YAML.dump parse(ARGV[0])
