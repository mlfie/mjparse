# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'pai')
require File.join(File.dirname(__FILE__), 'mentsu')
require File.join(File.dirname(__FILE__), 'tehai')
require File.join(File.dirname(__FILE__), 'kyoku')
require File.join(File.dirname(__FILE__), 'yaku_specimen')

module Mjparse
  module Analysis
    #############################
    # 得点を計算するクラス          #
    #############################
    class ScoreCalculator
      
      ### 処理結果
      RESULT_SUCCESS            = 0 # 正常終了
      RESULT_ERROR_INTERNAL     = 9 # 不明な内部エラー

      # 満貫以上の飜数
      HAN_NUMBER_THREE          =  3 # 3飜
      HAN_NUMBER_FOUR           =  4 # 4飜
      HAN_NUMBER_MANGAN         =  5 # 満貫
      HAN_NUMBER_HANEMAN_MIN    =  6 # ハネ満(下限)
      HAN_NUMBER_HANEMAN_MAX    =  7 # ハネ満(上限)
      HAN_NUMBER_BAIMAN_MIN     =  8 # 倍満(下限)
      HAN_NUMBER_BAIMAN_MAX     = 10 # 倍満(上限)
      HAN_NUMBER_SANBAIMAN_MIN  = 11 # 三倍満(下限)
      HAN_NUMBER_SANBAIMAN_MAX  = 12 # 三倍満(上限)
      HAN_NUMBER_YAKUMAN        = 13 # 役満(下限)
      
      # 満貫以上の倍数
      MANGAN_SCALE_MANGAN       = 1   # 満貫
      MANGAN_SCALE_HANEMAN      = 1.5 # ハネ満
      MANGAN_SCALE_BAIMAN       = 2   # 倍満
      MANGAN_SCALE_SANBAIMAN    = 3   # 三倍満
      MANGAN_SCALE_YAKUMAN      = 4   # 役満
      
      # 満貫の点数
      MANGAN_POINT_PARENT       = 12000 # 親の満貫の点数
      MANGAN_POINT_CHILD        =  8000 # 子の満貫の点数
    
      # 得点を計算して結果を返す
      def self.calculate_point(tehai, kyoku)
        tehai.fu_num        = self.calc_fu(tehai, kyoku)
        tehai.han_num       = self.calc_han(tehai)
        tehai.mangan_scale  = self.calc_mangan_scale(tehai, kyoku)
        base_point          = self.calc_base_point(tehai, kyoku)
        tehai.parent_point  = self.calc_parent_point(base_point, kyoku)
        tehai.child_point   = self.calc_child_point(base_point, kyoku)
        tehai.ron_point     = self.calc_ron_point(base_point, kyoku)        
        tehai.total_point   = self.calc_total_point(tehai, kyoku)
        return tehai
      end
    
