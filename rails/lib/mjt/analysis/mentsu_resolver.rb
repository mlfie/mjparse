module Mjt::Analysis
  #############################
  # 手牌候補を取得するクラス       #
  #############################
  class MentsuResolver
    
    ### 処理結果
    RESULT_SUCCESS        = 0   # 正常終了
    RESULT_ERROR_NAKI     = 1   # 鳴き牌の判定に誤りがある
    RESULT_ERROR_NOAGARI  = 9   # 手牌がアガリ形になっていない
    
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
                    :count,   # 牌の数
                    :is_naki, # 鳴き牌
                    :is_agari # アガリ牌
      
      def initialize(type, number, is_naki, is_agari)
        self.type     = type
        self.number   = number
        self.count    = 1
        self.is_naki  = is_naki
        self.is_agari = is_agari
      end
    end
    
    #-------------------#
    # 面子の形を得る
    #-------------------#
    def get_mentsu(pai_items)
      # step1. pai_itemsをPaiオブジェクトの配列で取得する
      @pai_list = get_pai_list(pai_items)
      
      # step2. 副露面子を取得する
      @furo_flag = false      # 副露面子が存在した場合、trueとなる
      @furo_list = Array.new  # 副露面子の配列
      @pai_list.reverse!      # Pai配列を逆さにする(副露面子の解析は後ろから行うため)
      get_furo
      
      # step3. アガリ牌を設定する
      @pai_list[0].agari = true   # Pai配列が逆さになっているため、先頭がアガリ牌

      # step4. 雀頭候補を取得する
      @pai_list.sort_by! { |pai| [pai.type, pai.number] }
      @atama_queue = Array.new
      get_atama_queue
      
      # step5. 雀頭候補を仮定して門前面子の状況を走査する(以降、@pai_listに対する編集は禁止)
      if @atama_queue.size != 0
        # for atama_pos in @atama_queue
        @atama_queue.each do |_atama_pos|
          @atama = @pai_list[_atama_pos].clone
          # step5-1. 雀頭を除く門前手牌を牌の種類毎に集計する
          @pai_counts = Array.new
          count_same_pai(_atama_pos)
          
          # step5-2. 手牌候補として門前手牌を面子の組み合わせ分だけ作成する
          @mentsu_list = Array.new
          set_tehai_normal(@pai_counts)            
        end
        
        # step6. 雀頭候補が7枚の場合、七対子の可能性がある
        if !@furo_flag && @pai_list.size == 14 && @atama_queue.size == 7 then
          set_tehai_7toitsu
        end

        # step7. 雀頭が存在して面子が完全に揃わない場合、国士無双 or　十三不塔の可能性がある
        if !@furo_flag && @pai_list.size == 14 && @atama_queue.size == 1 && self.tehai_list.size == 0 then
          set_tehai_tokusyu
        end
        
        # この時点で手牌候補が無い場合は、誤り
        if self.tehai_list.size == 0 then
          self.result_code = RESULT_ERROR_NOAGARI
        end

      # 雀頭が存在しない手牌は、誤り
      else
        self.result_code = RESULT_ERROR_NOAGARI
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
      _tehai_items = _pai_items.scan(/.{1,2}/m)
      _pai_list = Array.new
      _tehai_items.each do |_item| 
        _pai_list << Pai.new(_item, false, false)
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
            elsif @pai_list.size == 5 then
              add_pon(@pai_list.slice!(0,3).reverse!)
              # resolve_furo
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
              elsif is_chi?(@pai_list.slice(4,3).reverse) then
                add_minkan(@pai_list.slice!(0,4).reverse!)
                get_furo
              # step1-1-7-3.
              # 1〜4枚目の牌が全て同じであり、5〜8枚目の牌のいずれかが鳴き牌だった場合、
              # この時点で4枚目を含むチー面子は存在せず、かつ同一牌が4枚までしか存在しないことから、
              # 1〜4枚目の牌は組となることが確実であるため、明槓面子となる。
              elsif @pai_list[4].naki || @pai_list[5].naki || @pai_list[6].naki || @pai_list[7].naki then
                add_minkan(@pai_list.slice!(0,4).reverse!)
                get_furo
              # step1-1-7-4. 
              # 4〜8枚目の全ての牌が鳴き牌でない場合、4または5枚目以降の牌は全て門前であることが確定となる。
              else
                # step1-1-7-4-1. Pai配列の中に背面を向けた牌が何枚あるか数える
                _reverse_pai = 0
                @pai_list.each do |_pai|
                  if _pai.type == Mjt::Analysis::Pai::PAI_TYPE_REVERSE then
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
        end
      end
    end
    
    #-------------------------------------------------#
    # チー面子を副露配列に追加する
    #-------------------------------------------------#
    def add_chi(_pai_list)
      @furo_list << Mentsu.new(_pai_list, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU, true)
      @furo_flag = true
    end

    #-------------------------------------------------#
    # ポン面子を副露配列に追加する
    #-------------------------------------------------#
    def add_pon(_pai_list)
      @furo_list << Mentsu.new(_pai_list, Mjt::Analysis::Mentsu::MENTSU_TYPE_KOUTSU, true)
      @furo_flag = true
    end

    #-------------------------------------------------#
    # 明槓面子を副露配列に追加する
    #-------------------------------------------------#
    def add_minkan(_pai_list)
      @furo_list << Mentsu.new(_pai_list, Mjt::Analysis::Mentsu::MENTSU_TYPE_KANTSU, true)
      @furo_flag = true
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
# step4. 雀頭候補を取得する
#*****************************************************************#
    #-------------------------------------------------#
    # 雀頭候補を取得する
    #-------------------------------------------------#
    def get_atama_queue
      (@pai_list.size - 1).times { |i|
        # if @pai_list[i].type == @pai_list[i+1].type && @pai_list[i].number == @pai_list[i+1].number
        if @pai_list[i] == @pai_list[i+1] then
          @atama_queue << i
        end
      }
    end
      
