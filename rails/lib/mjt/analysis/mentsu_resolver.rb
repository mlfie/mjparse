module Mjt::Analysis
  # あがりの形を得る
  class MentsuResolver
    
    class PaiCountItems
      attr_accessor :pai, :count, :startpos
    end
    
    def get_mentsu(agari)
      get_pai_list(agari.tehai_list)
      
      get_atama_queue(@pai_list)
      
      # 頭を仮定して刻子/順子などの面子の状況を見る
      for atama in @atama_queue
        
      end
    end

    # agariからPaiの配列を取得する
#    private
    def get_pai_list(tehai_list)
      tehai_items = tehai_list.scan(/.{1,2}/m)
      pai_items = nil
      tehai_items.each_with_index { |item, idx| 
        if idx == (tehai_items.size - 1)
          pai_items << Pai.new(item, true)
        else
          pai_items << Pai.new(item, false)
        end
      }
      # TODO before_sortをPai.type > Pai.numberの順番にソートする
      @pai_list
    end
    
    # 雀頭候補を取得する
    def get_atama_queue(pai_list)
      @atama_queue = nil
      (pai_list.size-2).times { |i|
        if pai_list[i].type == pai_list[i+1].type && pai_list[i].number == pai_list[i+1].number
          atama_queue << i
          i = i + 1
        end
      }
    end
      
    # 探索を開始する面子の初期状態を設定
    def set_start_mentsu
      
    end
    
    # 浮き牌を数える
    def set_pai_count
      
    end
    
    # 刻子かどうか調べる
    def is_koutsu
      
    end
    
    # 順子かどうか調べる
    def is_shuntsu
      
    end
  end
end