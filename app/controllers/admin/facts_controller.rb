class Admin::FactsController < BaseController

  # GET /admin/facts
  # GET /admin/facts.json
  def index
    @facts = Fact.all

    respond_to do |format|
      format.html { render :index, :locals => { :facts => @facts } } # index.html.erb
      format.json { render json: @facts }
    end
  end

  # GET /admin/facts/1
  # GET /admin/facts/1.json
  def show
    @fact = Fact.find(params[:id])

    respond_to do |format|
      format.html { render :show, :locals => { :fact => @fact } } # show.html.erb
      format.json { render json: @fact }
    end
  end

  # GET /admin/facts/new
  # GET /admin/facts/new.json
  def new
    @fact = Fact.new

    begin
      respond_to do |format|
        format.html { render :new, :locals => { :fact => @fact } } # new.html.erb
        format.json { render json: @fact }
      end
    rescue
      logger.fatal $!.annoted_source_code
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
        format.html { render "new", :locals => { :fact => @fact } }
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

end