#      private
#*****************************************************************#
# step1. 符を計算する
#*****************************************************************#
      def self.calc_fu(tehai, kyoku)
        ###--------------- 七対子 ---------------###
        tehai.yaku_list.each do |yaku|
          if yaku.name == YakuSpecimen::YAKU_NAME_CHITOITSU then
             return 25
          end
        end

        ###--------------- 副底 ---------------###
        # 基本符20符 
        total_fu = 20
        
        # 門前で他家から出和了りした場合10符加算
        if !kyoku.is_tsumo then
          menzen_ron = true
          tehai.mentsu_list.each do |mentsu|
            if mentsu.furo then
              menzen_ron = false
            end
          end
          if menzen_ron then
            total_fu += 10
          end
        end
        
        ###--------------- 雀頭 ---------------###
        if tehai.atama.type == Pai::PAI_TYPE_JIHAI
          # 風牌の場合
          if Pai::PAI_NUMBER_TON <= tehai.atama.number && tehai.atama.number <= Pai::PAI_NUMBER_PEI then
            # 自風の計算
            if tehai.atama.number == Pai::PAI_NUMBER_TON && Kyoku::KYOKU_KAZE_TON then
              total_fu += 2
            elsif tehai.atama.number == Pai::PAI_NUMBER_NAN && Kyoku::KYOKU_KAZE_NAN then
              total_fu += 2
            elsif tehai.atama.number == Pai::PAI_NUMBER_SHA && Kyoku::KYOKU_KAZE_SHA then
              total_fu += 2
            elsif tehai.atama.number == Pai::PAI_NUMBER_PEI && Kyoku::KYOKU_KAZE_PEI then
              total_fu += 2
            end
            # 場風の計算
            if tehai.atama.number == Pai::PAI_NUMBER_TON && Kyoku::KYOKU_KAZE_TON then
              total_fu += 2
            elsif tehai.atama.number == Pai::PAI_NUMBER_NAN && Kyoku::KYOKU_KAZE_NAN then
              total_fu += 2
            elsif tehai.atama.number == Pai::PAI_NUMBER_SHA && Kyoku::KYOKU_KAZE_SHA then
              total_fu += 2
            elsif tehai.atama.number == Pai::PAI_NUMBER_PEI && Kyoku::KYOKU_KAZE_PEI then
              total_fu += 2
            end
          # 三元牌の場合
          elsif Pai::PAI_NUMBER_HAKU <= tehai.atama.number && tehai.atama.number <= Pai::PAI_NUMBER_CHUN then
            total_fu += 2
          end
        end
      
        ###--------------- 順子 ---------------###
        # 順子による符の加算は無い

        ###--------------- 刻子 ---------------###
        tehai.mentsu_list.each do |mentsu|
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KOUTSU then
            # 幺九牌の場合
            if mentsu.pai_list[0].yaochu? then
              # 明刻の場合
              if mentsu.furo then
                total_fu += 4
              # 暗刻の場合
              else
                total_fu += 8
              end
            # 中張牌の場合
            else
              # 明刻の場合
              if mentsu.furo then
                total_fu += 2
              # 暗刻の場合
              else
                total_fu += 4
              end
            end
          end
        end
      
        ###--------------- 槓子 ---------------###
        tehai.mentsu_list.each do |mentsu|
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KANTSU then
            # 幺九牌の場合
            if mentsu.pai_list[0].yaochu? then
              # 明刻の場合
              if mentsu.furo then
                total_fu += 16
              # 暗刻の場合
              else
                total_fu += 32
              end
            # 中張牌の場合
            else
              # 明刻の場合
              if mentsu.furo then
                total_fu += 8
              # 暗刻の場合
              else
                total_fu += 16
              end
            end
          end
        end
        
        ###--------------- 待ち形 ---------------###
        # 辺張待ちの場合
        if tehai.penchan_agari? then
          total_fu += 2
        # 嵌張待ちの場合
        elsif tehai.kanchan_agari? then
          total_fu += 2
        # 単騎待ちの場合
        elsif tehai.tanki_agari? then
          total_fu += 2
        end

        ###--------------- 自摸和了 ---------------###
        if kyoku.is_tsumo then
          pinfu_flg = false
          tehai.yaku_list.each do |yaku|
            if yaku.name == YakuSpecimen::YAKU_NAME_PINFU then
              pinfu_flg = true
              break
            end
          end
          if !pinfu_flg then
            total_fu += 2
          end
        end
      
        return self.ceil_one_level(total_fu)
      end
    
#*****************************************************************#
# step2. 飜を計算する
#*****************************************************************#
      def self.calc_han(tehai)
        total_han = 0
        # 全て門前面子の場合
        if !tehai.furo then
          tehai.yaku_list.each do |yaku|
            total_han += yaku.han_num
          end
        # 副露面子を含む場合(食い下がりが発生)
        else
          tehai.yaku_list.each do |yaku|
            total_han += yaku.naki_han_num
          end
        end

        return total_han
      end
    
#*****************************************************************#
# step3. 満貫の倍数を計算する
#*****************************************************************#
      def self.calc_mangan_scale(tehai, kyoku)
        scale = 0
        case tehai.han_num
          when HAN_NUMBER_THREE then
            if tehai.fu_num >= 70 then
              scale = MANGAN_SCALE_MANGAN
            end
          when HAN_NUMBER_FOUR then
            if tehai.fu_num >= 40 then
              scale = MANGAN_SCALE_MANGAN
            end
          when HAN_NUMBER_MANGAN then
            scale = MANGAN_SCALE_MANGAN
          when HAN_NUMBER_HANEMAN_MIN..HAN_NUMBER_HANEMAN_MAX then
            scale = MANGAN_SCALE_HANEMAN
          when HAN_NUMBER_BAIMAN_MIN..HAN_NUMBER_BAIMAN_MAX then
            scale = MANGAN_SCALE_BAIMAN
          when HAN_NUMBER_SANBAIMAN_MIN.. HAN_NUMBER_SANBAIMAN_MAX then
            scale = MANGAN_SCALE_SANBAIMAN
          else
            scale = MANGAN_SCALE_YAKUMAN * ( tehai.han_num / HAN_NUMBER_YAKUMAN )
        end
        return scale
      end
    
