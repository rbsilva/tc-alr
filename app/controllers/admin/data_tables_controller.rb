class Admin::DataTablesController < BaseController
  # GET /admin/data_tables
  # GET /admin/data_tables.json
  def index
    @data_tables = DataTable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @data_tables }
    end
  end

  # GET /admin/data_tables/1
  # GET /admin/data_tables/1.json
  def show
    @data_table = DataTable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @data_table }
    end
  end

  # GET /admin/data_tables/new
  # GET /admin/data_tables/new.json
  def new
    @data_table = DataTable.new
    @data_table.fields_build

    respond_to do |format|
      format.html { render :new, :locals => { :data_table => @data_table } }
      format.json { render json: @data_table }
    end
  end

  # GET /admin/data_tables/1/edit
  def edit
    @data_table = DataTable.find(params[:id])
    @data_table.fields_build

    respond_to do |format|
      format.html { render :edit, :locals => { :data_table => @data_table } }
      format.json { render json: @data_table }
    end
  end

  # POST /admin/data_tables
  # POST /admin/data_tables.json
  def create
    @data_table = DataTable.new(params[:data_table])

    respond_to do |format|
      if @data_table.save
        format.html { redirect_to admin_data_table_path(@data_table), notice: 'Data table was successfully created.' }
        format.json { render json: @data_table, status: :created, location: @data_table }
      else
        @data_table.fields_build
        format.html { render :new, :locals => { :data_table => @data_table } }
        format.json { render json: @data_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/data_tables/1
  # PUT /admin/data_tables/1.json
  def update
    @data_table = DataTable.find(params[:id])

    respond_to do |format|
      if @data_table.update_attributes(params[:data_table])
        format.html { redirect_to admin_data_table_path(@data_table), notice: 'Data table was successfully updated.' }
        format.json { head :no_content }
      else
        @data_table.fields_build
        format.html { render :edit, :locals => { :data_table => @data_table } }
        format.json { render json: @data_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/data_tables/1
  # DELETE /admin/data_tables/1.json
  def destroy
    @data_table = DataTable.find(params[:id])
    @data_table.destroy

    respond_to do |format|
      format.html { redirect_to admin_data_tables_url }
      format.json { head :no_content }
    end
  end
end
