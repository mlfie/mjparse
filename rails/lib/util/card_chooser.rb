module Util
  class CardChooser
    attr_reader :current_size

    def initialize(size)
      @index = generate_index(size)
      @choosed = []
      @current_size = size
    end

    def choose(n)
      @current_size -= 1

      idx = @index[n]
      tail = @current_size
      swap(n, tail)
      @choosed << n
      return idx
    end

    def undo
      tail = @current_size
      n = @choosed.pop
      idx = @index[tail]
      swap(n, tail)
      @current_size += 1
      return idx
    end

    private
    def swap(a, b)
      tmp = @index[a]
      @index[a] = @index[b]
      @index[b] = tmp
    end

    def generate_index(size)
      a = Array.new
      size.times {|i|
        a << i
      }
      return a
    end

  end
end
