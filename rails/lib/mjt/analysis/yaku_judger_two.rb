# -*- coding: utf-8 -*-

# 役判定（2飜）を行うクラスメソッド群
module Mjt
  module Analysis
    class YakuJudger
      ### ダブル立直
      def self.doublereach?(tehai, agari)
        if agari.reach_num == "2"
          return true
        end
        return false
      end

      ### 七対子
      def self.chitoitsu?(tehai, agari)
	    if tehai.mentsu_list.size == "7"
           return true
        end
        return false
      end

      ### 混全帯么九
      def self.chanta?(tehai, agari)
	    jihai_count = 0
		kotsu_count = 0
        tehai.mentsu_list.each do | mentsu |
          if mentsu.mentsu_type == "k" || mentsu.mentsu_type == "t"
		     if mentsu.pai_list[0].type != "j"
                if mentsu.pai_list[0].number != "1" && mentsu.pai_list[0].number != "9"
				   return false
				else
					kotsu_count += 1
				end
             else
                jihai_count += 1
				kotsu_count += 1
             end			 
		  end
		  
		  if mentsu.mentsu_type == "s"
		     if mentsu.pai_list[0].number != "1" && mentsu.pai_list[0].number != "7"
			   return false
			 end
		  end
		  
		  if mentsu.mentsu_type == "y"
		    return false
		  end
		  ### ホンラオトーでないかつ、ジュンチャンでない
		  if jihai_count != 0 && kotsu_count != 5
		    return true
		  end
		  return false
		end
	  end

      ### 一気通貫
      def self.ikkitsukan?(tehai, agari)
        tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == "s" && mentsu.pai_list[0].number == "1"
            tehai.mentsu_list.each do | mentsu2|
              if mentsu2.mentsu_type == "s" && mentsu.pai_list[0].number == "4" && mentsu.pai_list[0].type == mentsu2.pai_list[0].type
                tehai.mentsu_list.each do | mentsu3|
                  if mentsu3.mentsu_type == "s" && mentsu.pai_list[0].number == "7" && mentsu.pai_list[0].type == mentsu3.pai_list[0].type            
                    return true
                  end
                end
              end
            end
          end
        end
        return false
      end

      ### 三色同順
      def self.sanshoku?(tehai, agari)
        tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == "s"
            tehai.mentsu_list.each do | mentsu2|
              if mentsu2.mentsu_type == "s" && mentsu.pai_list[0].type != mentsu2.pai_list[0].type
                if mentsu.pai_list[0].number == mentsu2.pai_list[0].number
                  tehai.mentsu_list.each do | mentsu3|
                    if mentsu3.mentsu_type == "s" && mentsu.pai_list[0].type != mentsu3.pai_list[0].type && mentsu2.pai_list[0].type != mentsu3.pai_list[0].type
                      if mentsu.pai_list[0].number == mentsu3.pai_list[0].number                    
                        return true
                      end
                    end
                  end
                end
              end
            end
          end
        end
        return false
      end
      
      ### 三色同刻
      def self.sanshokudouko?(tehai, agari)
	    tehai.mentsu_list.each do | mentsu |
          if mentsu.mentsu_type == "k" || mentsu.mentsu_type == "4"
            tehai.mentsu_list.each do | mentsu2 |
              if mentsu2.mentsu_type == "k"  || mentsu.mentsu_type == "4"
			    if mentsu.pai_list[0].type != mentsu2.pai_list[0].type
                  if mentsu.pai_list[0].number == mentsu2.pai_list[0].number
                    tehai.mentsu_list.each do | mentsu3 |
                      if mentsu3.mentsu_type == "k" || mentsu.mentsu_type == "4"
					    if mentsu.pai_list[0].type != mentsu3.pai_list[0].type && mentsu2.pai_list[0].type != mentsu3.pai_list[0].type
                          if mentsu.pai_list[0].number == mentsu3.pai_list[0].number                    
                            return true
                          end
                        end
					  end	
                    end
                  end
                end
			  end
            end
          end
		end  
		return false
      end

      ### 対々和
      def self.toitoihou?(tehai, agari)
        if tehai.mentsu_list.size == "4"
		  tehai.mentsu_list.each do | mentsu| 
		    if mentsu.mentsu_type != "k"
     		  if mentsu.mentsu_type != "t"
			    return false
			  end
			end
          end
          return true		  
		end
		return false
      end

      ### 三暗刻
      def self.sanankou?(tehai, agari)
	    count = 0
	    tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == "k" && mentsu.furo == false
		    count += 1
		  end
		end
		if count > 2
		  return true
		end
	    return false
	  end
        
      ### 三槓子
      def self.sankantsu?(tehai, agari)
	    count = 0
	    tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == "4"
		    count += 1
		  end
		end
		if count > 2
		  return true
		end
	    return false
      end
	  
        
      ### 小三元
      def self.shousangen?(tehai, agari)
		if tehai.mentsu_list.size == "4"
	      tehai.mentsu_list.each do | mentsu|
		    if mentsu.pai_list[0].type == "5"
		      tehai.mentsu_list.each do | mentsu2|
		   	    if mentsu.pai_list[0].type == "6"
                  tehai.mentsu_list.each do | mentsu3|
                    if mentsu.pai_list[0].type == "7"                 
                      return true
                    end
                  end
                end
              end
            end
		  end
        end			
	    return false
      end
	  
	  
    end
  end
end
