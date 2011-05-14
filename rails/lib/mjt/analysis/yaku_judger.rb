# -*- coding: utf-8 -*-

require 'mjt/analysis/teyaku_decider'

module Mjt
module Analysis
class YakuJudger

  def self.set_yaku_list(result, agari)

    yaku_list = Array.new
    if  isTanyao(result, agari) then
      yaku_list << Yaku.find_by_name("tanyao")
    end

    result.yaku_list = yaku_list
  end

  #################以下役判定用内部呼び出しメソッド郡###############################

  #タンヤオ判定メソッド
  def self.isTanyao(result, agari)
    if result.atama.yaochu?
      return false
    end
    result.mentsu_list.each do |mentsu|
      mentsu.pai_list.each do | pai |
        if pai.yaochu?
          return false
        end
      end
    end
    return true
  end

  #ピンフ判定メソッド
  def self.isPinfu(result, agari)
    # TODP
    return true
  end

  #イーペーコー判定メソッド
  def self.isEepeko(result, agari)
    return true
  end


end
end
end
