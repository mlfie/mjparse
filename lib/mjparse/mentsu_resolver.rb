# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'pai')
require File.join(File.dirname(__FILE__), 'mentsu')
require File.join(File.dirname(__FILE__), 'tehai')

module Mjparse
  #############################
  # 手牌候補を取得するクラス       #
  #############################
  class MentsuResolver
    
    ### 処理結果
    RESULT_SUCCESS          = 0 # 正常終了
    RESULT_ERROR_NAKI       = 1 # 鳴き牌の判定に誤りがある
    RESULT_ERROR_NOAGARI    = 2 # 手牌がアガリ形になっていない
    RESULT_ERROR_INTERFACE  = 5 # 内部インタフェースエラー
    RESULT_ERROR_INTERNAL   = 9 # 不明な内部エラー
    
    attr_accessor :tehai_list,  # 手牌(Tehai)の配列
                  :result_code  # 処理結果
    
    def initialize
      self.tehai_list = Array.new
      self.result_code = RESULT_SUCCESS
    end
    
    ###################################
    # 同一の牌がいくつあるか保持するクラス    #
    ###################################
    class PaiCount
      attr_accessor :type,    # 牌の種類(m:萬子 s:索子 p:筒子 j:字牌)
                    :number,  # 数字(字牌の場合、1:東 2:南 3:西 4:北 5:白 6:發 7:中)
                    :count    # 牌の数
      
      def initialize(type, number)
        self.type     = type
        self.number   = number
        self.count    = 1
      end
    end
    
    #-------------------#
    # 面子の形を得る
    #-------------------#
    def get_mentsu(pai_items, is_tsumo=false)
      # step1. pai_itemsをPaiオブジェクトの配列で取得する
      @pai_list = get_pai_list(pai_items)
      @is_tsumo = is_tsumo
      
      if self.result_code == RESULT_SUCCESS then
        # step2. 副露面子を取得する
        @furo_flag = false      # 副露面子が存在した場合、trueとなる
        @furo_list = Array.new  # 副露面子の配列
        @ankan_list = Array.new # 暗槓面子の配列
        @pai_list.reverse!      # Pai配列を逆さにする(副露面子の解析は後ろから行うため)
        get_furo
        
        if self.result_code == RESULT_SUCCESS then
          # step3. 暗槓を取得する
          @pai_list.reverse!      # Pai配列の並びを元に戻す
          get_ankan
          
          if self.result_code == RESULT_SUCCESS then
            # step4. アガリ牌を退避させる（後ほど全ての面子が確定した後にアガリ牌が決定される）
            @agari_pai = @pai_list[@pai_list.size - 1].clone
      
            # step5. 雀頭候補を取得する
            @pai_list.sort_by! { |pai| [pai.type, pai.number] }
            @atama_queue = Array.new
            get_atama_queue
      
            # step6. 雀頭候補を仮定して門前面子の状況を走査する(以降、@pai_listに対する編集は禁止)
            if @atama_queue.size != 0
              # for atama_pos in @atama_queue
              @atama_queue.each do |_atama_pos|
                @atama_pai = @pai_list[_atama_pos].clone
              
                # step6-1. 雀頭を除く門前手牌を牌の種類毎に集計する
                @pai_counts = Array.new
                count_same_pai(_atama_pos)
          
                # step6-2. 手牌候補として門前手牌を面子の組み合わせ分だけ作成する
                @mentsu_list = Array.new
                set_tehai_normal(@pai_counts)            
              end
        
              # step7. 雀頭候補が7枚の場合、七対子の可能性がある
              if !@furo_flag && @atama_queue.size == 7 && @pai_list.size == 14 then
                set_tehai_7toitsu
              end

              # step8. 雀頭が存在して面子が完全に揃わない場合、国士無双 or　十三不塔の可能性がある
              if !@furo_flag && @pai_list.size == 14 && @atama_queue.size == 1 && self.tehai_list.size == 0 then
                set_tehai_tokusyu
              end
        
              # この時点で手牌候補が無い場合は、アガっていない
              if self.tehai_list.size == 0 then
                self.result_code = RESULT_ERROR_NOAGARI
              end

            # 雀頭が存在しない手牌は、アガっていない
            else
              self.result_code = RESULT_ERROR_NOAGARI
            end
          end
        end
      end
    end

    private
