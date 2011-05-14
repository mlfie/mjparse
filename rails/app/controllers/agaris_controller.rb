#encoding:utf-8
require 'cv/template_matching_analyzer'

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

    # 手配画像を小さくしてモデルにいれなおす
    #@agari[:tehai_img] = base64_smaller(URI.decode(@agari[:tehai_img]))
    @agari[:tehai_img] = base64_smaller(@agari[:tehai_img])

    
    twitter = Mjt::Tsumotter.new
    #twitter.update(@agari)

    respond_to do |format|
      if @agari.save
        @agari.reload
        make_tehai_img(@agari[:id])
        self.analysis(@agari)
        @agari.save

        format.html { redirect_to(@agari, :notice => 'Agari was successfully created.') }
        format.xml  { render :xml => @agari, :status => :created, :location => @agari }
        format.json { render :text => @agari.to_json(:include => :yaku_list )}
        # make tehai image file
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agari.errors, :status => :unprocessable_entity }
      end
    end
  end

  def analysis(agari)
    tma = CV::TemplateMatchingAnalyzer.new
    agari.tehai_list = tma.analyze(tehai_img_path(agari.id))
    Mjt::Analysis::TeyakuDecider.get_agari_teyaku(agari)

    #resolver = Mjt::Analysys::MentsuResolver.new
    #resolver.get_mentsu(agari)
    #agari.total_fu_num = 30
    #agari.total_han_num = 4
    #agari.mangan_scale = 1
    #agari.total_point = 8000
    #agari.yaku_list << Yaku.find_by_name_kana('タンヤオ')
    #agari.yaku_list << Yaku.find_by_name_kana('ピンフ')
    #agari.yaku_list << Yaku.find_by_name_kana('サンショク')
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
