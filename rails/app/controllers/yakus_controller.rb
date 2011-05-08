class YakusController < ApplicationController
  # GET /yakus
  # GET /yakus.xml
  def index
    @yakus = Yaku.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @yakus }
    end
  end

  # GET /yakus/1
  # GET /yakus/1.xml
  def show
    @yaku = Yaku.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @yaku }
    end
  end

  # GET /yakus/new
  # GET /yakus/new.xml
  def new
    @yaku = Yaku.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @yaku }
    end
  end

  # GET /yakus/1/edit
  def edit
    @yaku = Yaku.find(params[:id])
  end

  # POST /yakus
  # POST /yakus.xml
  def create
    @yaku = Yaku.new(params[:yaku])

    respond_to do |format|
      if @yaku.save
        format.html { redirect_to(@yaku, :notice => 'Yaku was successfully created.') }
        format.xml  { render :xml => @yaku, :status => :created, :location => @yaku }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @yaku.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /yakus/1
  # PUT /yakus/1.xml
  def update
    @yaku = Yaku.find(params[:id])

    respond_to do |format|
      if @yaku.update_attributes(params[:yaku])
        format.html { redirect_to(@yaku, :notice => 'Yaku was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @yaku.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /yakus/1
  # DELETE /yakus/1.xml
  def destroy
    @yaku = Yaku.find(params[:id])
    @yaku.destroy

    respond_to do |format|
      format.html { redirect_to(yakus_url) }
      format.xml  { head :ok }
    end
  end
end
