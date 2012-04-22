# -*- coding: utf-8 -*-

require 'renum'

module Mjparse
  enum :Type, [:Manzu, :Pinzu, :Souzu, :Jihai, :Reverse]

  enum :PaiType do
    M1('m1', Type::Manzu, true, false)
    M2('m2', Type::Manzu, false, false)
    M3('m3', Type::Manzu, false, false)
    M4('m4', Type::Manzu, false, false)
    M5('m5', Type::Manzu, false, false)
    M6('m6', Type::Manzu, false, false)
    M7('m7', Type::Manzu, false, false)
    M8('m8', Type::Manzu, false, false)
    M9('m9', Type::Manzu, true, false)
    P1('p1', Type::Pinzu, true, false)
    P2('p2', Type::Pinzu, false, false)
    P3('p3', Type::Pinzu, false, false)
    P4('p4', Type::Pinzu, false, false)
    P5('p5', Type::Pinzu, false, false)
    P6('p6', Type::Pinzu, false, false)
    P7('p7', Type::Pinzu, false, false)
    P8('p8', Type::Pinzu, false, false)
    P9('p9', Type::Pinzu, true, false)
    S1('s1', Type::Souzu, true, false)
    S2('s2', Type::Souzu, false, false)
    S3('s3', Type::Souzu, false, false)
    S4('s4', Type::Souzu, false, false)
    S5('s5', Type::Souzu, false, false)
    S6('s6', Type::Souzu, false, false)
    S7('s7', Type::Souzu, false, false)
    S8('s8', Type::Souzu, false, false)
    S9('s9', Type::Souzu, true, false)
    J1('j1', Type::Jihai, false, true)
    J2('j2', Type::Jihai, false, true)
    J3('j3', Type::Jihai, false, true)
    J4('j4', Type::Jihai, false, true)
    J5('j5', Type::Jihai, false, false)
    J6('j6', Type::Jihai, false, false)
    J7('j7', Type::Jihai, false, false)
    R0('r0', Type::Reverse, false, false)

    def init(code, type, is_raotou, is_kaze)
      @code = code
      @type = type
      @is_raotou = is_raotou
      @is_kaze = is_kaze
    end

    def self.get(code)
      values.find{|p| p.is_code?(code)}
    end

    def is_code?(code)
      @code == code
    end

    def type
      @type
    end

    def is_type?(type)
      @type == type
    end

    def manzu?
      is_type?(Type::Manzu)
    end

    def pinzu?
      is_type?(Type::Pinzu)
    end

    def souzu?
      is_type?(Type::Souzu)
    end

    def suhai?
      manzu? || pinzu? || souzu?
    end

    def jihai?
      is_type?(Type::Jihai)
    end

    def reverse?
      is_type?(Type::Reverse)
    end

    def raotou?
      @is_raotou
    end

    def chunchan?
      suhai? && !raotou?
    end

    def yaochu?
      raotou? || jihai?
    end

    def kaze?
      @is_kaze
    end

    def sangen?
      jihai? && !kaze?
    end
  end
end
