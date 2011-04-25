class PicturesController < ApplicationController
  before_filter :authenticate_user!, :load_pictures
  before_filter :check_size, :only => :create
  
  def check_size
    @pictures = current_user.pictures.all
    return if @pictures.size < 3
    respond_to do |format|
      format.json { render :json => { :max_size => 'You are allowed to upload a maximum of 3 pictures!'}, :content_type => 'text/html' }
    end
  end
  
  def load_pictures
    @pictures = current_user.pictures
    @picture = Picture.new
  end

  def edit
    @picture = current_user.pictures.find(params[:id])
    render :action => "index"
  end

  def create
    @picture = current_user.pictures.build(params[:picture])

    respond_to do |format|
      if @picture.save
        format.html { redirect_to(user_pictures_url(current_user), :notice => 'Picture was successfully created.') }
        format.xml  { render :xml => @picture, :status => :created, :location => @picture }
        format.json {  render :json => { :pic_path => @picture.file.url(:thumb).to_s,
                                       :name => @picture.file.filename,
                                       :description => @picture.description, 
                                       :title => @picture.title, 
                                       :user => current_user.id, 
                                       :id => @picture.id,
                                       :size => (2 - @pictures.size) }, :content_type => 'text/html' }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
        format.json { render :json => { :result => 'error'}, :content_type => 'text/html' }
      end
    end
  end

  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to(user_pictures_url(current_user), :notice => 'Picture was successfully updated.') }
        format.xml  { head :ok }
        format.json {  render :json => { :pic_path => @picture.file.url(:thumb).to_s, :name => @picture.file.filename }, :content_type => 'text/html' }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
        format.json { render :json => { :result => 'error'}, :content_type => 'text/html' }
      end
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to(user_pictures_url(current_user)) }
      format.xml  { head :ok }
    end
  end
  
  def upload
    @pictures.each { |picture| picture.update_attribute("status", "uploading")}
    DelayedJob.update_all("state = \'uploading\'", "user_id LIKE \'#{current_user.id}\'")
  end
  
  def list
    @pictures.collect! do |picture|
      {:id => picture.id, :file => picture.file.medium.url}
    end
    
    respond_to do |format|
      format.json {  render :json => {:pictures => @pictures } }
    end 
  end

end
