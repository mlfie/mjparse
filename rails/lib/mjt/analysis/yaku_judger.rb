# -*- coding: utf-8 -*-
module Mjt::Analysis::YakuJudger
  
  def set_yaku_list(result, agari)
    
    #適用する役リスト
    funclist = [[isTanyao, "Tanyao"], [isPinfu, "Pinfu"]]
    
    yaku_list = []

    #　役判定メソッドを反復適用（trueの場合役リストに追加）		
    funclist.each do |func|
      if func[0](result, agari) then
        yaku_list << Yakus.find_by_name(func[1])
      end
    end

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
