# -*- coding: utf-8 -*-
module Mjt
 module Analysis
  class Agari
    attr_accessor :id, #Agariオブジェクトの識別子 
    :is_tsumo, #ツモ(true)かロン(false)かを示す 	false 	
    :is_haitei, #海底摸月かどうかを示す 	false 	
    :dora_num,  #ドラ牌の枚数を示す 	
    :bakaze,  	#場風を示す 	'none' 	
    :jikaze, 	# 	自風を示す 	'none' 	
    :honba_num, #本場数を示す 	0 	
    :is_rinshan, #りんしゃん開花かどうかを示す 	false 	
    :is_chankan, #槍槓かどうかを示す 	false 	
    :reach_num,  #立直の種類を示す 	0 	
    :is_ippatsu,  #一発かどうかを示す 	false 	
    :is_tenho,  #天和かどうかを示す 	false 	
    :is_chiho,  #地和かどうかを示す 	false 	
    :is_parent, #親(true)か子(false)かを示す 	false 	
    :total_fu_num, #終的な符数を示す 	null 	
    :total_han_num, #最終的な翻数を示す 	null 	
    :yaku_list, 	#全ての役を示す 	null 	
    :mangan_scale, #満貫の倍数を示す 	null 	
    :total_point, 	#総点数を示す 	null 	
    :parent_point, #親が払う点数を示す 	null 	
    :child_point, 	#子が払う点数を示す 	null 	
    :tehai_img, 	#手牌画像 	- 	◯
    :tehai_list 	#手牌の解析結果を示す 	null
    
    #		def initialize(mentsui, atamai)
    #        @mentsu_list     =  mentsui
    #        @atama   = atamai
    #        @is_agari = is_agar
    #		end
    
  end
 end
end