#*****************************************************************#
# step1. pai_itemsをPaiオブジェクトの配列で取得する
#*****************************************************************#
    #-------------------------------------------------#
    # 文字列pai_itemsを牌クラス(Pai)のリストとして取得する
    #-------------------------------------------------#
    def get_pai_list(_pai_items)
      _pai_list = nil
      if String === _pai_items then
        _tehai_items = _pai_items.scan(/[mspjr][0-9][tlbr]/)
        _pai_list = Array.new
        _tehai_items.each do |_item|
          _pai_list << Pai.new(_item)
        end
        if _pai_list.size < 14 then
          self.result_code = RESULT_ERROR_INTERFACE
        end
      elsif Array === _pai_items then
        _pai_list = _pai_items
      else
        self.result_code = RESULT_ERROR_INTERNAL
      end
      return _pai_list
    end

#*****************************************************************#
# step2. 副露面子を取得する
#*****************************************************************#
    #-------------------------------------------------#
    # 副露面子を取得する(自己再起呼び出しを行う)
    #-------------------------------------------------#
    def get_furo
      # Pai配列の残り枚数が5枚未満の場合、副露の取得を終了する　∵副露面子3枚＋頭2枚の計5枚が最低でも残る
      if @pai_list.size >= 5 then
        # step1. Pai配列の1〜3枚目に鳴き牌が存在する場合、チー、ポン、明槓のいずれかの可能性がある
        if @pai_list[0].naki || @pai_list[1].naki || @pai_list[2].naki then
          # step1-1. Pai配列の1〜3枚目が全て同じ牌である場合、ポン、明槓のいずれかの可能性がある
          if @pai_list[0] == @pai_list[1] && @pai_list[1] == @pai_list[2] then
            # step1-1-1. Pai配列の4枚目が鳴き牌である場合、ポンとなる
            if @pai_list[3].naki then
              add_pon(@pai_list.slice!(0,3).reverse!)
              get_furo
            # step1-1-2. Pai配列の4枚目が1枚目と異なる牌である場合、ポンとなる
            elsif @pai_list[0] != @pai_list[3] then
              add_pon(@pai_list.slice!(0,3).reverse!)
              get_furo
            # step1-1-3. Pai配列の残り枚数が5枚の場合、ポンとなる（残りの2枚は雀頭）
            # 到達付加（残り枚数が2枚の場合、残りの2枚は確実に元の3枚と異なる牌であるため、step1-1-2が該当する）
            # elsif @pai_list.size == 5 then
            #   add_pon(@pai_list.slice!(0,3).reverse!)
            #   # resolve_furo
            # step1-1-4. Pai配列の残り枚数が6枚の場合、明槓となる（残りの2枚は雀頭）
            elsif @pai_list.size == 6 then
              add_minkan(@pai_list.slice!(0,4).reverse!)
              # resolve_furo
            # step1-1-5. Pai配列の残り枚数が7枚の場合、誤検知（雀頭が成立しなくなる）
            elsif @pai_list.size == 7 then
              self.result_code = RESULT_ERROR_NAKI
            # step1-1-6. Pai配列の残り枚数が8枚の場合、ポンとなる（残りの5枚は雀頭＋面子）
            elsif @pai_list.size == 8 then
              add_pon(@pai_list.slice!(0,3).reverse!)
              get_furo
            # step1-1-7. Pai配列の残り枚数が9枚以上で、かつ4枚目が1〜3枚目と同じ牌である場合、ポン、明槓のいずれかの可能性がある
            else
              # step1-1-7-1. 
              # 1〜4枚目の牌が全て同じ牌であり、4〜6枚目の牌の組み合わせがチーとなる（鳴き牌は6枚目）場合、
              # 4〜6枚目の牌の組がチー面子となるのは確実であるため、1〜3枚目の牌の組はポン面子となる。
              # (1〜3枚目の牌と4枚目の牌が同じであることは偶然。）
              if is_chi?(@pai_list.slice(3,3).reverse) then
                add_pon(@pai_list.slice!(0,3).reverse!)
                get_furo
              # step1-1-7-2. 
              # 1〜4枚目の牌が全て同じであり、5〜7枚目の牌の組み合わせがチーとなる（鳴き牌は7枚目）場合、
              # 1〜4枚目の牌は組となることが確実であるため、明槓面子となる。
              # 不要処理（step1-1-7-3で包含され、かつ結果が同じため不要）
              # elsif is_chi?(@pai_list.slice(4,3).reverse) then
              #   add_minkan(@pai_list.slice!(0,4).reverse!)
              #   get_furo
              # step1-1-7-3.
              # 1〜4枚目の牌が全て同じであり、5〜8枚目の牌のいずれかが鳴き牌もしくはアンカンだった場合、
              # この時点で4枚目を含むチー面子は存在せず、かつ同一牌が4枚までしか存在しないことから、
              # 1〜4枚目の牌は組となることが確実であるため、明槓面子となる。
              elsif @pai_list[4].naki || @pai_list[5].naki || @pai_list[6].naki || @pai_list[7].naki || @pai_list[4].type == Pai::PAI_TYPE_REVERSE|| @pai_list[5].type == Pai::PAI_TYPE_REVERSE || @pai_list[6].type == Pai::PAI_TYPE_REVERSE || @pai_list[7].type == Pai::PAI_TYPE_REVERSE then
                add_minkan(@pai_list.slice!(0,4).reverse!)
                get_furo
              # step1-1-7-4. 
              # 4〜8枚目の全ての牌が鳴き牌でない場合、4または5枚目以降の牌は全て門前であることが確定となる。
              else
                # step1-1-7-4-1. Pai配列の中に背面を向けた牌が何枚あるか数える
                _reverse_pai = 0
                @pai_list.each do |_pai|
                  if _pai.type == Pai::PAI_TYPE_REVERSE then
                    _reverse_pai += 1
                  end
                end
                # step1-1-7-4-2. Pai配列の残り枚数から、背面を向けた牌の数の半分を引いた数が、3で割り切れる場合、1〜4枚目は明槓となる
                if (@pai_list.size - _reverse_pai / 2) % 3 == 0 then
                  add_minkan(@pai_list.slice!(0,4).reverse!)
                  get_furo
                # step1-1-7-4-3. Pai配列の残り枚数から、背面を向けた牌の数の半分を引いた数が、3で割った余りが2の場合、1〜3枚目はポンとなる
                elsif (@pai_list.size - _reverse_pai / 2) % 3 == 2 then
                  add_pon(@pai_list.slice!(0,3).reverse!)
                  get_furo
                # step1-1-7-4-4. Pai配列の残り枚数から、背面を向けた牌の数の半分を引いた数が、3で割った余りが1の場合、牌を誤検知している
                else
                  self.result_code = RESULT_ERROR_NAKI
                end
              end
            end
          # step1-2. Pai配列の1〜3枚目の組み合わせがチーとなるかを調べる
          elsif is_chi?(@pai_list.slice(0,3).reverse) then
            add_chi(@pai_list.slice!(0,3).reverse!)
            get_furo
          # step1-3. 牌を誤検知している
          else
            self.result_code = RESULT_ERROR_NAKI
          end
        # step2. Pai配列の1〜3枚目に鳴き牌が存在せず、かつ4枚目が鳴き牌の場合、明槓の可能性がある
        elsif @pai_list[3].naki then
          # step2-1. Pai配列の1〜4枚目の全てが同じ牌である場合、明槓となる 
          if @pai_list[0] == @pai_list[1] && @pai_list[1] == @pai_list[2] && @pai_list[2] == @pai_list[3] then
            add_minkan(@pai_list.slice!(0,4).reverse!)
            get_furo
          # step2-2. 牌の並びが不正、または4枚目の牌を誤検知している
          else
            self.result_code = RESULT_ERROR_NAKI
          end
        # step3. 暗槓が含まれる場合
        elsif @pai_list[0].type == Pai::PAI_TYPE_REVERSE || @pai_list[1].type == Pai::PAI_TYPE_REVERSE then
          # step3-1. 背面牌で挟んだ暗槓の場合
          if @pai_list[0].type == Pai::PAI_TYPE_REVERSE && @pai_list[1].type != Pai::PAI_TYPE_REVERSE && @pai_list[1] == @pai_list[2] && @pai_list[0] == @pai_list[3] then
            add_ankan(@pai_list[1])
            @pai_list.slice!(0,4)
            get_furo
          # step3-2. 背面牌を挟んだ暗槓の場合
          elsif @pai_list[0].type != Pai::PAI_TYPE_REVERSE && @pai_list[1].type == Pai::PAI_TYPE_REVERSE && @pai_list[0] == @pai_list[3] && @pai_list[1] == @pai_list[2] then
            add_ankan(@pai_list[0])
            @pai_list.slice!(0,4)
            get_furo
          # step3-3. アガリ牌＋背面牌で挟んだ暗槓の場合(本来ここでは検知したくないパターン)
          elsif @pai_list[1].type == Pai::PAI_TYPE_REVERSE && @pai_list[2].type != Pai::PAI_TYPE_REVERSE && @pai_list[2] == @pai_list[3] && @pai_list[1] == @pai_list[4] then
            # 何もしない。再起呼び出しも行わない。
          else
            self.result_code = RESULT_ERROR_INTERFACE
          end
        end
      end
    end
    
    #-------------------------------------------------#
    # チー面子を副露配列に追加する
    #-------------------------------------------------#
    def add_chi(_pai_list)
      @furo_list << Mentsu.new(_pai_list, Mentsu::MENTSU_TYPE_SHUNTSU, true)
      @furo_flag = true
    end

    #-------------------------------------------------#
    # ポン面子を副露配列に追加する
    #-------------------------------------------------#
    def add_pon(_pai_list)
      @furo_list << Mentsu.new(_pai_list, Mentsu::MENTSU_TYPE_KOUTSU, true)
      @furo_flag = true
    end

    #-------------------------------------------------#
    # 明槓面子を副露配列に追加する
    #-------------------------------------------------#
    def add_minkan(_pai_list)
      @furo_list << Mentsu.new(_pai_list, Mentsu::MENTSU_TYPE_KANTSU, true)
      @furo_flag = true
    end

    #-------------------------------------------------#
    # 暗槓面子(裏向きのパターン)を取得する
    #-------------------------------------------------#
    def add_ankan(pai)
        pai_list = Array.new
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        @ankan_list << Mentsu.new(pai_list, Mentsu::MENTSU_TYPE_KANTSU, false)
    end
    
    #-------------------------------------------------#
    # チーかどうか調べる
    #-------------------------------------------------#
    def is_chi?(pai_list)
      # 先頭の牌が鳴き牌でない（＝上家から鳴いてない）場合は、チーとして成立しない
      if !pai_list[0].naki || pai_list[1].naki || pai_list[2].naki then
        return false
      end
      pai_list2 = pai_list.sort_by { |pai| [pai.type, pai.number] }
      return is_shuntsu?(pai_list2)
    end

