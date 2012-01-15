# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'pai')
require File.join(File.dirname(__FILE__), 'mentsu')
require File.join(File.dirname(__FILE__), 'yaku_judger_three_six')

# 役判定（役満）を行うクラスメソッド群
module Mjparse
  module YakuJudgerMan

    # 国士無双
    def kokushi?(tehai, agari)
      # メンツが特殊系かどうか
      tehai.mentsu_list.each do |mentsu|
        if !mentsu.tokusyu?
          return false
        end
      end
      # 頭とメンツで公九牌が13種類以上あること
      count = 0
      # m1
      if tehai.atama.number == 1 && tehai.atama.type == Pai::PAI_TYPE_MANZU
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list do |pai|
            if pai.number == 1 && pai.type == Pai::PAI_TYPE_MANZU
              count += 1
            end
          end
        end
      end
      # m9
      if tehai.atama.number == 9 && tehai.atama.type == Pai::PAI_TYPE_MANZU
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == 9 && pai.type == Pai::PAI_TYPE_MANZU
              count += 1
            end
          end
        end
      end
      # s1
      if tehai.atama.number == 1 && tehai.atama.type == Pai::PAI_TYPE_SOUZU
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == 1 && pai.type == Pai::PAI_TYPE_SOUZU
              count += 1
            end
          end
        end
      end
      # s9
      if tehai.atama.number == 9 && tehai.atama.type == Pai::PAI_TYPE_SOUZU
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == 9 && pai.type == Pai::PAI_TYPE_SOUZU
              count += 1
            end
          end
        end
      end
      # p1
      if tehai.atama.number == 1 && tehai.atama.type == Pai::PAI_TYPE_PINZU
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == 1 && pai.type == Pai::PAI_TYPE_PINZU
              count += 1
            end
          end
        end
      end
      # p9
      if tehai.atama.number == 9 && tehai.atama.type == Pai::PAI_TYPE_PINZU
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == 9 && pai.type == Pai::PAI_TYPE_PINZU
              count += 1
            end
          end
        end
      end
      # 東
      if tehai.atama.number == Pai::PAI_NUMBER_TON && tehai.atama.type == Pai::PAI_TYPE_JIHAI
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == Pai::PAI_NUMBER_TON && pai.type == Pai::PAI_TYPE_JIHAI
              count += 1
            end
          end
        end
      end
      # 南
      if tehai.atama.number == Pai::PAI_NUMBER_NAN && tehai.atama.type == Pai::PAI_TYPE_JIHAI
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == Pai::PAI_NUMBER_NAN && pai.type == Pai::PAI_TYPE_JIHAI
              count += 1
            end
          end
        end
      end
      # 西
      if tehai.atama.number == Pai::PAI_NUMBER_SHA && tehai.atama.type == Pai::PAI_TYPE_JIHAI
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == Pai::PAI_NUMBER_SHA && pai.type == Pai::PAI_TYPE_JIHAI
              count += 1
            end
          end
        end
      end
      # 北
      if tehai.atama.number == Pai::PAI_NUMBER_PEI && tehai.atama.type == Pai::PAI_TYPE_JIHAI
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == Pai::PAI_NUMBER_PEI && pai.type == Pai::PAI_TYPE_JIHAI
              count += 1
            end
          end
        end
      end
      # 白
      if tehai.atama.number == Pai::PAI_NUMBER_HAKU && tehai.atama.type == Pai::PAI_TYPE_JIHAI
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == Pai::PAI_NUMBER_HAKU && pai.type == Pai::PAI_TYPE_JIHAI
              count += 1
            end
          end
        end
      end
      # 発
      if tehai.atama.number == Pai::PAI_NUMBER_HATSU && tehai.atama.type == Pai::PAI_TYPE_JIHAI
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == Pai::PAI_NUMBER_HATSU && pai.type == Pai::PAI_TYPE_JIHAI
              count += 1
            end
          end
        end
      end
      # 中
      if tehai.atama.number == Pai::PAI_NUMBER_CHUN && tehai.atama.type == Pai::PAI_TYPE_JIHAI
        count += 1
      else
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.number == Pai::PAI_NUMBER_CHUN && pai.type == Pai::PAI_TYPE_JIHAI
              count += 1
            end
          end
        end
      end

      if count >= 12
        return true
      end
              
      return false
    end

    # 四暗刻
    def suankou?(tehai, agari)
      return false if tehai.tokusyu?
      tehai.mentsu_list.all?{|mentsu| mentsu.koutsu? and not mentsu.furo }
    end
  
    # 大三元
    def daisangen?(tehai, agari)
      return false unless tehai.koutsu_list.any?{|mentsu| mentsu.identical.haku? }
      return false unless tehai.koutsu_list.any?{|mentsu| mentsu.identical.chun? }
      return false unless tehai.koutsu_list.any?{|mentsu| mentsu.identical.hatsu? }
    
      return true
    end
    
    # 四槓子
    def sukantsu?(tehai, agari)
      return false if tehai.tokusyu?
      tehai.kantsu_list.size == 4
    end
  
  # 天和
    def tenho?(tehai, agari)
      agari.is_tenho
    end
  
  # 地和
    def chiho?(tehai, agari)
      agari.is_chiho
    end	   
  
  # 大四喜
    def tasushi?(tehai, agari)
      ton_flg = false
      nan_flg = false
      sha_flg = false
      pei_flg = false
      
      tehai.mentsu_list.each do | mentsu |
        if mentsu.koutsu? || mentsu.kantsu? then
          if mentsu.pai_list[0].ton? then
            ton_flg = true
          elsif mentsu.pai_list[0].nan? then
            nan_flg = true
          elsif mentsu.pai_list[0].sha? then
            sha_flg = true
          elsif mentsu.pai_list[0].pei? then
            pei_flg = true
          end
        end
      end

      if ton_flg && nan_flg && sha_flg && pei_flg then
        return true
      end
      return false
    end	  
  
  # 小四喜
    def shosushi?(tehai, agari)
      ton_flg = false
      nan_flg = false
      sha_flg = false
      pei_flg = false
      
      tehai.mentsu_list.each do | mentsu |
        if mentsu.koutsu? || mentsu.kantsu? then
          if mentsu.pai_list[0].ton? then
            ton_flg = true
          elsif mentsu.pai_list[0].nan? then
            nan_flg = true
          elsif mentsu.pai_list[0].sha? then
            sha_flg = true
          elsif mentsu.pai_list[0].pei? then
            pei_flg = true
          end
        end
      end
      
      if ton_flg && nan_flg && sha_flg && pei_flg then
        return false
      end
      
      if tehai.atama.ton? then
        ton_flg = true
      elsif tehai.atama.nan? then
        nan_flg = true
      elsif tehai.atama.sha? then
        sha_flg = true
      elsif tehai.atama.pei? then
        pei_flg = true
      end
      
      if ton_flg && nan_flg && sha_flg && pei_flg then
        return true
      end
      return false
    end		  
  
  # 字一色	  
    def tsuiso?(tehai, agari)
      tehai.mentsu_list.each do |mentsu|
        mentsu.pai_list.each do |pai|
          if !pai.jihai? then
            return false
          end
        end
	    end
      if !tehai.atama.jihai? then
        return false
      end
      return true
    end
  
  # 清老頭
    def chinraoto?(tehai, agari)
      tehai.mentsu_list.each do | mentsu |
        if mentsu.koutsu? || mentsu.kantsu? then
          if mentsu.pai_list[0].jihai? then
            return false
          elsif mentsu.pai_list[0].number != 1 && mentsu.pai_list[0].number != 9 then
            return false
          end
        else
          return false
        end
      end
      if tehai.atama.jihai? || tehai.atama.chunchan? then
        return false
      end
      return true
    end
  
  # 緑一色
    def ryuiso?(tehai, agari)
     atama_flag = false
     mentsu_flag = false
     
     # 頭
     if tehai.atama.hatsu?
       ##
     elsif tehai.atama.souzu? && (tehai.atama.number == 2 || tehai.atama.number == 3 || tehai.atama.number == 4 || tehai.atama.number == 6 || tehai.atama.number == 8)
       ##
     else
       return false
     end

     # メンツ
     tehai.mentsu_list.each do |mentsu|
       mentsu.pai_list.each do |pai|
         if pai.hatsu?
           ##
         elsif pai.souzu? && (pai.number == 2 || pai.number == 3 || pai.number == 4 || pai.number == 6 || pai.number == 8)
           ##
         else
           return false
         end
       end
     end

     return true

    end 

    
    # 九蓮宝燈
    def churen?(tehai, agari)
    ## TODO
    ## chinitsu?を呼び出せるようにmodule化

      ##一時的に清一色のメソッドをコピペ
      beforetype = nil
      tehai.mentsu_list.each do |mentsu|
        mentsu.pai_list.each do |pai|
          if beforetype == nil then
            beforetype = pai.type
          elsif beforetype != pai.type
            return false
          end
        end
      end

      if tehai.atama.type != beforetype
        return false
      end

      ## 牌のプールを作成
      paipool_list = Array.new 
     
      ## 頭
      paipool_list.push(tehai.atama)
      paipool_list.push(tehai.atama)
      ## メンツ
      tehai.mentsu_list.each do |mentsu|
        mentsu.pai_list.each do |pai|
          paipool_list.push(pai)
        end
      end

      ## 1を3つ削除
      3.times do
        paipool_list.each_with_index do |pai,i|
          if pai.number == 1
            paipool_list.delete_at(i)
            break
          end
        end
      end

     ## 2から8を1つ削除
     for i in 2..8
       paipool_list.each do |pai|
         if pai.number == i
           paipool_list.delete(pai)
           break
         end
       end
     end

     ## 9を3つ削除
     3.times do
       paipool_list.each_with_index do |pai,i|
         if pai.number == 9
           paipool_list.delete_at(i)
           break
         end
       end
     end

     ## 1を3つ、2 - 8を1つ、9を3つ削除して、残り牌が1つだったらtrue
     if paipool_list.size == 1
       return true
     else
       return false
     end

    end
  end
end

