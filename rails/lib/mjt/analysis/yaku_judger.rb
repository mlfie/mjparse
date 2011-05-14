module Mjt::Analysis
  # 役を得る
  
  #カンは未対応
  #国士＋チートイツ
  class YakuJudger
		attr_accessor :result,
					  :agari,
					  :funclist

	    def initialize(resultin, agariin)
			@result     = resultin
			@agari   = agariin
			@funclist = Array.new()
		end

		##################以下メインメソッド#############################################
		
		#外部から呼び出されるメソッド
		def outmethod()
		
				#適用する役リスト
				funclist = [[isTanyao, "Tanyao"], [isPinfu, "Pinfu"]]
				
				#　役判定メソッドを反復適用（trueの場合役リストに追加）		
				funclist.each do |func|
					if func[0]
						result.yaku_list.push(func[1])
					end
				end
				
				p result.yaku_list
				return "hoge"
		end
	
		#################以下役判定用内部呼び出しメソッド郡###############################
	
		#タンヤオ判定メソッド
		def isTanyao()
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
			#コーツなし判定
			result.mentsu_list.each do |mentsu|
					if mentsu[0].number == mentsu[1].number || mentsu[1].number == mentsu[2].number
						return false
					end
			end
			
			
			
	

			return true
		end
		
		#イーペーコー判定メソッド
		def isEepeko()
			
		end
  end
end