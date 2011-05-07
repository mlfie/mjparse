#!/usr/bin/env ruby -W0
# -*- coding: utf-8 -*-

require "rubygems"
require "opencv"
include OpenCV

result_window = GUI::Window.new "result"
temp_window = GUI::Window.new "temp"

img1 = IplImage.load(ARGV[0], CV_LOAD_IMAGE_GRAYSCALE)
img2 = IplImage.load(ARGV[1], CV_LOAD_IMAGE_GRAYSCALE)
out = img1.clone()

## mat.match_template(templ, method)
begin
  result = img1.match_template(img2, CV_TM_CCOEFF_NORMED)
  result_window.show result
  GUI::wait_key
  min_val, max_val, min_loc, max_loc = result.min_max_loc
  img1.rectangle!(CvPoint.new(max_loc.x, max_loc.y), CvPoint.new(max_loc.x + img2.cols, max_loc.y + img2.rows),
                 :color => CvColor::White, :thickness => -1)
  out.rectangle!(CvPoint.new(max_loc.x, max_loc.y), CvPoint.new(max_loc.x + img2.cols, max_loc.y + img2.rows),
                 :color => CvColor::Black, :thickness => 3)
  puts "val = #{max_val}"
  temp_window.show out
  GUI::wait_key
end while (max_val > 0.6)


temp_window.show out
GUI::wait_key

