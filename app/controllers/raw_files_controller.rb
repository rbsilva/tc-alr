class RawFilesController < ApplicationController
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
    @raw_file = RawFile.new(params[:raw_file])

    respond_to do |format|
      if @raw_file.save
        format.html { redirect_to @raw_file, notice: 'Raw file was successfully created.' }
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
