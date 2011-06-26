#encoding:utf-8
require 'mlfielib/cv/template_matching_analyzer'
require 'mlfielib/web/image_fetcher'
require 'mjt/analysis/teyaku_decider'

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

    respond_to do |format|
      if @agari.save
        @agari.reload

        # set dummy date
        @agari.total_fu_num = 20
        @agari.total_han_num = 4
        @agari.mangan_scale = 0
        @agari.total_point = 5200
        @agari.parent_point = 2600
        @agari.child_point = 1300
        @agari.tehai_list = "m4m5m6m7m7p2p3p4s5s6s7s7s8s9"
        @agari.yaku_list << Yaku.find_by_name_kana('タンヤオ')
        @agari.yaku_list << Yaku.find_by_name_kana('ピンフ')
        @agari.yaku_list << Yaku.find_by_name_kana('サンショク')

        if  @agari.save

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
    tma = Mlfielib::CV::TemplateMatchingAnalyzer.new
    agari.tehai_list = tma.analyze(tehai_img_path(agari.id))
    agari.save
    if Mjt::Analysis::TeyakuDecider.get_agari_teyaku(agari)
      twitter = Mjt::Tsumotter.new
      twitter.update(agari)
      return true
    else
      return false
    end

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
