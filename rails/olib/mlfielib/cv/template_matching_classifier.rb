#!/usr/bin/env ruby -W0
# -*- coding: utf-8 -*-
require "rubygems"
require "opencv"
require 'mlfielib/cv/pai'
require 'mlfielib/cv/paienum'
require 'mlfielib/cv/template_matching'

module Mlfielib
  module CV
    class TemplateMatchingClassifier
      include OpenCV
      include Mlfielib::CV::TemplateMatching

      DIRPATH = File.expand_path('../base', __FILE__)
      KEYS = [:type, :direction, :symmetric, :threshold, :image_paths]
      SETTINGS = [
          [CV::PaiEnum.type_e::J1, :top, false, nil, ["#{DIRPATH}/j1.t.jpg"]],
          [CV::PaiEnum.type_e::J2, :top, false, nil, ["#{DIRPATH}/j2.t.jpg"]],
          [CV::PaiEnum.type_e::J3, :top, false, nil, ["#{DIRPATH}/j3.t.jpg"]],
          [CV::PaiEnum.type_e::J4, :top, false, nil, ["#{DIRPATH}/j4.t.jpg"]],
          [CV::PaiEnum.type_e::J5, :top, true, nil,  ["#{DIRPATH}/j5.t.jpg"]],
          [CV::PaiEnum.type_e::J6, :top, false, nil, ["#{DIRPATH}/j6.t.jpg"]],
          [CV::PaiEnum.type_e::J7, :top, false, nil, ["#{DIRPATH}/j7.t.jpg"]],
          [CV::PaiEnum.type_e::M1, :top, false, 0.7, ["#{DIRPATH}/m1.t.jpg"]],
          [CV::PaiEnum.type_e::M2, :top, false, 0.7, ["#{DIRPATH}/m2.t.jpg"]],
          [CV::PaiEnum.type_e::M3, :top, false, 0.7, ["#{DIRPATH}/m3.t.jpg"]],
          [CV::PaiEnum.type_e::M4, :top, false, 0.7, ["#{DIRPATH}/m4.t.jpg"]],
          [CV::PaiEnum.type_e::M5, :top, false, 0.7, ["#{DIRPATH}/m5.t.jpg"]],
          [CV::PaiEnum.type_e::M6, :top, false, 0.7, ["#{DIRPATH}/m6.t.jpg"]],
          [CV::PaiEnum.type_e::M7, :top, false, 0.7, ["#{DIRPATH}/m7.t.jpg"]],
          [CV::PaiEnum.type_e::M8, :top, false, 0.7, ["#{DIRPATH}/m8.t.jpg"]],
          [CV::PaiEnum.type_e::M9, :top, false, 0.7, ["#{DIRPATH}/m9.t.jpg"]],
          [CV::PaiEnum.type_e::P1, :top, true, nil,  ["#{DIRPATH}/p1.t.jpg"]],
          [CV::PaiEnum.type_e::P2, :top, true, nil,  ["#{DIRPATH}/p2.t.jpg"]],
          [CV::PaiEnum.type_e::P3, :top, true, nil,  ["#{DIRPATH}/p3.t.jpg"]],
          [CV::PaiEnum.type_e::P4, :top, true, nil,  ["#{DIRPATH}/p4.t.jpg"]],
          [CV::PaiEnum.type_e::P5, :top, true, nil,  ["#{DIRPATH}/p5.t.jpg"]],
          [CV::PaiEnum.type_e::P6, :top, false, nil, ["#{DIRPATH}/p6.t.jpg"]],
          [CV::PaiEnum.type_e::P7, :top, false, nil, ["#{DIRPATH}/p7.t.jpg"]],
          [CV::PaiEnum.type_e::P8, :top, true, nil,  ["#{DIRPATH}/p8.t.jpg"]],
          [CV::PaiEnum.type_e::P9, :top, true, nil,  ["#{DIRPATH}/p9.t.jpg"]],
          [CV::PaiEnum.type_e::S1, :top, false, nil, ["#{DIRPATH}/s1.t.jpg"]],
          [CV::PaiEnum.type_e::S2, :top, true, nil,  ["#{DIRPATH}/s2.t.jpg"]],
          [CV::PaiEnum.type_e::S3, :top, false, nil, ["#{DIRPATH}/s3.t.jpg"]],
          [CV::PaiEnum.type_e::S4, :top, true, nil,  ["#{DIRPATH}/s4.t.jpg"]],
          [CV::PaiEnum.type_e::S5, :top, true, nil,  ["#{DIRPATH}/s5.t.jpg"]],
          [CV::PaiEnum.type_e::S6, :top, true, nil,  ["#{DIRPATH}/s6.t.jpg"]],
          [CV::PaiEnum.type_e::S7, :top, false, nil, ["#{DIRPATH}/s7.t.jpg"]],
          [CV::PaiEnum.type_e::S8, :top, true, nil,  ["#{DIRPATH}/s8.t.jpg"]],
          [CV::PaiEnum.type_e::S9, :top, true, nil,  ["#{DIRPATH}/s9.t.jpg"]],
          [CV::PaiEnum.type_e::J1, :right, false, nil, ["#{DIRPATH}/j1.r.jpg"]],
          [CV::PaiEnum.type_e::J2, :right, false, nil, ["#{DIRPATH}/j2.r.jpg"]],
          [CV::PaiEnum.type_e::J3, :right, false, nil, ["#{DIRPATH}/j3.r.jpg"]],
          [CV::PaiEnum.type_e::J4, :right, false, nil, ["#{DIRPATH}/j4.r.jpg"]],
          [CV::PaiEnum.type_e::J5, :right, true, nil,  ["#{DIRPATH}/j5.r.jpg"]],
          [CV::PaiEnum.type_e::J6, :right, false, nil, ["#{DIRPATH}/j6.r.jpg"]],
          [CV::PaiEnum.type_e::J7, :right, false, nil, ["#{DIRPATH}/j7.r.jpg"]],
          [CV::PaiEnum.type_e::M1, :right, false, nil, ["#{DIRPATH}/m1.r.jpg"]],
          [CV::PaiEnum.type_e::M2, :right, false, nil, ["#{DIRPATH}/m2.r.jpg"]],
          [CV::PaiEnum.type_e::M3, :right, false, nil, ["#{DIRPATH}/m3.r.jpg"]],
          [CV::PaiEnum.type_e::M4, :right, false, nil, ["#{DIRPATH}/m4.r.jpg"]],
          [CV::PaiEnum.type_e::M5, :right, false, nil, ["#{DIRPATH}/m5.r.jpg"]],
          [CV::PaiEnum.type_e::M6, :right, false, nil, ["#{DIRPATH}/m6.r.jpg"]],
          [CV::PaiEnum.type_e::M7, :right, false, nil, ["#{DIRPATH}/m7.r.jpg"]],
          [CV::PaiEnum.type_e::M8, :right, false, nil, ["#{DIRPATH}/m8.r.jpg"]],
          [CV::PaiEnum.type_e::M9, :right, false, nil, ["#{DIRPATH}/m9.r.jpg"]],
          [CV::PaiEnum.type_e::P1, :right, true, nil,  ["#{DIRPATH}/p1.r.jpg"]],
          [CV::PaiEnum.type_e::P2, :right, true, nil,  ["#{DIRPATH}/p2.r.jpg"]],
          [CV::PaiEnum.type_e::P3, :right, true, nil,  ["#{DIRPATH}/p3.r.jpg"]],
          [CV::PaiEnum.type_e::P4, :right, true, nil,  ["#{DIRPATH}/p4.r.jpg"]],
          [CV::PaiEnum.type_e::P5, :right, true, nil,  ["#{DIRPATH}/p5.r.jpg"]],
          [CV::PaiEnum.type_e::P6, :right, false, nil, ["#{DIRPATH}/p6.r.jpg"]],
          [CV::PaiEnum.type_e::P7, :right, false, nil, ["#{DIRPATH}/p7.r.jpg"]],
          [CV::PaiEnum.type_e::P8, :right, true, nil,  ["#{DIRPATH}/p8.r.jpg"]],
          [CV::PaiEnum.type_e::P9, :right, true, nil,  ["#{DIRPATH}/p9.r.jpg"]],
          [CV::PaiEnum.type_e::S1, :right, false, nil, ["#{DIRPATH}/s1.r.jpg"]],
          [CV::PaiEnum.type_e::S2, :right, true, nil,  ["#{DIRPATH}/s2.r.jpg"]],
          [CV::PaiEnum.type_e::S3, :right, false, nil, ["#{DIRPATH}/s3.r.jpg"]],
          [CV::PaiEnum.type_e::S4, :right, true, nil,  ["#{DIRPATH}/s4.r.jpg"]],
          [CV::PaiEnum.type_e::S5, :right, true, nil,  ["#{DIRPATH}/s5.r.jpg"]],
          [CV::PaiEnum.type_e::S6, :right, true, nil,  ["#{DIRPATH}/s6.r.jpg"]],
          [CV::PaiEnum.type_e::S7, :right, false, nil, ["#{DIRPATH}/s7.r.jpg"]],
          [CV::PaiEnum.type_e::S8, :right, true, nil,  ["#{DIRPATH}/s8.r.jpg"]],
          [CV::PaiEnum.type_e::S9, :right, true, nil,  ["#{DIRPATH}/s9.r.jpg"]],
          [CV::PaiEnum.type_e::R0, :top, true, nil,    ["#{DIRPATH}/r0.t.jpg"]]
        ]

      def initialize()
        @matchers = []
        SETTINGS.each do |setting|
          hash = {}
          KEYS.zip(setting).each do |pair|
            hash[pair[0]] = pair[1]
          end
          @matchers << TemplateMatcher.new(hash)
        end

        define_r0_detector
      end

      def define_r0_detector
        r0_matcher = @matchers.select{|x| x.type == CV::PaiEnum.type_e::R0}[0]
        class << r0_matcher
          alias :org_detect :detect
        end
        def r0_matcher.detect(target_img, scale)
          pais = org_detect(target_img, scale)

          pais.select do |pai|
            pai_area = target_img.sub_rect(CvRect.new(pai.left, pai.top, pai.width, pai.height))
            pai_area.avg[0] < 230
          end
        end
      end
      
      def classify(img, scale=1.0)
        target_img = CvMat.load(img, CV_LOAD_IMAGE_GRAYSCALE)
        pai_list = []

        @matchers.each do |matcher|
          pai_list.concat(matcher.detect(target_img, scale))
        end
        return pai_list
      end
    end
  end
end
