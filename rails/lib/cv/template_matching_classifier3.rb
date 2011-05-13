#!/usr/bin/env ruby -W0
# -*- coding: utf-8 -*-
require "rubygems"
require "opencv"
require 'cv/pai'
require 'cv/paienum'

module CV
  class TemplateMatchingClassifier
    include OpenCV

    
    DIRPATH = 'cv/base2'
    RANGE = 5
      def classify(img)
          @pai_list = Array.new
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
        target_img = IplImage.load(img, CV_LOAD_IMAGE_COLOR)
        
        min_val = [0,0,0]
        max_val = [0,0,0]
        min_loc = [0,0,0]
        max_loc = [0,0,0]
        
        Dir::glob(DIRPATH+'/*[^n].jpg').each {|f|
          target = target_img.clone
          target_array = target.split
          begin
            val = 0
            templ_img = IplImage.load(f, CV_LOAD_IMAGE_COLOR)
            templ_array = templ_img.split
             
            target_array.each_with_index do |e,i|
              result = e.match_template(templ_array[i], CV_TM_CCOEFF_NORMED)
              
              min_val[i], max_val[i], min_loc[i], max_loc[i] = result.min_max_loc
              target_array[i].rectangle!(CvPoint.new(max_loc[i].x, max_loc[i].y), 
                        CvPoint.new(max_loc[i].x + templ_img.cols, max_loc[i].y + templ_img.rows),
                       :color => CvColor::White, :thickness => -1)
            end
              #3個が同じ位置
            if (max_loc[0].x == max_loc[1].x && max_loc[0].x == max_loc[2].x &&
                  max_loc[0].y == max_loc[1].y && max_loc[0].y == max_loc[2].y)
                  val = max_val[0] + max_val[1] + max_val[2]
            #3個中、２個が同じだったら
            elsif (max_loc[0].x >= max_loc[1].x - RANGE && max_loc[1].x + RANGE >= max_loc[0].x) 
                  val = max_val[0] + max_val[1]
            elsif (max_loc[0].x >= max_loc[2].x - RANGE && max_loc[2].x + RANGE >= max_loc[0].x)
                  val = max_val[0] + max_val[2]
            elsif (max_loc[1].x >= max_loc[2].x - RANGE && max_loc[2].x + RANGE >= max_loc[0].x)
                  val = max_val[1] + max_val[2]
            end
            if(val > 1.5)        
              pai = CV::Pai.new(0, 0, templ_img.cols, templ_img.rows, val, @type_hash[File.basename(f).split('.')[0].upcase])
              @pai_list.push(pai)
             
              puts "val = #{pai.value}"
              puts "type = #{pai.type}"
            end
          end while (val > 1)
          
        }
        return @pai_list
        
      end
      
      
  end
end
