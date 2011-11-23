# -*- coding: utf-8 -*-
require 'date'
require 'mlfielib/analysis/mentsu_resolver'
require 'mlfielib/analysis/score_calculator'
require 'mlfielib/analysis/yaku_judger'

module Mlfielib
  module Analysis
    # 最も高い手を判定する
    class TeyakuDecider
      
      ### 処理結果
      RESULT_SUCCESS                = 0 # 正常終了
      RESULT_ERROR_MENTSU_RESOLVE   = 1 # 面子解析処理でのエラー
      RESULT_ERROR_YAKU_JUDGE       = 2 # 役判定処理でのエラー
      RESULT_ERROR_SCORE_CALCULATE  = 3 # 点数計算処理でのエラー
      RESULT_ERROR_INTERNAL         = 9 # 不明な内部エラー
      
      attr_accessor :teyaku,            # 最終的な手役
                    :result_code        # 処理結果
      
      # 初期化
      def initialize
        self.teyaku       = nil
        self.result_code  = RESULT_SUCCESS
      end

      # 最適な手役結果を取得する
      def get_agari_teyaku(pai_list=nil, kyoku=nil, yaku_specimen=nil)
        STDERR.puts Time.new.to_s + "：受け取った面子構成は(" + pai_list + ")です。"
        
        resolver = MentsuResolver.new
        resolver.get_mentsu(pai_list)
        
        case resolver.result_code
          when MentsuResolver::RESULT_SUCCESS then
            STDERR.puts Time.new.to_s + "：取得された手牌の組み合わせは" + resolver.tehai_list.size.to_s + "個です。"
          when MentsuResolver::RESULT_ERROR_NAKI then
            self.result_code = RESULT_ERROR_MENTSU_RESOLVE
            STDERR.puts Time.new.to_s + "：鳴き面子の構成が不正です(" + pai_list + ")。"
          when MentsuResolver::RESULT_ERROR_NOAGARI then
            self.result_code = RESULT_ERROR_MENTSU_RESOLVE
            STDERR.puts Time.new.to_s + "：指定された手牌はアガリ形ではありません(" + pai_list + ")。"
          when MentsuResolver::RESULT_ERROR_INTERFACE then
            self.result_code = RESULT_ERROR_MENTSU_RESOLVE
            STDERR.puts Time.new.to_s + "：内部インタフェースで不明なエラーが発生しました(" + pai_list + ")。"
          else
            self.result_code = RESULT_ERROR_MENTSU_RESOLVE
            STDERR.puts Time.new.to_s + "：不明なエラーが発生しました(" + pai_list + ")。"
        end
        
        # 取得した面子に対して役の判定、得点計算を行う。
        if self.result_code == RESULT_SUCCESS then
          yaku_established = false
          resolver.tehai_list.each do | tehai |
            tehai.mentsu_list.each do |mentsu|
              STDERR.puts Time.new.to_s + "：----- Mentsu(種類" + mentsu.mentsu_type.to_s + ", 副露" + mentsu.furo.to_s + ") -----"
              mentsu.pai_list.each do |pai|
                STDERR.puts Time.new.to_s + "：Pai(種類" + pai.type + ", 数字" + pai.number.to_s + ", 鳴き" + pai.naki.to_s + ", アガリ" + pai.agari.to_s + ")" 
              end
            end
            STDERR.puts Time.new.to_s + "：----- Atama(種類" + tehai.atama.type + ", 数字" + tehai.atama.number.to_s + ", 鳴き" + tehai.atama.naki.to_s + ", アガリ" + tehai.atama.agari.to_s + ")"
            # 役を取得する
            judger = YakuJudger.new(yaku_specimen)
            judger.set_yaku_list(tehai, kyoku)
            case judger.result_code
              when YakuJudger::RESULT_SUCCESS then
                tehai.yaku_list = judger.yaku_list
                yaku_established = true
            		STDERR.puts Time.new.to_s + "：判定した結果、以下の役が得られました。"
            		tehai.yaku_list.each do |yaku|
                  STDERR.puts yaku.name + ":" + yaku.kanji
                end 
                # 得点を計算する
                tehai = ScoreCalculator.calculate_point(tehai, kyoku)
              when YakuJudger::RESULT_ERROR_YAKUNASHI then
                STDERR.puts Time.new.to_s + "：判定した結果が役無しでした。ただし、この時点ではエラーではありません。"
              else
                self.result_code = RESULT_ERROR_YAKU_JUDGE
                STDERR.puts Time.new.to_s + "：役判定処理にて不明なエラーが発生しました。"
            end
          end
          # 役が一つも成立していない場合
          if !yaku_established then
            self.result_code = RESULT_ERROR_YAKU_JUDGE
          end
        end

        # 最も点数が高くなるものを採用する
        if self.result_code == RESULT_SUCCESS then
          max_point = 0
          best_tehai = nil
          resolver.tehai_list.each do |tehai|
            if max_point < tehai.total_point then
              max_point = tehai.total_point
              best_tehai = tehai
            end
          end
          # 最良な手役が取得できた場合
          if best_tehai != nil then
            self.teyaku = best_tehai
          # 最良な手役が取得できなかった場合
          else
            self.result_code = RESULT_ERROR_INTERNAL
            STDERR.puts Time.new.to_s + "：最適な手役を見つけることができませんでした。"
          end
        end
        
      end

    end
  end
end
