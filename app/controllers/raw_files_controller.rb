class RawFilesController < ApplicationController
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]

  # GET /raw_files
  # GET /raw_files.json
  def index
    @raw_files = RawFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @raw_files }
    end
  end

  # GET /raw_files/1
  # GET /raw_files/1.json
  def show
    @raw_file = RawFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @raw_file }
    end
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
    @raw_file = RawFile.find(params[:id])
  end

  # POST /raw_files
  # POST /raw_files.json
  def create
    require 'fileutils'
    @raw_file = RawFile.new(params[:raw_file])

    begin
      if @raw_file.save then
        upload_dir = APP_CONFIG['upload_dir']
        if !Dir.exists? upload_dir then
          FileUtils.makedirs upload_dir
        end
        filename = @raw_file.path
        file = File.join(upload_dir, filename)
        tempfile = File.join('tmp', filename)
        FileUtils.mv tempfile, file
        continue = true
      else
        continue = false
      end
    rescue Exception => e
      logger.info e
      @raw_file.errors.set :path, e.message
      continue = false
    end

    respond_to do |format|
      if continue
        format.html { redirect_to @raw_file, notice: 'Raw file was successfully created.' }
        format.json { render json: @raw_file, status: :created, location: @raw_file }
      else
        format.html { render action: "new" }
        format.json { render json: @raw_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /raw_files/attach
  # POST /raw_files/attach.json
  def attach
    require 'fileutils'
    begin
      tempfile = params[:upload][:attach_a_file].tempfile
      filename = Time.now.to_i.to_s + '_' + params[:upload][:attach_a_file].original_filename
      file = File.join('tmp', filename)
      FileUtils.cp tempfile.path, file
      @raw_file = RawFile.new(:path => filename)
      continue = true
    rescue Exception => e
      logger.info e
      @raw_file.errors.set :attach_a_file, [', you must select a file']
      continue = false
    end
    respond_to do |format|
      if continue
        format.html { render action: "new" , notice: 'The file was successfully uploaded.' }
        format.json { render json: @raw_file, status: :created, location: @raw_file }
      else
        format.html { render action: "new" }
        format.json { render json: @raw_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /raw_files/1
  # PUT /raw_files/1.json
  def update
    @raw_file = RawFile.find(params[:id])

    respond_to do |format|
      if @raw_file.update_attributes(params[:raw_file])
        format.html { redirect_to @raw_file, notice: 'Raw file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @raw_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raw_files/1
  # DELETE /raw_files/1.json
  def destroy
    @raw_file = RawFile.find(params[:id])
    @raw_file.destroy

    respond_to do |format|
      format.html { redirect_to raw_files_url }
      format.json { head :no_content }
    end
  end
end
