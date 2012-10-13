class Admin::ReportsController < ApplicationController
  # GET /admin/reports
  # GET /admin/reports.json
  def index
    @admin_reports = Report.all

    respond_to do |format|
      format.html { render :index, :locals => { :admin_reports => @admin_reports } } # index.html.erb
      format.json { render json: @admin_reports }
    end
  end

  # GET /admin/reports/1
  # GET /admin/reports/1.json
  def show
    @admin_report = Report.find(params[:id])

    respond_to do |format|
      format.html { render :show, :locals => { :admin_report => @admin_report } } # show.html.erb
      format.json { render json: @admin_report }
    end
  end

  # POST /admin/reports
  # POST /admin/reports.json
  def create
    @admin_report = Report.new(params[:admin_report])

    respond_to do |format|
      if @admin_report.save
        format.html { redirect_to @admin_report, notice: 'Report was successfully created.' }
        format.json { render json: @admin_report, status: :created, location: @admin_report }
      else
        format.html { render "new", :locals => { :admin_report => @admin_report } }
        format.json { render json: @admin_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/reports/1
  # PUT /admin/reports/1.json
  def update
    @admin_report = Report.find(params[:id])

    respond_to do |format|
      if @admin_report.update_attributes(params[:admin_report])
        format.html { redirect_to @admin_report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render "edit", locals => { :admin_report => @admin_report } }
        format.json { render json: @admin_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/reports/1
  # DELETE /admin/reports/1.json
  def destroy
    @admin_report = Report.find(params[:id])
    @admin_report.destroy

    respond_to do |format|
      format.html { redirect_to admin_reports_url }
      format.json { head :no_content }
    end
  end
end
