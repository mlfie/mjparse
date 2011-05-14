module Mjt::Analysis
  # あがりの形を得る
  class MentsuResolver
    
    attr_accessor :result_list  # 結果(Result)の配列
    
    def initialize
      self.result_list = Array.new
    end
    
    # 同一の牌がいくつあるか保持する
    class PaiCount
      attr_accessor :type,    # 牌の種類(m:萬子 s:索子 p:筒子 j:字牌)
                    :number,  # 数字(字牌の場合、1:東 2:南 3:西 4:北 5:白 6:發 7:中)
                    :count,   # 牌の数
                    :is_agari # アガリ牌
      
      def initialize(type, number, is_agari)
        self.type     = type
        self.number   = number
        self.count    = 1
        self.is_agari = is_agari
      end
    end
    
    def get_mentsu(agari)
      get_pai_list(agari.tehai_list)
      
      get_atama_queue
      
      if @atama_queue.size != 0
        # 頭を仮定して刻子/順子などの面子の状況を見る
        for atama_pos in @atama_queue
          count_same_pai(atama_pos)
          
          # TODO 十三不塔/国士無双かどうかを調べる
          @mentsu_list = Array.new
          set_mentsu(@pai_counts)            
        end
      end
    end

    # agariからPaiの配列を取得する
    private
    def get_pai_list(tehai_list)
      tehai_items = tehai_list.scan(/.{1,2}/m)
      pai_items = Array.new
      tehai_items.each do |item| 
        pai_items << Pai.new(item, false)        
      end
      @agari_hai = pai_items[pai_items.size - 1] 
      @pai_list = pai_items.sort_by { |pai| [pai.type, pai.number] }
    end
    
    # 雀頭候補を取得する
    def get_atama_queue
      @atama_queue = Array.new
      (@pai_list.size-1).times { |i|
        if @pai_list[i].type == @pai_list[i+1].type && @pai_list[i].number == @pai_list[i+1].number
          @atama_queue << i
        end
      }
    end
      
    # 各牌の個数を調べる
    def count_same_pai(atama_pos)
      _pai_list = @pai_list.clone

      # 頭を削除する
      _pai_list.slice!(atama_pos, 2)
      
      @pai_counts = Array.new
      _last_pai_count = nil
      _pai_list.each_with_index { |pai, idx|
        # 最初だけ特別処理
        if idx == 0
          if pai == @agari_hai
            __pai_count = PaiCount.new(pai.type, pai.number, true)
          else
            __pai_count = PaiCount.new(pai.type, pai.number, false)
          end
          @pai_counts << __pai_count
          _last_pai_count = __pai_count
          next
        end
        # 一致したらcountを1増やす
        if pai.type == _last_pai_count.type && pai.number == _last_pai_count.number
          _last_pai_count.count += 1
        else
          if pai == @agari_hai
            __pai_count = PaiCount.new(pai.type, pai.number, true)
          else
            __pai_count = PaiCount.new(pai.type, pai.number, false)
          end
          @pai_counts << __pai_count
          _last_pai_count = __pai_count
        end
      }
    end
    
    def set_mentsu(pai_count_list)
      # 面子候補リストが完全に無くなったら終了
      if pai_count_list.size == 0
        self.result_list << Result.new(Marshal.load(Marshal.dump(@mentsu_list)))
        return
      end

      pai_count_list = pai_count_list.sort_by { |pc| [pc.type, pc.number] }

      # 刻子の判定へ
      if is_koutsu?(pai_count_list[0])
        pai_count = pai_count_list[0]
        mentsu = Mentsu.new
        mentsu.pai_list << Pai.new(pai_count.type + pai_count.number.to_s, pai_count.is_agari)
        mentsu.pai_list << Pai.new(pai_count.type + pai_count.number.to_s, pai_count.is_agari)
        mentsu.pai_list << Pai.new(pai_count.type + pai_count.number.to_s, pai_count.is_agari)
        mentsu.mentsu_type = 'k'
        @mentsu_list.push(mentsu)
        if pai_count.count == 3
          pai_count_list.shift
          set_mentsu(pai_count_list)
          pai_count_list.unshift(pai_count)
        else
          pai_count.count -= 3
          set_mentsu(pai_count_list)
          pai_count.count += 3
        end
        @mentsu_list.pop
      end

      pai_count_list = pai_count_list.sort_by { |pc| [pc.type, pc.number] }
      
      # 順子の判定へ
      if is_shuntsu?(pai_count_list)
        pai_count1 = pai_count_list[0]
        pai_count2 = pai_count_list[1]
        pai_count3 = pai_count_list[2]
        mentsu = Mentsu.new
        mentsu.pai_list << Pai.new(pai_count1.type + pai_count1.number.to_s, pai_count1.is_agari)
        mentsu.pai_list << Pai.new(pai_count2.type + pai_count2.number.to_s, pai_count2.is_agari)
        mentsu.pai_list << Pai.new(pai_count3.type + pai_count3.number.to_s, pai_count3.is_agari)
        mentsu.mentsu_type = 's'
        @mentsu_list.push(mentsu)
        _is_shift1 = false
        _is_shift2 = false
        _is_shift3 = false
        
        if pai_count3.count == 1
          pai_count_list.delete_at(2)
          _is_shift3 = true
        else
          pai_count3.count -= 1
        end
        if pai_count2.count == 1
          pai_count_list.delete_at(1)
          _is_shift2 = true
        else
          pai_count2.count -= 1
        end
        if pai_count1.count == 1
          pai_count_list.delete_at(0)
          _is_shift1 = true
        else
          pai_count1.count -= 1
        end

        set_mentsu(pai_count_list)

        if _is_shift3
          pai_count_list.unshift(pai_count3)
        else
          pai_count3.count += 1
        end
        if _is_shift2
          pai_count_list.unshift(pai_count2)
        else
          pai_count2.count += 1
        end
        if _is_shift1
          pai_count_list.unshift(pai_count1)
        else
          pai_count1.count += 1
        end
        @mentsu_list.pop
      end
    end
    
    # 刻子かどうか調べる
    def is_koutsu?(pai_count)
      if pai_count.count >= 3
        return true
      end
      return false
    end
    
    # 順子かどうか調べる
    def is_shuntsu?(pai_count_list)
      # 牌カウントが3枚未満ならfalse
      if pai_count_list.size < 3
        return false
      end
      pai_count1 = pai_count_list[0]
      # 先頭の牌の種類が字牌ならfalse
      if pai_count1.type == 'j'
        return false
      end
      pai_count2 = pai_count_list[1]
      pai_count3 = pai_count_list[2]
      if pai_count1.type == pai_count2.type && pai_count1.type == pai_count3.type &&
         (pai_count1.number+1) == pai_count2.number && (pai_count1.number+2) == pai_count3.number
        return true
      end
      # 上記の条件を満たさない場合はfalse
      return false
    end
  end
end