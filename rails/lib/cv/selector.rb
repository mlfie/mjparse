module CV
  class Selector
    def select(pais)
      selected = []
      pais.each do |pai|
        nearest = pai.nearest(selected)
        if nearest && pai.intersect_area(nearest) / pai.area > 0.3
          if pai.value > nearest.value
            selected.delete(nearest)
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
