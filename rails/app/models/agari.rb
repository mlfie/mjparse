require 'mlfielib/cv/template_matching_analyzer'
require 'mlfielib/analysis/yaku_specimen'
require 'mlfielib/analysis/kyoku'
require 'mlfielib/analysis/teyaku_decider'

class Agari < ActiveRecord::Base
  include Mlfielib::Analysis

  attr_protected :total_fu_num, :total_han_num, :mangan_scale, :total_point, :parent_point, :child_point, :ron_point
  attr_accessor :local_img_path

  has_and_belongs_to_many :yaku_list, :class_name => 'Yaku'
  #has_many :tehai_list, :class_name => 'AgariPai', :order => "index"

  STATUS_SUCCESS = 200
  STATUS_BAD_REQUEST = 400
  STATUS_INTERNAL_ERROR = 500

  def img_analysis
    tma = Mlfielib::CV::TemplateMatchingAnalyzer.new
    self.tehai_list = tma.analyze(self.local_img_path)
  end

  def teyaku_analysis
    teyaku_decider = TeyakuDecider.new
    teyaku_decider.get_agari_teyaku(
      self.tehai_list,
      self.kyoku,
      self.yaku_specimen
    )

    logger.debug("TeyakuDecider result_code is " + teyaku_decider.result_code.to_s)

    case teyaku_decider.result_code
      when TeyakuDecider::RESULT_SUCCESS
        self.status_code = STATUS_SUCCESS
        set_teyaku_result(teyaku_decider)
        logger.debug("decider success")
      else
        self.status_code = STATUS_INTERNAL_ERROR
        logger.debug("decider failed")
    end
    return true
  end

  def set_teyaku_result(teyaku_decider)
    if teyaku_decider.teyaku != nil then
      self.total_fu_num    = teyaku_decider.teyaku.fu_num
      self.total_han_num   = teyaku_decider.teyaku.han_num
      self.yaku_list = Array.new
      teyaku_decider.teyaku.yaku_list.each do |specimen|
        self.yaku_list << Yaku.find_by_name(specimen.name)
      end
      self.mangan_scale    = teyaku_decider.teyaku.mangan_scale
      self.total_point     = teyaku_decider.teyaku.total_point
      self.parent_point    = teyaku_decider.teyaku.parent_point
      self.child_point     = teyaku_decider.teyaku.child_point
      self.ron_point       = teyaku_decider.teyaku.ron_point
      logger.debug("teyaku is fu:"+self.total_fu_num.to_s+" han:"+self.total_han_num.to_s+" total_point:"+self.total_point.to_s)
    else
      logger.error("teyaku was not decided.")
    end  
  end

  def yaku_specimen
    yaku_specimen = Hash.new
    Yaku.all.each do |yaku|
      yaku_specimen[yaku.name] =
        YakuSpecimen.new(yaku.name, yaku.name_kanji, yaku.han_num, yaku.naki_han_num)
    end
    logger.debug("The number of YakuSpecimen is "+yaku_specimen.size.to_s)
    return yaku_specimen
  end

  def kyoku
    kyoku = Kyoku.new
    kyoku.is_tsumo      = self.is_tsumo
    kyoku.is_haitei     = self.is_haitei
    kyoku.dora_num      = self.dora_num
    kyoku.bakaze        = self.bakaze
    kyoku.jikaze        = self.jikaze
    kyoku.honba_num     = self.honba_num
    kyoku.is_rinshan    = self.is_rinshan
    kyoku.is_chankan    = self.is_chankan
    kyoku.reach_num     = self.reach_num
    kyoku.is_ippatsu    = self.is_ippatsu
    kyoku.is_tenho      = self.is_tenho
    kyoku.is_chiho      = self.is_chiho
    kyoku.is_parent     = self.is_parent
    return kyoku
  end
end