#*****************************************************************#
# step4. 符と翻から得点を計算する
#*****************************************************************#
      def self.calc_base_point(tehai, kyoku)
        point = 0
        # 親の場合の点数を計算
        if kyoku.is_parent
          if tehai.han_num == 1 then
            case tehai.fu_num
              # 食い平和形を含めている
              when 20..30 then
                point = 1500
              when 40 then
                point = 2000
              when 50 then
                point = 2400
              when 60 then
                point = 2900
              when 70 then
                point = 3400
              when 80 then
                point = 3900
              when 90 then
                point = 4400
              when 100 then
                point = 4800
              when 110 then
                point = 5300
            end
          elsif tehai.han_num == 2 then
            case tehai.fu_num
              when 20 then
                point = 2000
              when 25 then
                point = 2400
              when 30 then
                point = 2900
              when 40 then
                point = 3900
              when 50 then
                point = 4800
              when 60 then
                point = 5800
              when 70 then
                point = 6800
              when 80 then
                point = 7700
              when 90 then
                point = 8700
              when 100 then
                point = 9600
              when 110 then
                point = 10600
            end
          elsif tehai.han_num == 3 then
            case tehai.fu_num
              when 20 then
                point = 3900
              when 25 then
                point = 4800
              when 30 then
                point = 5800
              when 40 then
                point = 7700
              when 50 then
                point = 9600
              when 60 then
                point = 11600
              when 70..110 then
                point = 12000
            end
          elsif tehai.han_num == 4 then
            case tehai.fu_num
              when 20 then
                point = 7700
              when 25 then
                point = 9600
              when 30 then
                point = 11600
              when 40..110 then
                point = 12000
            end
          elsif HAN_NUMBER_MANGAN <= tehai.han_num then
            point = MANGAN_POINT_PARENT * tehai.mangan_scale
          end
        # 子の場合の点数を計算
        else
          if tehai.han_num == 1 then
            case tehai.fu_num
              # 食い平和形を含めている
              when 20..30 then
                point = 1000
              when 40 then
                point = 1300
              when 50 then
                point = 1600
              when 60 then
                point = 2000
              when 70 then
                point = 2300
              when 80 then
                point = 2600
              when 90 then
                point = 2900
              when 100 then
                point = 3200
              when 110 then
                point = 3600
            end
          elsif tehai.han_num == 2 then
            case tehai.fu_num
              when 20 then
                point = 1300
              when 25 then
                point = 1600
              when 30 then
                point = 2000
              when 40 then
                point = 2600
              when 50 then
                point = 3200
              when 60 then
                point = 3900
              when 70 then
                point = 4500
              when 80 then
                point = 5200
              when 90 then
                point = 5800
              when 100 then
                point = 6400
              when 110 then
                point = 7100
            end
          elsif tehai.han_num == 3 then
            case tehai.fu_num
              when 20 then
                point = 2600
              when 25 then
                point = 3200
              when 30 then
                point = 3900
              when 40 then
                point = 5200
              when 50 then
                point = 6400
              when 60 then
                point = 7700
              when 70..110 then
                point = 8000
            end
          elsif tehai.han_num == 4 then
            case tehai.fu_num
              when 20 then
                point = 5200
              when 25 then
                point = 6400
              when 30 then
                point = 7700
              when 40..110 then
                point = 8000
            end
          elsif HAN_NUMBER_MANGAN <= tehai.han_num then
            point = MANGAN_POINT_CHILD * tehai.mangan_scale
          end
        end
        return point
      end
    
#*****************************************************************#
# step5. ツモアガリの際に親が払う点数を計算する
#*****************************************************************#
      def self.calc_parent_point(base_point, kyoku)
        point = 0
        # ツモアガリの場合
        if kyoku.is_tsumo then
          # 自分のツモアガリなので支払いは無し
          if kyoku.is_parent then
            point = 0
          # 子のツモアガリは半分が親、残りの4分の1ずつを子から頂く
          else
            point = base_point / 2 + kyoku.honba_num * 100
          end
        end
        return self.ceil_ten_level(point)
      end

#*****************************************************************#
# step6. ツモアガリの際に子が払う点数を計算する
#*****************************************************************#
      def self.calc_child_point(base_point, kyoku)
        point = 0
        # ツモアガリの場合
        if kyoku.is_tsumo then
          # 親のツモアガリは3分の1ずつを子から頂く
          if kyoku.is_parent then
            point = base_point / 3 + kyoku.honba_num * 100
          # 子のツモアガリは半分が親、残りの4分の1ずつを子から頂く
          else
            point = base_point / 4 + kyoku.honba_num * 100
          end
        end
        return self.ceil_ten_level(point)
      end
    
#*****************************************************************#
# step7. ロンアガリの際に放銃した人が払う点数を計算する
#*****************************************************************#
      def self.calc_ron_point(base_point, kyoku)
        point = 0
        # ロンアガリの場合
        if !kyoku.is_tsumo then
          point = base_point + kyoku.honba_num * 300
        end
        return self.ceil_ten_level(point)
      end

#*****************************************************************#
# step8. 最終的な総得点を計算する
#*****************************************************************#
      def self.calc_total_point(tehai, kyoku)
        point = 0
        # ツモアガリの場合
        if kyoku.is_tsumo then
          # 親のツモアガリの場合、子からそれぞれ同じ点数を頂く
          if kyoku.is_parent then
            point = tehai.child_point * 3
          # 子のツモアガリの場合、親と子2人からそれぞれ頂く
          else
            point = tehai.parent_point + tehai.child_point * 2
          end
        else
          point = tehai.ron_point
        end
        return point
      end
    
#*****************************************************************#
# ユーティリティ系
#*****************************************************************#
      def self.ceil_one_level(point)
        return ( ( point + 9 ) / 10 ).truncate * 10
      end
    
      def self.ceil_ten_level(point)
        return ( ( point + 90 ) / 100 ).truncate * 100
      end
    end
  end
end