#*****************************************************************#
# step3. 暗槓を取得する
#*****************************************************************#
    def get_ankan
      if @pai_list.size >= 6 then 
        i = (@pai_list.size-1)
        while 1 < i
          if @pai_list[i].type == Pai::PAI_TYPE_REVERSE then
            # パターン1. 背面牌に挟まれてる場合
            if 2 < i && @pai_list[i-1].type != Pai::PAI_TYPE_REVERSE && @pai_list[i-1] == @pai_list[i-2] && @pai_list[i-3].type == Pai::PAI_TYPE_REVERSE then
              add_ankan(@pai_list[i-1])
              @pai_list.slice!(i-3,4)
              i -= 3
            # パターン2. 背面牌を挟んでいる場合
            elsif 1 < i && @pai_list[i+1].type != Pai::PAI_TYPE_REVERSE && @pai_list[i+1] == @pai_list[i-2] && @pai_list[i-1].type == Pai::PAI_TYPE_REVERSE then
              add_ankan(@pai_list[i+1])
              @pai_list.slice!(i-2,4)
              i -= 2
            else
              self.result_code = RESULT_ERROR_INTERFACE
            end
          end
          i -= 1
        end
      end
    end

#*****************************************************************#
# step5. 雀頭候補を取得する
#*****************************************************************#
    #-------------------------------------------------#
    # 雀頭候補を取得する
    #-------------------------------------------------#
    def get_atama_queue
      i = 0
      while i < @pai_list.size - 1 do
        if @pai_list[i] == @pai_list[i+1] && @pai_list[i].type != Pai::PAI_TYPE_REVERSE then
          @atama_queue << i
          j = i
          for k in i..(@pai_list.size - 2)
            if @pai_list[j] != @pai_list[k+1] then
              break
            else
              i += 1
            end
          end
        end
        i += 1
      end
    end
      
