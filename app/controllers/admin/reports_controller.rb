class Admin::ReportsController < ApplicationController
  # GET /admin/reports
  # GET /admin/reports.json
  def index
    @reports = Report.all

    respond_to do |format|
      format.html { render :index, :locals => { :reports => @reports } } # index.html.erb
      format.json { render json: @reports }
    end
  end

  # GET /admin/reports/1
  # GET /admin/reports/1.json
  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html { render :show, :locals => { :report => @report } } # show.html.erb
      format.json { render json: @report }
    end
  end

  # POST /admin/reports
  # POST /admin/reports.json
  def create
    @report = Report.new(params[:report])

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render "new", :locals => { :report => @report } }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/reports/1
  # PUT /admin/reports/1.json
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render "edit", locals => { :report => @report } }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/reports/1
  # DELETE /admin/reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to admin_reports_url }
      format.json { head :no_content }
    end
  end
end
