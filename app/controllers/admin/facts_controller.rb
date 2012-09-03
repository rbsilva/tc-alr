class Admin::FactsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user, :only => [:index, :new, :edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:index, :show, :new, :destroy, :edit, :update]

  # GET /admin/facts
  # GET /admin/facts.json
  def index
    @facts = Fact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facts }
    end
  end

  # GET /admin/facts/1
  # GET /admin/facts/1.json
  def show
    @fact = Fact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fact }
    end
  end

  # GET /admin/facts/new
  # GET /admin/facts/new.json
  def new
    @fact = Fact.new

    begin
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @fact }
      end
    rescue
      logger.fatal $!.annoted_source_code
    end
  end

  # GET /admin/facts/1/edit
  def edit
    @fact = Fact.find(params[:id])
    begin
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @fact }
      end
    rescue
      logger.fatal $!.annoted_source_code
      logger.fatal $!
    end
  end

  # POST /admin/facts
  # POST /admin/facts.json
  def create
    @fact = Fact.new(params[:fact])

    respond_to do |format|
      if @fact.save
        format.html { redirect_to admin_fact_url(:id => @fact.name), notice: I18n.t(:fact_created_successfully) }
        format.json { render json: @fact, status: :created, location: @fact }
      else
        format.html { render action: "new" }
        format.json { render json: @fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/facts/1
  # PUT /admin/facts/1.json
  def update
    @fact = Fact.find(params[:id])

    respond_to do |format|
      if @fact.update_attributes(params[:admin_fact])
        format.html { redirect_to @fact, notice: I18n.t(:fact_updated_successfully) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/facts/1
  # DELETE /admin/facts/1.json
  def destroy
    @fact = Fact.find(params[:id])
    @fact.destroy

    respond_to do |format|
      format.html { redirect_to admin_facts_url }
      format.json { head :no_content }
    end
  end

  private
  include Utils
end
