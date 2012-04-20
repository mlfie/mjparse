# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'pai')
require File.join(File.dirname(__FILE__), 'mentsu')

# 役判定（3飜〜6飜）を行うクラスメソッド群
module Mjparse
  module YakuJudgerThreeSix
  
    ### 二盃口
    def ryanpeikou?(tehai, agari)
      ryanpeikou_count = 0
      tehai.shuntsu_list.each_with_index do |mentsu_1,i|
        tehai.shuntsu_list.each_with_index do |mentsu_2,j|
          if i != j 
            ipeikou_count = 0
            ryanpeikou_count += 1 if mentsu_1 == mentsu_2
          end
        end
      end
      if ryanpeikou_count == 4
        return true
      end
      return false
    end
    
    ### 混一色
    def honitsu?(tehai, agari)
      fetchtype = nil
      tehai.mentsu_list.each do | mentsu |		
        if not mentsu.jihai?
          fetchtype = mentsu.identical.type
        end
      end  
      return false if fetchtype.nil?

      tehai.mentsu_list.each do | mentsu2 |		
        if !mentsu2.jihai? && mentsu2.identical.type != fetchtype
          return false
         end
      end
      return true
    end
    
    ### 純全帯么九
    def junchan?(tehai, agari)
      # 全ての頭と面子が老頭牌で構成されていること
      return false unless tehai.atama.raotou? and tehai.mentsu_list.all?{|mentsu| mentsu.raotou? }

      # 必ず一つは順子をもつこと
      return false unless tehai.mentsu_list.any?{|mentsu| mentsu.shuntsu? }

      return true
    end

    ### 清一色
    def chinitsu?(tehai, agari)
      return false if tehai.atama.jihai?

      beforetype = tehai.atama.type
      tehai.mentsu_list.all?{|mentsu| mentsu.identical.type == beforetype}
    end

  end
end
