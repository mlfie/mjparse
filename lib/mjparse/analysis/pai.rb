# -*- coding: utf-8 -*-

module Mjparse
  module Analysis
    class Pai
      # 牌の種類
      PAI_TYPE_MANZU      = 'm'
      PAI_TYPE_SOUZU      = 's'
      PAI_TYPE_PINZU      = 'p'
      PAI_TYPE_JIHAI      = 'j'
      PAI_TYPE_REVERSE    = 'r' 
      
      # 字牌を表現する数字
      PAI_NUMBER_TON      = 1
      PAI_NUMBER_NAN      = 2
      PAI_NUMBER_SHA      = 3
      PAI_NUMBER_PEI      = 4
      PAI_NUMBER_HAKU     = 5
      PAI_NUMBER_HATSU    = 6
      PAI_NUMBER_CHUN     = 7
      PAI_NUMBER_REVERSE  = 0
      
      # 牌の向き
      PAI_DIRECT_TOP      = 't'
      PAI_DIRECT_LEFT     = 'l'
      PAI_DIRECT_BUTTOM   = 'b'
      PAI_DIRECT_RIGHT    = 'r'

      attr_accessor :type,    # 牌の種類(m:萬子 s:索子 p:筒子 j:字牌 r:背面牌)
                    :number,  # 数字(字牌の場合 1:東 2:南 3:西 4:北 5:白 6:發 7:中、背面牌の場合 0:背面牌)
                    :naki,    # 鳴き牌かどうか(true, false)
                    :agari    # アガリ牌かどうか(true, false)

      # 初期化メソッド
      def initialize(tehai_str)
        self.type     = tehai_str[0,1]
        self.number   = tehai_str[1,1].to_i
        if tehai_str[2,1] == Pai::PAI_DIRECT_TOP || tehai_str[2,1] == Pai::PAI_DIRECT_BUTTOM then
          self.naki   = false
        elsif tehai_str[2,1] == Pai::PAI_DIRECT_LEFT || tehai_str[2,1] == Pai::PAI_DIRECT_RIGHT then
          self.naki   = true
        end
        self.agari    = false
      end
    
      def ==(pai)
        if pai != nil then
          if self.type == pai.type && self.number == pai.number then
            return true
          end
        end
        return false
      end

      # 幺九牌の判定
      def yaochu?
        return self.number == 1 || self.number == 9 || self.type == PAI_TYPE_JIHAI
      end
    
      # 中張牌の判定
      def chunchan?
        return ! yaochu?
      end
      
      # 萬子かどうか
      def manzu?
        return self.type == PAI_TYPE_MANZU
      end
      
      # 索子かどうか
      def souzu?
        return self.type == PAI_TYPE_SOUZU
      end
      
      # 筒子かどうか
      def pinzu?
        return self.type == PAI_TYPE_PINZU
      end
      
      # 字牌かどうか
      def jihai?
        return self.type == PAI_TYPE_JIHAI
      end
      
      # 東かどうか
      def ton?
        return jihai? && self.number == PAI_NUMBER_TON
      end
      
      # 南かどうか
      def nan?
        return jihai? && self.number == PAI_NUMBER_NAN
      end
      
      # 西かどうか
      def sha?
        return jihai? && self.number == PAI_NUMBER_SHA
      end
      
      # 北かどうか
      def pei?
        return jihai? && self.number == PAI_NUMBER_PEI
      end
      
      # 白かどうか
      def haku?
        return jihai? && self.number == PAI_NUMBER_HAKU
      end
      
      # 發かどうか
      def hatsu?
        return jihai? && self.number == PAI_NUMBER_HATSU
      end
      
      # 中かどうか
      def chun?
        return jihai? && self.number == PAI_NUMBER_CHUN
      end
    end
  end
end
