class Admin::DataTablesController < ApplicationController
  # GET /admin/data_tables
  # GET /admin/data_tables.json
  def index
    @admin_data_tables = DataTable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_data_tables }
    end
  end

  # GET /admin/data_tables/1
  # GET /admin/data_tables/1.json
  def show
    @admin_data_table = DataTable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_data_table }
    end
  end

  # GET /admin/data_tables/new
  # GET /admin/data_tables/new.json
  def new
    @admin_data_table = DataTable.new

    respond_to do |format|
      format.html { render :new, :locals => { :admin_data_table => @admin_data_table } }
      format.json { render json: @admin_data_table }
    end
  end

  # GET /admin/data_tables/1/edit
  def edit
    @admin_data_table = DataTable.find(params[:id])
  end

  # POST /admin/data_tables
  # POST /admin/data_tables.json
  def create
    @admin_data_table = DataTable.new(params[:admin_data_table])

    respond_to do |format|
      if @admin_data_table.save
        format.html { redirect_to @admin_data_table, notice: 'Data table was successfully created.' }
        format.json { render json: @admin_data_table, status: :created, location: @admin_data_table }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_data_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/data_tables/1
  # PUT /admin/data_tables/1.json
  def update
    @admin_data_table = DataTable.find(params[:id])

    respond_to do |format|
      if @admin_data_table.update_attributes(params[:admin_data_table])
        format.html { redirect_to @admin_data_table, notice: 'Data table was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_data_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/data_tables/1
  # DELETE /admin/data_tables/1.json
  def destroy
    @admin_data_table = DataTable.find(params[:id])
    @admin_data_table.destroy

    respond_to do |format|
      format.html { redirect_to admin_data_tables_url }
      format.json { head :no_content }
    end
  end
end
