#encoding:utf-8
require 'mlfielib/cv/template_matching_analyzer'
require 'mlfielib/web/image_fetcher'
require 'mlfielib/analysis/teyaku_decider'
require 'mlfielib/analysis/yaku_specimen'
require 'mlfielib/analysis/kyoku'
require 'RMagick'
require 'base64'

class AgarisController < ApplicationController
  # GET /agaris
  # GET /agaris.xml
  def index
    @agaris = Agari.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agaris }
    end
  end

  # GET /agaris/1
  # GET /agaris/1.xml
  def show
    @agari = Agari.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :text => @agari.to_json(:include => :yaku_list) }
    end
  end

  # GET /agaris/new
  # GET /agaris/new.xml
  def new
    @agari = Agari.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agari }
    end
  end

  # GET /agaris/1/edit
  def edit
    @agari = Agari.find(params[:id])
  end

  # POST /agaris
  # POST /agaris.xml
  def create
    @agari = Agari.new(params[:agari])

    #URIから画像を取得する
    if @agari[:tehai_img].blank? && @agari.img_url
      img_fetcher = Mlfielib::Web::ImageFetcher.new
      img_path = img_fetcher.save_image(@agari.img_url)
      @agari[:tehai_img] = to_base64(img_path)
    end
    @agari[:tehai_img] = base64_smaller(@agari[:tehai_img])

    #IDを取得するために、いったんセーブ
    respond_to do |format|
      if @agari.save
        @agari.reload

        #取得した画像をローカルに保存する
        make_tehai_img(@agari[:id])

        if self.analysis(@agari)
          @agari.save
          #Clientのレスポンスが悪いため、tehai_imgは消す(暫定対応)
          @agari[:tehai_img] = nil

          format.html { redirect_to(@agari, :notice => 'Agari was successfully created.') }
          format.xml  { render :xml => @agari, :status => :created, :location => @agari }
          format.json { render :text => @agari.to_json(:include => :yaku_list )}
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @agari.errors, :status => :unprocessable_entity }
        end
        # make tehai image file
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agari.errors, :status => :unprocessable_entity }
      end
    end
  end

  def analysis(agari)
    # イメージを解析し、手牌リストを作成
    tma = Mlfielib::CV::TemplateMatchingAnalyzer.new
    agari.tehai_list = tma.analyze(tehai_img_path(agari.id))

    # いったんセーブ
    # (手牌解析で失敗した場合でも画像解析結果を残したいため)
    agari.save

    # 役リストを設定
    yaku_specimen = Hash.new
    yaku_list = Yaku.all
    yaku_list.each do |yaku|
      yaku_specimen[yaku.name] = Mlfielib::Analysis::YakuSpecimen.new(yaku.name_kanji, yaku.han_num, yaku.naki_han_num)
    end
    
    # 局情報を設定
    kyoku = Mlfielib::Analysis::Kyoku.new
    kyoku.is_tsumo      = agari.is_tsumo
    kyoku.is_haitei     = agari.is_haitei
    kyoku.dora_num      = agari.dora_num
    kyoku.bakaze        = agari.bakaze
    kyoku.jikaze        = agari.jikaze
    kyoku.honba_num     = agari.honban_num
    kyoku.is_rinshan    = agari.is_rinshan
    kyoku.is_chankan    = agari.is_chankan
    kyoku.reach_num     = agari.reach_num
    kyoku.is_ippatsu    = agari.is_ippatsu
    kyoku.is_tenho      = agari.is_tenho
    kyoku.is_chiho      = agari.is_chiho
    kyoku.is_parent     = agari.is_parent
    
    # 手役判定、得点計算、
    # if Mjt::Analysis::TeyakuDecider.get_agari_teyaku(agari)
    teyaku_decider = Mlfielib::Analysis::TeyakuDecider.new
    teyaku_decider.get_agari_teyaku(agari.tehai_list, kyoku, yaku_specimen)
    
    if teyaku_decider.result_code == Mlfielib::Analysis::TeyakuDecider::RESULT_SUCCESS then
    logger.debug("decider success")
      agari.total_fu_num    = teyaku_decider.teyaku.fu_num
      agari.total_han_num   = teyaku_decider.teyaku.han_num
      agari.yaku_list       = teyaku_decider.teyaku.yaku_list
      agari.mangan_scale    = teyaku_decider.teyaku.mangan_scale
      agari.total_point     = teyaku_decider.teyaku.total_point
      agari.parent_point    = teyaku_decider.teyaku.parent_point
      agari.child_point     = teyaku_decider.teyaku.child_point
      
      # つぶやく
      #twitter = Mjt::Tsumotter.new
      #twitter.update(agari)
      return true
    else
    logger.debug("decider failed")
      return true
    end

  end

  # base64形式画像縮小
  #
  # param @str: base64のJPEG
  # return: 600*448に縮小したJPEGのbase64
  def base64_smaller(str)
    blob = Base64.decode64(str)
    image = Magick::ImageList.new
    image.from_blob(blob)
    image.resize!(600,448)
    return Base64.encode64(image.to_blob)    
  end	

  def to_base64(img_path)
    puts "befor new !"
    image = Magick::ImageList.new
    p image
    puts "befor read"
    puts "img_path=#{img_path}"
    image.read(img_path)
    puts "read!"
    image.resize!(600,448)
    puts "resize!"
    return Base64.encode64(image.to_blob)
  end

  # 引数のIDの手配画像をjpegにして配置
  def make_tehai_img(id)
    agari=Agari.find_by_id(id)
    image = Base64.decode64(agari[:tehai_img])
    rmagick = Magick::ImageList.new
    rmagick.from_blob(image)
    rmagick.write(tehai_img_path(id))
  end

  # PUT /agaris/1
  # PUT /agaris/1.xml
  def update
    @agari = Agari.find(params[:id])

    respond_to do |format|
      if @agari.update_attributes(params[:agari])
        @agari.reload
        format.html { redirect_to(@agari, :notice => 'Agari was successfully updated.') }
        format.xml  { head :ok }
        format.json { render :text => @agari.to_json(:include => :yaku_list) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agari.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agaris/1
  # DELETE /agaris/1.xml
  def destroy
    @agari = Agari.find(params[:id])
    @agari.destroy

    respond_to do |format|
      format.html { redirect_to(agaris_url) }
      format.xml  { head :ok }
    end
  end

  private

  #手配画像のパス
  def tehai_img_path(id)
    return "public/img/#{id}.jpg"
  end

end
