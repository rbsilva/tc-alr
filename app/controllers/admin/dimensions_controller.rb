class Admin::DimensionsController < ApplicationController
  # GET /admin/dimensions
  # GET /admin/dimensions.json
  def index
    @dimensions = Dimension.all
    begin
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @dimensions }
      end
    rescue
      logger.fatal $!
    end
  end

  # GET /admin/dimensions/1
  # GET /admin/dimensions/1.json
  def show
    @dimension = Dimension.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dimension }
    end
  rescue
    redirect_to admin_dimensions_url, flash: {:error => $!.to_s}
  end

  # GET /admin/dimensions/new
  # GET /admin/dimensions/new.json
  def new
    @dimension = Dimension.new

    begin
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @dimension }
      end
    rescue
      logger.fatal $!
    end
  end

  # GET /admin/dimensions/1/edit
  def edit
    @dimension = Dimension.find(params[:id])

    begin
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @dimension }
      end
    rescue
      logger.fatal $!
    end
  rescue
    redirect_to admin_dimensions_url, flash: {:error => $!.to_s}
  end

  # POST /admin/dimensions
  # POST /admin/dimensions.json
  def create
    @dimension = Dimension.new(params[:dimension])

    respond_to do |format|
      if @dimension.save
        format.html { redirect_to admin_dimension_url(:id => @dimension.name), notice: I18n.t(:dimension_created_successfully) }
        format.json { render json: @dimension, status: :created, location: @dimension }
      else
        format.html { render action: "new" }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  rescue
    redirect_to admin_dimensions_url, flash: {:error => $!.to_s}
  end

  # PUT /admin/dimensions/1
  # PUT /admin/dimensions/1.json
  def update
    @dimension = Dimension.find(params[:id])

    respond_to do |format|
      if @dimension.update_attributes(params[:admin_dimension])
        format.html { redirect_to @dimension, notice: I18n.t(:dimension_updated_successfully) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  rescue
    redirect_to admin_dimensions_url, flash: {:error => $!.to_s}
  end

  # DELETE /admin/dimensions/1
  # DELETE /admin/dimensions/1.json
  def destroy
    @dimension = Dimension.find(params[:id])
    @dimension.destroy

    respond_to do |format|
      format.html { redirect_to admin_dimensions_url }
      format.json { head :no_content }
    end
  rescue
    redirect_to admin_dimensions_url, flash: {:error => $!.to_s}
  end
end
