class Admin::RolesController < BaseController

  # GET /admin/roles
  # GET /admin/roles.json
  def index
    @roles = Role.accessible_by(current_ability, :index).limit(20)
    respond_to do |format|
      format.html { render :index, :locals => { :roles => @roles } } # index.html.erb
      format.json { render :json => @roles }
    end
  end

  # GET /admin/roles/1
  # GET /admin/roles/1.json
  def show
    @role = Role.find(params[:id])

    respond_to do |format|
      format.html { render :show, :locals => { :role => @role } } # show.html.erb
      format.json { render :json =>  @role }
    end
  end

  # GET /admin/roles/new
  # GET /admin/roles/new.json
  def new
    @role = Role.new

    respond_to do |format|
      format.html { render :new, :locals => { :role => @role } } # new.html.erb
      format.json { render :json =>  @role }
    end
  end

  # GET /admin/roles/1/edit
  # GET /admin/roles/1/edit.json
  def edit
    @role = Role.find(params[:id])
  end

  # POST /admin/roles
  # POST /admin/roles.json
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        format.html { redirect_to admin_role_path(@role), :notice =>  I18n.t(:role_created_successfully) }
        format.json { render :json =>  @role, :status =>  :created, :location =>  @role }
      else
        format.html { render "new", :locals => { :role => @role } }
        format.json { render :json =>  @role.errors, :status =>  :unprocessable_entity }
      end
    end
  end

  # PUT /admin/roles/1
  # PUT /admin/roles/1.json
  def update
    if params[:role][:password].blank?
      [:password, :password_confirmation, :current_password].collect { |p| params[:role].delete(p) }
    else
      @role.errors[:base] << "The password you entered is incorrect" unless @role.valid_password?(params[:role][:current_password])
    end

    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.errors[:base].empty? and @role.update_attributes(params[:role])
        format.html { redirect_to admin_role_path(@role), :notice =>  I18n.t(:role_updated_successfully) }
        format.json { head :no_content }
      else
        format.html { render  "edit", :locals => { :role => @role } }
        format.json { render :json =>  @role.errors, :status =>  :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/roles/1
  # DELETE /admin/roles/1.json
  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to admin_roles_url }
      format.json { head :no_content }
    end
  end

end
