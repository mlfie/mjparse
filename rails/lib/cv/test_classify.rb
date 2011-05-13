#!/usr/bin/ruby -w0
# -*- coding: utf-8 -*-
require 'cv/template_matching_classifier'

DIRPATH = 'cv/test_img'

tmc = CV::TemplateMatchingClassifier.new

pai_list = tmc.classify(DIRPATH + '/DSC_0013.jpg')
p pai_list.size