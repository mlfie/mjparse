module CV
  class Selector
    def select(pais)
      selected = []
      pais.each do |pai|
        nearest = pai.nearest(selected)
if nearest
  puts "pai = #{pai.x}, #{pai.y}, #{pai.width}, #{pai.height}"
  puts "nea = #{nearest.x}, #{nearest.y}, #{nearest.width}, #{nearest.height}"
  puts "int = #{pai.intersect_area(nearest)}"
  puts "are = #{pai.area}"
  puts "i/a = #{pai.intersect_area(nearest)/pai.area}"
end
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
