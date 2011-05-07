#!/usr/bin/env ruby -W0
# -*- coding: utf-8 -*-

require "rubygems"
require "opencv"
include OpenCV

result_window = GUI::Window.new "result"
temp_window = GUI::Window.new "temp"
bin_window = GUI::Window.new "bin"
tmpl_window = GUI::Window.new "tmpl"

img1 = IplImage.load(ARGV[0], CV_LOAD_IMAGE_GRAYSCALE)
img2 = IplImage.load(ARGV[1], CV_LOAD_IMAGE_GRAYSCALE)
out = img1.clone()

# ruby-opencvにadaptiveThresholdの実装がない。。
bin_img,th1 = img1.threshold(0, 255, CV_THRESH_OTSU)
bin_tmpl,th2 = img2.threshold(0, 255, CV_THRESH_OTSU)
bin_window.show bin_img
tmpl_window.show bin_tmpl
GUI::wait_key

## mat.match_template(templ, method)
begin
  result = bin_img.match_template(bin_tmpl, CV_TM_CCOEFF_NORMED)
  result_window.show result
  GUI::wait_key
  min_val, max_val, min_loc, max_loc = result.min_max_loc
  bin_img.rectangle!(CvPoint.new(max_loc.x, max_loc.y), CvPoint.new(max_loc.x + img2.cols, max_loc.y + img2.rows),
                 :color => CvColor::White, :thickness => -1)
  out.rectangle!(CvPoint.new(max_loc.x, max_loc.y), CvPoint.new(max_loc.x + img2.cols, max_loc.y + img2.rows),
                 :color => CvColor::Black, :thickness => 3)
  puts "val = #{max_val}"
  temp_window.show out
  GUI::wait_key
end while (max_val > 0.6)


temp_window.show out
GUI::wait_key

