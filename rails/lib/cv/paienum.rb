require 'cv/enum'

module CV
  class PaiEnum
      @@type = Enum.new("Type", :J1, :J2, :J3, :J4, :J5, :J6, :J7,
                           :M1, :M2, :M3, :M4, :M5, :M6, :M7, :M8, :M9,
                           :P1, :P2, :P3, :P4, :P5, :P6, :P7, :P8, :P9,
                           :S1, :S2, :S3, :S4, :S5, :S6, :S7, :S8, :S9)
          
      def PaiEnum.type_e
          return @@type
      end
  end
end

        
