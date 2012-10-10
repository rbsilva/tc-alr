class RawFilesController < BaseController

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
      @raw_files = RawFile.where("UPPER(filename) LIKE UPPER(?) OR UPPER(template) LIKE UPPER(?) AND user_id = ?", "%#{params[:filter]}%", "%#{params[:filter]}%", current_user.id).order('created_at DESC')

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
    send_data ActiveRecord::Base.connection.unescape_bytea(@raw_file.file), :filename => @raw_file.filename, :disposition => "inline", :type => @raw_file.content_type
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
    if @raw_file.status == 'PROCESSED' then
      raise t(:operation_not_permitted_raw_file)
    end
  rescue
    redirect_to raw_files_url, flash: {:error => $!.to_s}
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
  rescue
    redirect_to raw_files_url, flash: {:error => $!.to_s}
  end

end
