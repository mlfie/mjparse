#!/usr/bin/env ruby -W0
# -*- coding: utf-8 -*-
require "rubygems"
require "opencv"
require 'mlfielib/cv/pai'
require 'mlfielib/cv/paienum'

module Mlfielib
  module CV
    class TemplateMatchingClassifier
      include OpenCV

      DIRPATH = 'olib/mlfielib/cv/base'
      def initialize()
            @type_hash = {"J1" => CV::PaiEnum.type_e::J1,
                    "J2" => CV::PaiEnum.type_e::J2,
                    "J3" => CV::PaiEnum.type_e::J3,
                    "J4" => CV::PaiEnum.type_e::J4,
                    "J5" => CV::PaiEnum.type_e::J5,
                    "J6" => CV::PaiEnum.type_e::J6,
                    "J7" => CV::PaiEnum.type_e::J7,
                    "M1" => CV::PaiEnum.type_e::M1,
                    "M2" => CV::PaiEnum.type_e::M2,
                    "M3" => CV::PaiEnum.type_e::M3,
                    "M4" => CV::PaiEnum.type_e::M4,
                    "M5" => CV::PaiEnum.type_e::M5,
                    "M6" => CV::PaiEnum.type_e::M6,
                    "M7" => CV::PaiEnum.type_e::M7,
                    "M8" => CV::PaiEnum.type_e::M8,
                    "M9" => CV::PaiEnum.type_e::M9,
                    "P1" => CV::PaiEnum.type_e::P1,
                    "P2" => CV::PaiEnum.type_e::P2,
                    "P3" => CV::PaiEnum.type_e::P3,
                    "P4" => CV::PaiEnum.type_e::P4,
                    "P5" => CV::PaiEnum.type_e::P5,
                    "P6" => CV::PaiEnum.type_e::P6,
                    "P7" => CV::PaiEnum.type_e::P7,
                    "P8" => CV::PaiEnum.type_e::P8,
                    "P9" => CV::PaiEnum.type_e::P9,
                    "S1" => CV::PaiEnum.type_e::S1,
                    "S2" => CV::PaiEnum.type_e::S2,
                    "S3" => CV::PaiEnum.type_e::S3,
                    "S4" => CV::PaiEnum.type_e::S4,
                    "S5" => CV::PaiEnum.type_e::S5,
                    "S6" => CV::PaiEnum.type_e::S6,
                    "S7" => CV::PaiEnum.type_e::S7,
                    "S8" => CV::PaiEnum.type_e::S8,
                    "S9" => CV::PaiEnum.type_e::S9
                   }
            @is_symmetric = {"J1" => false,
                    "J2" => false,
                    "J3" => false,
                    "J4" => false,
                    "J5" => false,
                    "J6" => false,
                    "J7" => false,
                    "M1" => false,
                    "M2" => false,
                    "M3" => false,
                    "M4" => false,
                    "M5" => false,
                    "M6" => false,
                    "M7" => false,
                    "M8" => false,
                    "M9" => false,
                    "P1" => true,
                    "P2" => true,
                    "P3" => true,
                    "P4" => true,
                    "P5" => true,
                    "P6" => false,
                    "P7" => false,
                    "P8" => true,
                    "P9" => true,
                    "S1" => false,
                    "S2" => true,
                    "S3" => false,
                    "S4" => true,
                    "S5" => true,
                    "S6" => true,
                    "S7" => false,
                    "S8" => true,
                    "S9" => true
                   }
          @pais = []
          Dir::glob(DIRPATH+'/*[^n].*.jpg').each {|f|
            pai_type = @type_hash[File.basename(f).split('.')[0].upcase]
            pai_direction = case File.basename(f).split('.')[1]
                            when 't'
                              :top
                            when 'r'
                              :right
                            else
                              :top
                            end
            symmetric = @is_symmetric[File.basename(f).split('.')[0].upcase]
            img = CvMat.load(f, CV_LOAD_IMAGE_GRAYSCALE)
            @pais << {:img => img, :pai_type => pai_type, :pai_direction => pai_direction, :symmetric => symmetric}
          }
      end
      
        def classify(img, scale=1.0)

          target_img = CvMat.load(img, CV_LOAD_IMAGE_GRAYSCALE)
          pai_list = []
          
          @pais.each {|pai|
            pai_list = pai_list.concat(search_pai(target_img, pai[:img], pai[:pai_type], pai[:pai_direction], scale))
            pai_list = pai_list.concat(search_pai_fliped(target_img, pai[:img], pai[:pai_type], pai[:pai_direction], scale)) unless pai[:symmetric]
          
          }
          return pai_list
          
        end

        def search_pai_fliped(target_img, template_img, pai_type, pai_direction, scale)
          pai_list = search_pai(target_img.flip(:xy), template_img, pai_type, pai_direction, scale)

          scaled_img = template_img.resize(
            CvSize.new(template_img.cols * scale, template_img.rows * scale), :linear)
          #pai_list = pai_list.map{|pai|
          #  puts "before = (#{pai.x}, #{pai.y})"
          #  pai.x = target_img.cols - pai.x - scaled_img.cols
          #  pai.y = target_img.rows - pai.y - scaled_img.rows
          #  puts "after = (#{pai.x}, #{pai.y})"
          #  pai
          #}
          pai_list
        end
          

        def search_pai(target_img, template_img, pai_type, pai_direction, scale)
          pai_list = []

          template_img = template_img.resize(
            CvSize.new(template_img.cols * scale, template_img.rows * scale),
            :linear)
          result = target_img.match_template(template_img, CV_TM_CCOEFF_NORMED)

          begin
            min_val, max_val, min_loc, max_loc = result.min_max_loc
            result.rectangle!(
              CvPoint.new(max_loc.x - template_img.cols/2, max_loc.y - template_img.rows/2),
              CvPoint.new(max_loc.x + template_img.cols/2, max_loc.y + template_img.rows/2),
              :color => CvColor::Black,
              :thickness => -1
            )
            if(max_val > 0.6)
              pai = CV::Pai.new(max_loc.x, max_loc.y, template_img.cols, template_img.rows,max_val, pai_type, pai_direction)
              pai_list.push(pai)
            end
          end while(max_val > 0.6)

          return pai_list
        end
    end
  end
end
