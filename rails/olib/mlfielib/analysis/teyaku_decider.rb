# -*- coding: utf-8 -*-
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
        resolver = MentsuResolver.new
        resolver.get_mentsu(pai_list)
        
        # 面子解析処理が正常であった場合
        if resolver.result_code == MentsuResolver::RESULT_SUCCESS then
          judger = YakuJudger.new(yaku_specimen)
        # 面子解析処理が異常の場合
        else
          self.result_code = RESULT_ERROR_MENTSU_RESOLVE
          STDERR.puts "MentsuResolver was failed because of " + resolver.result_code.to_s + "."
        end
          
        if self.result_code == RESULT_SUCCESS then
          resolver.tehai_list.each do | tehai |
            # 役を取得する
            judger.set_yaku_list(tehai, kyoku)
            STDERR.puts "The size of set yaku list is " + tehai.yaku_list.size.to_s + "."
            if judger.result_code == YakuJudger::RESULT_SUCCESS then
              # 得点を計算する
              tehai = ScoreCalculator.calculate_point(tehai, kyoku)
            else
              self.result_code = RESULT_ERROR_YAKU_JUDGE
              STDERR.puts "Yaku Judger was failed because of " + judger.result_code.to_s + "."
            end
          end
        end
          
        if self.result_code == RESULT_SUCCESS then
          # 最も点数が高くなるものを採用する
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
            STDERR.puts "TeyakuDecider was failed, because we cannot find the best tehai."
          end
        end
      end
    end
  end
end
