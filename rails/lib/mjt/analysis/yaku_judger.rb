# -*- coding: utf-8 -*-

require 'mjt/analysis/teyaku_decider'

module Mjt
module Analysis
class YakuJudger
  
  def set_yaku_list(result, agari)
    
    yaku_list = Array.new
    yaku_list << Yakus.find_by_name("tanyao") if  isTanyao(result, agari)
    yaku_list << Yakus.find_by_name("pinfu") if  isPinfu(result, agari)

    result.yaku_list = yaku_list
  end
  
  #################以下役判定用内部呼び出しメソッド郡###############################
  
  #タンヤオ判定メソッド
  def isTanyao(result, agari)
    result.mentsu_list.each do |mentsu|
      mentsu.each do | pai |
        if pai.number == 1 || pai.number == 9 || pai.type == "j"
          return false
        end
      end
    end
    result.atama.each do |atam_pi|
      if atam_pi.number == 1 || atam_pi.number == 9 || atam_pi.type == "j"
        return false
      end
    end
    return true
  end
  
  #ピンフ判定メソッド
  def isPinfu()
    # TODP
    return true
  end
  
  #イーペーコー判定メソッド
  def isEepeko()
    return true
  end
end
end
end
