#!/usr/bin/ruby -w0
# -*- coding: utf-8 -*-

require 'cv/pai'
require 'cv/paienum'

pai = CV::Pai.new(1, 2, 3, 4, 5, CV::PaiEnum.type_e::J1)
puts pai.x
puts pai.y
puts pai.width
puts pai.height
puts pai.value
puts pai.type