#*****************************************************************#
# step5-1. 雀頭を除く門前手牌を牌の種類毎に集計する
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
          __pai_count = PaiCount.new(pai.type, pai.number, pai.naki, pai.agari)
          @pai_counts << __pai_count
          _last_pai_count = __pai_count
          next
        end
        # 一致したらcountを1増やす
        if pai.type == _last_pai_count.type && pai.number == _last_pai_count.number
          _last_pai_count.count += 1
        else
          __pai_count = PaiCount.new(pai.type, pai.number, pai.naki, pai.agari)
          @pai_counts << __pai_count
          _last_pai_count = __pai_count
        end
      }
    end
    
#*****************************************************************#
# step5-2. 手牌候補として門前手牌を面子の組み合わせ分だけ作成する
#*****************************************************************#
    #-------------------------------------------------#
    # 再帰呼び出しで面子候補リストを分解していく。
    #-------------------------------------------------#
    def set_tehai_normal(_pai_count_list)
      # 面子候補リストが完全に無くなったら終了
      if _pai_count_list.size == 0
        # 副露面子と合わせて、4面子構成になっていない場合は、手牌リストに追加しない
        if (@mentsu_list.size + @furo_list.size) == 4 then
          # self.tehai_list << Tehai.new(Marshal.load(Marshal.dump(@mentsu_list)), @atama)
          self.tehai_list << Tehai.new(@mentsu_list.clone + @furo_list, @atama.clone)
        end
      else
        # 槓子の判定へ
        # _pai_count_list = _pai_count_list.sort_by { |pc| [pc.type, pc.number] }
        _pai_count_list.sort_by! { |pc| [pc.type, pc.number] }
        if is_kantsu?(_pai_count_list[0]) then
          @mentsu_list.push(get_kantsu_mentsu(_pai_count_list[0]))
          _pai_count_list.shift
          set_tehai_normal(_pai_count_list)
          _pai_count_list.unshift(pai_count)
          @mentsu_list.pop
        end

        # 刻子の判定へ
        # _pai_count_list = _pai_count_list.sort_by { |pc| [pc.type, pc.number] }
        _pai_count_list.sort_by! { |pc| [pc.type, pc.number] }
        if is_koutsu?(_pai_count_list[0]) then
          @mentsu_list.push(get_koutsu_mentsu(_pai_count_list[0]))
          if _pai_count.count == 3 then
            _pai_count_list.shift
            set_tehai_normal(_pai_count_list)
            _pai_count_list.unshift(pai_count)
          else
            _pai_count.count -= 3
            set_tehai_normal(_pai_count_list)
            _pai_count.count += 3
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
          @mentsu_list.push(get_shuntsu_mentsu(pai_count1, pai_count2, pai_count3))
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
    # 暗槓面子を取得する
    #-------------------------------------------------#
    def get_kantsu_mentsu(pai)
        pai_list = Array.new
        pai_list << Pai.new(pai.type + pai.number.to_s, pai.is_naki, pai.is_agari)
        pai_list << Pai.new(pai.type + pai.number.to_s, pai.is_naki, pai.is_agari)
        pai_list << Pai.new(pai.type + pai.number.to_s, pai.is_naki, pai.is_agari)
        pai_list << Pai.new(pai.type + pai.number.to_s, pai.is_naki, pai.is_agari)
        return Mentsu.new(pai_list, Mentsu::MENTSU_TYPE_KANTSU, false)
    end
    
    #-------------------------------------------------#
    # 刻子面子を取得する
    #-------------------------------------------------#
    def get_koutsu_mentsu(pai)
        pai_list = Array.new
        pai_list << Pai.new(pai.type + pai.number.to_s, pai.is_naki, pai.is_agari)
        pai_list << Pai.new(pai.type + pai.number.to_s, pai.is_naki, pai.is_agari)
        pai_list << Pai.new(pai.type + pai.number.to_s, pai.is_naki, pai.is_agari)
        return Mentsu.new(pai_list, Mentsu::MENTSU_TYPE_KOUTSU, false)
    end

    #-------------------------------------------------#
    # 順子面子を取得する
    #-------------------------------------------------#
    def get_shuntsu_mentsu(pai1, pai2, pai3)
        pai_list = Array.new
        pai_list << Pai.new(pai1.type + pai1.number.to_s, pai1.is_naki, pai1.is_agari)
        pai_list << Pai.new(pai2.type + pai2.number.to_s, pai2.is_naki, pai2.is_agari)
        pai_list << Pai.new(pai3.type + pai3.number.to_s, pai3.is_naki, pai3.is_agari)
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
      if pai_count[0].type == Mjt::Analysis::Pai::PAI_TYPE_JIHAI
        return false
      end
      if pai_count[0].type == pai_count[1].type && pai_count[0].type == pai_count[2].type &&
         (pai_count[0].number+1) == pai_count[1].number && (pai_count[1].number+1) == pai_count[2].number
        return true
      end
      return false
    end

