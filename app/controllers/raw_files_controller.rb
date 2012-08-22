class RawFilesController < ApplicationController
  before_filter :get_user
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]

  # GET /raw_files
  # GET /raw_files.json
  def index
    if params[:filter].nil? then
      @raw_files = RawFile.find_all_by_user_id current_user.id, :order => 'created_at desc'
    else
      @raw_files = RawFile.where("path like ? and user_id = ?", "%#{params[:filter]}%", current_user.id).order('created_at desc')
    end

    respond_to do |format|
      format.html # index.html.erb
                  #format.json { render json: @raw_files }
    end
  end

  # GET /raw_files/1
  # GET /raw_files/1.json
  def show
    @raw_file = RawFile.find(params[:id],:conditions => ['user_id = ?',current_user.id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @raw_file }
    end
  end

  # GET /raw_files/1
  def download
    require 'fileutils'
    @raw_file = RawFile.find(params[:id],:conditions => ['user_id = ?',current_user.id])
    if @raw_file.status == 'SENT' then
      download_dir = APP_CONFIG['upload_dir']
    elsif @raw_file.status == 'PROCESSED' then
      download_dir = APP_CONFIG['processed_dir']
    end
    file = File.join(download_dir, @raw_file.path)
    send_file file, :x_sendfile=>true
  end

  # GET /raw_files/new
  # GET /raw_files/new.json
  def new
    @raw_file = RawFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @raw_file }
    end
  end

  # GET /raw_files/1/edit
  def edit
    @raw_file = RawFile.find(params[:id],:conditions => ['user_id = ?',current_user.id])
  end

  # POST /raw_files
  # POST /raw_files.json
  def create
    RawFile.transaction do
      @raw_file = RawFile.new(params[:raw_file])
      begin
        require 'fileutils'
        filename = @raw_file.path
        if params[:raw_file][:attach_a_file].nil? then
          @raw_file.status = 'SENT'
          if @raw_file.save then
            save_file filename
            continue = 'created'
          else
            continue = false
          end
        else
          tempfile = params[:raw_file][:attach_a_file].tempfile
          original_filename = params[:raw_file][:attach_a_file].original_filename
          @raw_file.path = attach_file filename, original_filename, tempfile
          continue = 'attached'
        end
      rescue Exception => e
        logger.info e
        @raw_file.errors.set :path, e.message
        continue = false
      end

      respond_to do |format|
        if continue == 'attached'
          format.html { render action: "new" }
          #format.json { render json: @raw_file, status: :created, location: @raw_file }
        elsif continue == 'created'
          format.html { redirect_to @raw_file, notice: 'File was successfully created.' }
          format.json { render json: @raw_file, status: :created, location: @raw_file }
        else
          format.html { render action: "new" }
          format.json { render json: @raw_file.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /raw_files/1
  # PUT /raw_files/1.json
  def update
    RawFile.transaction do
      @raw_file = RawFile.find(params[:id],:conditions => ['user_id = ?',current_user.id])
      begin
        require 'fileutils'
        filename = @raw_file.path
        if params[:raw_file][:attach_a_file].nil? then
          old_filename = @raw_file.path
          if @raw_file.update_attributes(params[:raw_file]) then
            save_file @raw_file.path
            if old_filename != @raw_file.path then
              upload_dir = APP_CONFIG['upload_dir']
              file = File.join(upload_dir, old_filename)
              rm_file file
            end
            continue = 'updated'
          else
            continue = false
          end
        else
          tempfile = params[:raw_file][:attach_a_file].tempfile
          original_filename = params[:raw_file][:attach_a_file].original_filename
          @raw_file.path = attach_file filename, original_filename, tempfile
          continue = 'attached'
        end
      rescue Exception => e
        logger.info e
        @raw_file.errors.set :path, e.message
        continue = false
      end

      respond_to do |format|
        if continue == 'attached'
          format.html { render action: "edit" }
          #format.json { render json: @raw_file, status: :created, location: @raw_file }
        elsif continue == 'updated'
          format.html { redirect_to @raw_file, notice: 'Raw file was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @raw_file.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /raw_files/1
  # DELETE /raw_files/1.json
  def destroy
    RawFile.transaction do
      @raw_file = RawFile.find(params[:id],:conditions => ['user_id = ?',current_user.id])
      filename = @raw_file.path
      if @raw_file.destroy then
        upload_dir = APP_CONFIG['upload_dir']
        file = File.join(upload_dir, filename)
        rm_file file
      end
      respond_to do |format|
        format.html { redirect_to raw_files_url }
        format.json { head :no_content }
      end
    end
  end

  private

  def save_file(filename)
    begin
      upload_dir = APP_CONFIG['upload_dir']
      if !Dir.exists? upload_dir then
        FileUtils.makedirs upload_dir
      end
      file = File.join(upload_dir, filename)
      tempfile = File.join('tmp', filename)
      FileUtils.mv tempfile, file
    rescue
      #do nothing
    end
  end

  def attach_file(filename, original_filename, tempfile)
    file = File.join('tmp', filename)
    rm_file file
    filename = Time.now.to_i.to_s + '_' + original_filename
    file = File.join('tmp', filename)
    FileUtils.cp tempfile.path, file
    filename
  end

  def rm_file(file)
    if !file.nil? && File.exists?(file) then
      begin
        FileUtils.rm file
      rescue
        #do nothing
      end
    end
  end

  include Utils
end
