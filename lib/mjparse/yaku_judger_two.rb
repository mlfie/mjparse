# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'pai')
require File.join(File.dirname(__FILE__), 'mentsu')

# 役判定（2飜）を行うクラスメソッド群
module Mjparse
  module YakuJudgerTwo
    ### ダブル立直
    def doublereach?(tehai, kyoku)
      kyoku.doublereach?
    end

    ### 七対子
    def chitoitsu?(tehai, kyoku)
      tehai.mentsu_list.size == 6
    end

    ### 混全帯么九
    def chanta?(tehai, kyoku)
      # 頭と全ての面子がヤオチュウ牌であること
      return false unless tehai.atama.yaochu? and tehai.mentsu_list.all? {|mentsu| mentsu.yaochu? }

      # 必ず一つは字牌があること
      return false unless tehai.atama.jihai? or tehai.mentsu_list.any?{|mentsu| mentsu.jihai? }

      # 必ず一つは数牌があること
      return false unless tehai.atama.suhai? or tehai.mentsu_list.any?{|mentsu| mentsu.suhai? }

      # 必ず一つは順子があること
      return false unless tehai.mentsu_list.any?{|mentsu| mentsu.shuntsu? }

      return true
    end

    ### 一気通貫
    def ikkitsukan?(tehai, kyoku)
      flag_onetwothree = false
      flag_fourfivesix = false
      flag_seveneightnine = false
      
      #マンズ
      tehai.shuntsu_list.each do |mentsu|
        if mentsu.identical.manzu?
          case mentsu.identical.number
          when 1
            flag_onetwothree = true  
          when 4
            flag_fourfivesix = true
          when 7
            flag_seveneightnine = true
          end
        end
      end       
      if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
        return true
      end

      flag_onetwothree = false
      flag_fourfivesix = false
      flag_seveneightnine = false
      
      #ソウズ
      tehai.shuntsu_list.each do |mentsu|
        if mentsu.identical.souzu?
          case mentsu.identical.number
          when 1
            flag_onetwothree = true  
          when 4
            flag_fourfivesix = true
          when 7
            flag_seveneightnine = true
          end
        end
      end       
      if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
        return true
      end

      flag_onetwothree = false
      flag_fourfivesix = false
      flag_seveneightnine = false
      
      #ピンズ
      tehai.shuntsu_list.each do |mentsu|
        if mentsu.identical.pinzu?
          case mentsu.identical.number
          when 1
            flag_onetwothree = true  
          when 4
            flag_fourfivesix = true
          when 7
            flag_seveneightnine = true
          end
        end
      end       
      if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
        return true
      end

      return false
    end

    ### 三色同順
    def sanshoku?(tehai, kyoku)
      tehai.shuntsu_list.each do |mentsu|
        tehai.shuntsu_list.each do |mentsu2|
          next unless mentsu.identical.type != mentsu2.identical.type
          next unless mentsu.identical.number == mentsu2.identical.number
          tehai.shuntsu_list.each do |mentsu3|
            next unless mentsu.identical.type != mentsu3.identical.type && mentsu2.identical.type != mentsu3.identical.type
            return true if mentsu.identical.number == mentsu3.identical.number                    
          end
        end 
      end
      return false
    end
    
    ### 三色同刻
    def sanshokudouko?(tehai, kyoku)
      tehai.koutsu_list.each do | mentsu |
        tehai.koutsu_list.each do | mentsu2 |
          next unless mentsu.identical.type != mentsu2.identical.type
          next unless  mentsu.identical.number == mentsu2.identical.number
          tehai.koutsu_list.each do | mentsu3 |
            next unless mentsu.identical.type != mentsu3.identical.type && mentsu2.identical.type != mentsu3.identical.type
            return true if mentsu.identical.number == mentsu3.identical.number
          end
        end
      end
      return false
    end

    ### 対々和
    def toitoihou?(tehai, kyoku)
      # 特殊系ではない かつ 全ての面子が刻子ならOK
      return false if tehai.tokusyu?
      tehai.mentsu_list.all?{|mentsu| mentsu.koutsu? }
    end

    ### 三暗刻
    def sanankou?(tehai, kyoku)
      return false if tehai.tokusyu?
      tehai.koutsu_list.count{|mentsu| !mentsu.furo } >= 3
    end
      
    ### 三槓子
    def sankantsu?(tehai, kyoku)
      return false if tehai.tokusyu?
      tehai.kantsu_list.count >= 3
    end
  
      
    ### 小三元
    def shousangen?(tehai, kyoku)
      #頭が三元牌じゃなかったらfalse
      return false unless tehai.atama.sangenpai?
      
      #三元牌の刻子、槓子があること
      has_haku = tehai.koutsu_list.any? {|mentsu| mentsu.identical.haku? }
      has_hatsu = tehai.koutsu_list.any? {|mentsu| mentsu.identical.hatsu? }
      has_chun = tehai.koutsu_list.any? {|mentsu| mentsu.identical.chun? }
     
      return (has_haku && has_hatsu) || (has_haku && has_chun) || (has_hatsu && has_chun) 
    end
    
    ### 混老頭
    def honroutou?(tehai, kyoku)
      # 頭がヤオチュウ牌であること
      return false unless tehai.atama.yaochu?

      # 全ての面子がヤオチュウ牌関連 かつ 刻子であること
      return false unless tehai.mentsu_list.all?{|mentsu| mentsu.koutsu? and mentsu.yaochu? }
      
      # 必ず一つは字牌があること
      return false unless tehai.atama.jihai? or tehai.mentsu_list.any?{|mentsu| mentsu.jihai? }

      # 必ず一つは数牌があること
      return false unless tehai.atama.suhai? or tehai.mentsu_list.any?{|mentsu| mentsu.suhai? }

      return true
    end
  end
end