#*****************************************************************#
# step6-1. 雀頭を除く門前手牌を牌の種類毎に集計する
#*****************************************************************#
    #-------------------------------------------------#
    # 各牌の個数を調べる
    #-------------------------------------------------#
    def count_same_pai(_atama_pos)
      _pai_list = @pai_list.clone

      # 雀頭となる牌を削除する
      _pai_list.slice!(_atama_pos, 2)
      
      _last_pai_count = nil
      _pai_list.each_with_index { |pai, idx|
        # 最初だけ特別処理
        if idx == 0
          __pai_count = PaiCount.new(pai.type, pai.number)
          @pai_counts << __pai_count
          _last_pai_count = __pai_count
          next
        end
        # 一致したらcountを1増やす
        if pai.type == _last_pai_count.type && pai.number == _last_pai_count.number
          _last_pai_count.count += 1
        else
          __pai_count = PaiCount.new(pai.type, pai.number)
          @pai_counts << __pai_count
          _last_pai_count = __pai_count
        end
      }
    end
    
#*****************************************************************#
# step6-2. 手牌候補として門前手牌を面子の組み合わせ分だけ作成する
#*****************************************************************#
    #-------------------------------------------------#
    # 再帰呼び出しで面子候補リストを分解していく。
    #-------------------------------------------------#
    def set_tehai_normal(_pai_count_list)
      # 面子候補リストが完全に無くなったら終了
      if _pai_count_list.size == 0
        # 副露面子と合わせて、4面子構成になっていない場合は、手牌リストに追加しない
        if (@mentsu_list.size + @ankan_list.size + @furo_list.size) == 4 then
          # アガリ牌の可能性ごとに全パターンの手牌候補を洗い出す
          self.tehai_list.concat(get_agari_tehai(@is_tsumo))
        end
      else
        # 槓子の判定へ
        # _pai_count_list = _pai_count_list.sort_by { |pc| [pc.type, pc.number] }
        _pai_count_list.sort_by! { |pc| [pc.type, pc.number] }
        if is_kantsu?(_pai_count_list[0]) then
          @mentsu_list.push(get_kantsu(_pai_count_list[0]))
          _pai_count = _pai_count_list[0]
          _pai_count_list.shift
          set_tehai_normal(_pai_count_list)
          _pai_count_list.unshift(_pai_count)
          @mentsu_list.pop
        end

        # 刻子の判定へ
        # _pai_count_list = _pai_count_list.sort_by { |pc| [pc.type, pc.number] }
        _pai_count_list.sort_by! { |pc| [pc.type, pc.number] }
        if is_koutsu?(_pai_count_list[0]) then
          @mentsu_list.push(get_koutsu(_pai_count_list[0]))
          if _pai_count_list[0].count == 3 then
            _pai_count = _pai_count_list[0]
            _pai_count_list.shift
            set_tehai_normal(_pai_count_list)
            _pai_count_list.unshift(_pai_count)
          else
            _pai_count_list[0].count -= 3
            set_tehai_normal(_pai_count_list)
            _pai_count_list[0].count += 3
          end
          @mentsu_list.pop
        end
      
        # 順子の判定へ
        # _pai_count_list = _pai_count_list.sort_by { |pc| [pc.type, pc.number] }
        _pai_count_list.sort_by! { |pc| [pc.type, pc.number] }
        if is_shuntsu?(_pai_count_list) then
          pai_count1 = _pai_count_list[0]
          pai_count2 = _pai_count_list[1]
          pai_count3 = _pai_count_list[2]
          @mentsu_list.push(get_shuntsu(pai_count1, pai_count2, pai_count3))
          _is_shift1 = false
          _is_shift2 = false
          _is_shift3 = false
        
          if pai_count3.count == 1 then
            _pai_count_list.delete_at(2)
            _is_shift3 = true
          else
            pai_count3.count -= 1
          end
          if pai_count2.count == 1 then
            _pai_count_list.delete_at(1)
            _is_shift2 = true
          else
            pai_count2.count -= 1
          end
          if pai_count1.count == 1 then
            _pai_count_list.delete_at(0)
            _is_shift1 = true
          else
            pai_count1.count -= 1
          end

          set_tehai_normal(_pai_count_list)

          if _is_shift3 then
            _pai_count_list.unshift(pai_count3)
          else
            pai_count3.count += 1
          end
          if _is_shift2 then
            _pai_count_list.unshift(pai_count2)
          else
            pai_count2.count += 1
          end
          if _is_shift1 then
            _pai_count_list.unshift(pai_count1)
          else
            pai_count1.count += 1
          end
          @mentsu_list.pop
        end
      end
    end
    
    #-------------------------------------------------#
    # アガリ牌の設定を行う
    #-------------------------------------------------#
    def get_agari_tehai(is_tsumo)
      # アガリ牌設定済みのTehaiリスト
      tehai_list = Array.new
      
      # 雀頭がアガリ牌となるパターン(単騎待ちの場合)
      if @atama_pai == @agari_pai then
        _atama_pai = @atama_pai.clone
        _atama_pai.agari = true
        _atama_pai.is_tsumo = is_tsumo
        tehai_list << Tehai.new(Marshal.load(Marshal.dump(@mentsu_list)) + @ankan_list + @furo_list, _atama_pai, @furo_flag)
      end
      
      # 各面子でアガリ牌となるパターン(両面待ち、辺張待ち、嵌張待ち、双ポン待ち)
      for i in 0..(@mentsu_list.size-1)
        # 面子の牌を一つずつ調べて、一つでもアガリ牌と合致したら手牌リストに追加して次の面子に処理を移す
        for j in 0..(@mentsu_list[i].pai_list.size-1)
          if @mentsu_list[i].pai_list[j] == @agari_pai then
            _mentsu_list = Marshal.load(Marshal.dump(@mentsu_list))
            _mentsu_list[i].pai_list[j].agari = true
            _mentsu_list[i].pai_list[j].is_tsumo = is_tsumo
            tehai_list << Tehai.new(_mentsu_list + @ankan_list + @furo_list, @atama_pai, @furo_flag)
            break
          end
        end
      end
      
      # この時点で手牌リストが空である場合、アガリ牌の設定が正しく行えていない
      if tehai_list.size == 0 then
        self.result_code = RESULT_ERROR_INTERNAL
      end
      
      return tehai_list
    end
    
    #-------------------------------------------------#
    # 暗槓面子(表向きのパターン)を取得する
    #-------------------------------------------------#
    def get_kantsu(pai)
        pai_list = Array.new
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        return Mentsu.new(pai_list, Mentsu::MENTSU_TYPE_KANTSU, false)
    end
    
    #-------------------------------------------------#
    # 刻子面子を取得する
    #-------------------------------------------------#
    def get_koutsu(pai)
        pai_list = Array.new
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        return Mentsu.new(pai_list, Mentsu::MENTSU_TYPE_KOUTSU, false)
    end

    #-------------------------------------------------#
    # 順子面子を取得する
    #-------------------------------------------------#
    def get_shuntsu(pai1, pai2, pai3)
        pai_list = Array.new
        pai_list << Pai.new(pai1.type + pai1.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai2.type + pai2.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai3.type + pai3.number.to_s + Pai::PAI_DIRECT_TOP)
        return Mentsu.new(pai_list, Mentsu::MENTSU_TYPE_SHUNTSU, false)
    end

    #-------------------------------------------------#
    # 槓子かどうか調べる
    #-------------------------------------------------#
    def is_kantsu?(pai_count)
      if pai_count.count >= 4
        return true
      end
      return false
    end
    
    #-------------------------------------------------#
    # 刻子かどうか調べる
    #-------------------------------------------------#
    def is_koutsu?(pai_count)
      if pai_count.count >= 3
        return true
      end
      return false
    end
    
    #-------------------------------------------------#
    # 順子かどうか調べる
    #-------------------------------------------------#
    def is_shuntsu?(pai_count)
      # 牌カウントが3枚未満ならfalse
      if pai_count.size < 3
        return false
      end
      # 先頭の牌の種類が字牌ならfalse
      if pai_count[0].type == Pai::PAI_TYPE_JIHAI
        return false
      end
      if pai_count[0].type == pai_count[1].type && pai_count[0].type == pai_count[2].type &&
         (pai_count[0].number+1) == pai_count[1].number && (pai_count[1].number+1) == pai_count[2].number
        return true
      end
      return false
    end

