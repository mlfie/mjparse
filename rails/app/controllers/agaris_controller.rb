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
      format.xml  { render :xml => @agari }
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
        format.html { redirect_to(@agari, :notice => 'Agari was successfully created.') }
        format.xml  { render :xml => @agari, :status => :created, :location => @agari }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agari.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /agaris/1
  # PUT /agaris/1.xml
  def update
    @agari = Agari.find(params[:id])

    respond_to do |format|
      if @agari.update_attributes(params[:agari])
        format.html { redirect_to(@agari, :notice => 'Agari was successfully updated.') }
        format.xml  { head :ok }
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
end
