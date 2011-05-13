#!/usr/bin/ruby -w0
# -*- coding: utf-8 -*-
require 'cv/template_matching_classifier'

DIRPATH = 'cv/test_img/'
IMGNAME = 'test003.jpg'

tmc = CV::TemplateMatchingClassifier.new

#pai_list = tmc.classify(DIRPATH + '/test001.jpg')
pai_list = tmc.classify(DIRPATH + IMGNAME)
p pai_list.size

puts "IMGNAME = #{IMGNAME}"