#*****************************************************************#
# step7. 雀頭候補が7枚の場合、七対子の可能性がある
#*****************************************************************#
    #-------------------------------------------------#
    # 七対子面子かどうかを判断して手牌候補に加える
    #-------------------------------------------------#
    def set_tehai_7toitsu
      # 1番目の牌を頭と仮定して、牌の種類ごとの数を集計する
      _atama_pai = nil
      _atama_pos = -1
      for i in 0..6
        if @pai_list[@atama_queue[i]] == @agari_pai then
          _atama_pos = @atama_queue[i]
          _atama_pai = @pai_list[_atama_pos].clone
          _atama_pai.agari = true
        end
      end
      
      if _atama_pai != nil && _atama_pos != -1 then
        @pai_counts = Array.new
        count_same_pai(_atama_pos)

        # 牌の種類が6種類であり、かつ全ての集計数が2個ずつの場合、七対子面子となる
        mentsu_list = Array.new
        if @pai_counts.size == 6 then
          @pai_counts.each do |pai_count|
            if pai_count.count == 2 then
              mentsu_list << get_toitsu_mentsu(pai_count)
            end
          end
        end
        if mentsu_list.size == 6 then
          self.tehai_list << Tehai.new(mentsu_list, _atama_pai, false)
        end
      end
    end
  
    #-------------------------------------------------#
    # 対子面子を取得する
    #-------------------------------------------------#
    def get_toitsu_mentsu(pai)
        pai_list = Array.new
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        return Mentsu.new(pai_list, Mentsu::MENTSU_TYPE_TOITSU, false)
    end

