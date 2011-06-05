module CV
  class Selector
    def select(pais)
      selected = []
      pais.each do |pai|
        nearest = pai.nearest(selected)
        if nearest && (pai.intersect_area(nearest) / pai.area) > 0.1
        #if nearest && pai.intersect?(nearest)
          if pai.value > nearest.value
            puts "selected.size = #{selected.size}"
            selected.delete(nearest)
            puts "selected.size deleted = #{selected.size}"
            selected << pai
          end
        else
          selected << pai
        end
      end
      return selected
    end
  end
end
