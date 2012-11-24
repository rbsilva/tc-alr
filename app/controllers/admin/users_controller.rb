class Admin::UsersController < BaseController

  # GET /admin/users
  # GET /admin/users.json
  def index
    @users = User.accessible_by(current_ability, :index)#future pagination .limit(20)
    respond_to do |format|
      format.html { render :index, :locals => { :users => @users } }# index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html { render :show, :locals => { :user => @user } }# show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /admin/users/new
  # GET /admin/users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html { render :new, :locals => { :user => @user, :accessible_roles => @accessible_roles } }# new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /admin/users/1/edit
  # GET /admin/users/1/edit.json
  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.html { render :edit, :locals => { :user => @user, :accessible_roles => @accessible_roles } }# new.html.erb
      format.json { render json: @user }
    end
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_path(@user), notice: I18n.t(:user_created_successfully) }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render "new", :locals => { :user => @user } }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/users/1
  # PUT /admin/users/1.json
  def update
    if params[:user][:password].blank?
      [:password, :password_confirmation, :current_password].collect { |p| params[:user].delete(p) }
    else
      @user.errors[:base] << "The password you entered is incorrect" unless @user.valid_password?(params[:user][:current_password])
    end

    @user = User.find(params[:id])

    respond_to do |format|
      if @user.errors[:base].empty? and @user.update_attributes(params[:user])
        format.html { redirect_to admin_user_path(@user), notice: I18n.t(:user_updated_successfully) }
        format.json { head :no_content }
      else
        format.html { render "edit", :locals => { :user => @user } }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

end