#*****************************************************************#
# step8. 雀頭が存在して面子が完全に揃わない場合、国士無双 or　十三不塔の可能性がある
#*****************************************************************#
    #-------------------------------------------------#
    # 雀頭を除く全ての牌を12枚の面子として手牌候補に加える
    #-------------------------------------------------#
    def set_tehai_tokusyu
      _atama_pai = @pai_list[@atama_queue[0]].clone
      @pai_counts = Array.new
      count_same_pai(@atama_queue[0])
      
      _mentsu_list = Array.new
      _mentsu_list << get_tokusyu_mentsu(@pai_counts)
      
      # 牌の種類が12種類の場合、特殊系面子となる
      if @pai_counts.size == 12 then
        # あがり牌の設定
        if _atama_pai == @agari_pai then
          _atama_pai.agari = true
        else
          _mentsu_list.each do |_mentsu|
            if _mentsu.pai_list[0] == @agari_pai then
              _mentsu.pai_list[0].agari = true
            end
          end
        end

        self.tehai_list << Tehai.new(_mentsu_list, _atama_pai, false)
      end
    end

    #-------------------------------------------------#
    # 特殊面子を取得する
    #-------------------------------------------------#
    def get_tokusyu_mentsu(pai_counts)
        pai_list = Array.new
        pai_counts.each do |pai|
          pai_list << Pai.new(pai.type + pai.number.to_s + Pai::PAI_DIRECT_TOP)
        end
        return Mentsu.new(pai_list, Mentsu::MENTSU_TYPE_TOKUSYU, false)
    end
    
    
    # デバッグ用
    def stdout_debug
      p "========================================================="
      p "result_code = " + self.result_code.to_s
      p "---------------------------------------------------------"
      @pai_list.each do |pai|
        p pai
      end
      p "---------------------------------------------------------"
      @mentsu_list.each do |mentsu|
        mentsu.pai_list.each do |pai|
          p pai
        end
        p ""
      end
      p "---------------------------------------------------------"
      @furo_list.each do |furo|
        furo.pai_list.each do |pai|
          p pai
        end
        p ""
      end
      p "---------------------------------------------------------"
      @ankan_list.each do |ankan|
        ankan.pai_list.each do |pai|
          p pai
        end
        p ""
      end
      p "---------------------------------------------------------"
      p @atama_pai
      p "========================================================="
    end
  end
end
