class RawFilesController < ApplicationController
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  before_filter :get_user, :only => [:index, :new, :edit]
  load_and_authorize_resource :only => [:index, :show, :new, :destroy, :edit, :update]

  # GET /raw_files
  # GET /raw_files.json
  def index
    @raw_files = RawFile.find_all_by_user_id current_user.id, :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @raw_files }
    end
  end

  def search
    if !params[:filter].empty? then
      @raw_files = RawFile.where("path LIKE ? AND user_id = ?", "%#{params[:filter]}%", current_user.id).order('created_at DESC')

      respond_to do |format|
        format.html { render :action => "index" }
      end
    else
      redirect_to raw_files_path
    end
  end

  # GET /raw_files/1
  # GET /raw_files/1.json
  def show
    @raw_file = RawFile.find(params[:id],:conditions => ['user_id = ?',current_user.id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @raw_file }
    end
  end

  # GET /raw_files/1
  def download
    @raw_file = RawFile.find(params[:id],:conditions => ['user_id = ?', current_user.id])
    send_data @raw_file.file, :filename => @raw_file.filename, :disposition => "inline", :type => @raw_file.content_type  
  end

  # GET /raw_files/new
  # GET /raw_files/new.json
  def new
    @raw_file = RawFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @raw_file }
    end
  end

  # GET /raw_files/1/edit
  def edit
    @raw_file = RawFile.find(params[:id],:conditions => ['user_id = ?', current_user.id])
  end

  # POST /raw_files
  # POST /raw_files.json
  def create
    RawFile.transaction do
      @raw_file = RawFile.new(params[:raw_file])
      
      @raw_file.uploaded_file = params[:raw_file][:file]
      
      @raw_file.status = 'SENT'

      respond_to do |format|
        if @raw_file.save
          format.html { redirect_to @raw_file, :notice => 'File was successfully created.' }
          format.json { render :json =>  @raw_file, :status =>  :created, :location =>  @raw_file }
        else
          format.html { render :action =>  "new" }
          format.json { render :json =>  @raw_file.errors, :status =>  :unprocessable_entity }
        end
      end
    end
  end

  # PUT /raw_files/1
  # PUT /raw_files/1.json
  def update
    RawFile.transaction do
      @raw_file = RawFile.find(params[:id],:conditions => ['user_id = ?',current_user.id])
      
      @raw_file.uploaded_file = params[:raw_file][:file]

      respond_to do |format|
        if @raw_file.save
          format.html { redirect_to @raw_file, :notice => 'Raw file was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action =>  "edit" }
          format.json { render :json =>  @raw_file.errors, :status =>  :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /raw_files/1
  # DELETE /raw_files/1.json
  def destroy
    RawFile.transaction do
      @raw_file = RawFile.find(params[:id],:conditions => ['user_id = ?',current_user.id])
      @raw_file.destroy

      respond_to do |format|
        format.html { redirect_to raw_files_url }
        format.json { head :no_content }
      end
    end
  end

  private
  include Utils
end
