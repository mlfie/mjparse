class PhotosController < ApplicationController

  # for debug
  require 'pp'
  def ppp(*objs)
    logger = Logger.new File.join(RAILS_ROOT, 'log', 'out.log')
    objs.each { |obj| logger.debug PP.pp(obj, '') }
    nil
  end

  # GET /photos
  # GET /photos.xml
  # GET /photos.json
  def index
    @photos = Photo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
      format.json  { render :json => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    require 'RMagick'
    pub_dir = "public/"
    url_base = "http://" + request.raw_host_with_port + "/"
    photo_dir = "img/"

    # get next id
    if Photo.last == nil then
      id = 1
    else
      id = Photo.last.id + 1
    end
    orig_img   = "#{id}.orig.jpg"
    normal_img = "#{id}.jpg"
    thum_img = "#{id}.thum.jpg"

    # store original image
    image = Base64.decode64(params[:photo][:base64])
    rmagick = Magick::ImageList.new
    rmagick.from_blob(image)
    rmagick.write(pub_dir + photo_dir + orig_img)
    
    # store normalized image
    image = Base64.decode64(resize_base64_img(params[:photo][:base64],600,448))
    rmagick = Magick::ImageList.new
    rmagick.from_blob(image)
    rmagick.write(pub_dir + photo_dir + normal_img)

    # store thumbnail image
    image = Base64.decode64(resize_base64_img(params[:photo][:base64],150,150))
    rmagick = Magick::ImageList.new
    rmagick.from_blob(image)
    rmagick.write(pub_dir + photo_dir + thum_img)


    params[:photo][:path]=pub_dir + photo_dir + normal_img
    params[:photo][:url]=url_base + photo_dir + normal_img
    params[:photo][:orig_url]=url_base + photo_dir + orig_img
    params[:photo][:thum_url]=url_base + photo_dir + thum_img
    params[:photo].delete(:base64)

    @photo = Photo.new(params[:photo])

    if @photo.save
        url = params[:photo][:url]
        render :text => url, :status => :created, :location => url 
    else
        render :text => "error", :status => :internal_server_error , :location => url 
    end

    #respond_to do |format|
    #  if @photo.save
    #    format.html { redirect_to(@photo, :notice => 'Photo was successfully created.') }
    #    format.xml  { render :xml => @photo, :status => :created, :location => @photo }
    #  else
    #    format.html { render :action => "new" }
    #    format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
    #  end
    #end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to(@photo, :notice => 'Photo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end

  # base64形式画像縮小
  #
  # param @str: base64のJPEG
  # param @width: 縦幅
  # param @height: 横幅
  # return: 縦幅*横幅の長方形に入る大きさに縮小したJPEGのbase64
  def resize_base64_img(str,width,height)
    blob = Base64.decode64(str)
    image = Magick::ImageList.new
    image.from_blob(blob)
    image.resize!(width,height)
    return Base64.encode64(image.to_blob)    
  end



end
