# -*- coding: utf-8 -*-
require 'test_helper'

class TypeTest < Test::Unit::TestCase
  include Mjparse

  def test_manzu
    assert_equal %w[M1 M2 M3 M4 M5 M6 M7 M8 M9], select {|p| p.manzu?}
  end

  def test_pinzu
    assert_equal %w[P1 P2 P3 P4 P5 P6 P7 P8 P9], select {|p| p.pinzu?}
  end

  def test_souzu
    assert_equal %w[S1 S2 S3 S4 S5 S6 S7 S8 S9], select {|p| p.souzu?}
  end

  def test_jihai
    assert_equal %w[J1 J2 J3 J4 J5 J6 J7], select {|p| p.jihai?}
  end

  def test_reverse
    assert_equal %w[R0], select {|p| p.reverse?}
  end

  def test_raotou
    assert_equal %w[M1 M9 P1 P9 S1 S9], select{|p| p.raotou?}
  end

  def test_kaze
    assert_equal %w[J1 J2 J3 J4], select{|p| p.kaze?}
  end

  def test_yaochu
    assert_equal %w[M1 M9 P1 P9 S1 S9 J1 J2 J3 J4 J5 J6 J7], select{|p| p.yaochu?}
  end

  def test_sangen
    assert_equal %w[J5 J6 J7], select{|p| p.sangen?}
  end

  def test_chunchan
    assert_equal %w[M2 M3 M4 M5 M6 M7 M8 P2 P3 P4 P5 P6 P7 P8 S2 S3 S4 S5 S6 S7 S8],
      select{|p| p.chunchan?}
  end

  def test_suhai
    assert_equal %w[M1 M2 M3 M4 M5 M6 M7 M8 M9 P1 P2 P3 P4 P5 P6 P7 P8 P9 S1 S2 S3 S4 S5 S6 S7 S8 S9],
      select{|p| p.suhai?}
  end

  def select
    PaiType.values.select{|p| yield p}.map{|p| p.name}
  end

  def test_get
    assert_equal PaiType::M1, PaiType.get("m1")
  end

end