#*****************************************************************#
# step6. 雀頭候補が7枚の場合、七対子の可能性がある
#*****************************************************************#
    #-------------------------------------------------#
    # 七対子面子かどうかを判断して手牌候補に加える
    #-------------------------------------------------#
    def set_tehai_7toitsu
      # 1番目の牌を頭と仮定して、牌の種類ごとの数を集計する
      @atama = @pai_list[@atama_queue[0]].clone
      @pai_counts = Array.new
      count_same_pai(@atama_queue[0])

      # 牌の種類が7種類であり、かつ全ての集計数が2個ずつの場合、七対子面子となる
      mentsu_list = Array.new
      if @pai_counts == 7 then
        @pai_counts.each do |pai_count|
          if pai_count.count == 2 then
            mentsu_list << get_toitsu_mentsu(pai_count)
          end
        end
      end
      if mentsu_list.size == 7 then
        self.tehai_list << Tehai.new(mentsu_list, @atama.clone)
      end
    end
  
    #-------------------------------------------------#
    # 対子面子を取得する
    #-------------------------------------------------#
    def get_toitsu_mentsu(pai)
        pai_list = Array.new
        pai_list << Pai.new(pai.type + pai.number.to_s, pai.is_naki, pai.is_agari)
        pai_list << Pai.new(pai.type + pai.number.to_s, pai.is_naki, pai.is_agari)
        return Mentsu.new(pai_list, Mentsu::MENTSU_TYPE_TOITSU, false)
    end

#*****************************************************************#
# step7. 雀頭が存在して面子が完全に揃わない場合、国士無双 or　十三不塔の可能性がある
#*****************************************************************#
    #-------------------------------------------------#
    # 雀頭を除く全ての牌を12枚の面子として手牌候補に加える
    #-------------------------------------------------#
    def set_tehai_tokusyu
      @atama = @pai_list[@atama_queue[0]].clone
      @pai_counts = Array.new
      count_same_pai(@atama_queue[0])
      
      # 牌の種類が12種類の場合、特殊系面子となる
      if @pai_counts == 12 then
        self.tehai_list << Tehai.new(get_tokusyu_mentsu, @atama.clone)
      end
    end

    #-------------------------------------------------#
    # 特殊面子を取得する
    #-------------------------------------------------#
    def get_tokusyu_mentsu
        pai_list = Array.new
        @pai_counts.each do |pai|
          pai_list << Pai.new(pai.type + pai.number.to_s, pai.is_naki, pai.is_agari)
        end
        return Mentsu.new(pai_list, Mentsu::MENTSU_TYPE_TOKUSYU, false)
    end
  end
end



=begin
    # agariに含まれる文字列から牌クラス(Pai)のリストを取得する(連結によって廃止される)
    def get_pai_list(tehai_list)
      tehai_items = tehai_list.scan(/.{1,2}/m)
      pai_items = Array.new
      tehai_items.each do |item| 
        if item == tehai_items[tehai_items.size - 1]
          pai_items << Pai.new(item, false, true)
        else
          pai_items << Pai.new(item, false, false)
        end
      end
      return pai_items
    end
=end
