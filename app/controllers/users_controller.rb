class UsersController < ApplicationController
  load_and_authorize_resource except: [:new, :create]
  skip_before_filter :first_time_user, only: [:new, :create, :edit, :update, :logout]
  skip_before_filter :current_user, only: [:edit]
  
  # GET /users
  # GET /users.json
  def index
    # @users = User.all

    respond_to do |format|
      if params[:source] == "project"
        return_users = JSON.parse(User.ldap_undergrad_search(params[:q]).to_json)
        #return_users = @users.where("first_name || last_name || login like ?", "%#{params[:q]}%").where(:status => 'undergrad')
      elsif params[:source] == "lab"
        return_users = JSON.parse(User.ldap_search(params[:q]).to_json)

        #return_users = @users.where("first_name || last_name || login like ?", "%#{params[:q]}%").where(:status => 'pi').joins(:labs).uniq
      end

      format.html # index.html.erb
      format.json{ render json: return_users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # @user = User.find(params[:id])
    @info_values = InfoValue.sorted_values_for_object(@user)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    if current_user && current_user.status != 'admin'
      flash[:error] = "Access Denied."
      redirect_to :home and return
    end

    @user = User.new
    @user.login = session[:cas_user].chomp("*") #default to current login
    user_params = User.general_ldap_search(@user.login)
    if user_params.size == 0
      @user.first_name = ""
      @user.last_name = ""
      @user.email = ""
    else
      @user.first_name = user_params[0][:first_name]
      @user.last_name = user_params[0][:last_name]
      @user.email = user_params[0][:email]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    # @user = User.find(params[:id])
  end

  def edit_info_fields
    # @user = User.find(params[:id])
    @fields = InfoField.where("associated_object = 'User'")
    #@fields = InfoField.where("associated_object = 'User' AND associated_role = ?", @user.role)
    @values = InfoValue.where("associated_object_id = ? AND associated_object_type = 'User'", @user.id)
  end

  def update_info_fields
    # @user = User.find(params[:id])
    params.each do |k, v|
      if k.starts_with? 'field'
        field_id = k[5].to_i
        @field = InfoField.find(field_id)
        value = InfoValue.where("associated_object_id = ? AND associated_object_type = 'User' AND info_field_id = ?", @user.id, field_id)
        if value.empty?
          value = @field.info_values.build({ associated_object_id: @user.id, associated_object_type: 'User', content: v})
          value.save
        else
          value.first().update_attributes({content: v})
        end
      end
    end
    redirect_to @user
  end

  # POST /users
  # POST /users.json
  def create    
    if cannot? :modify_login, User
      params[:user][:login] = session[:cas_user]
      params[:user][:status] = "undergrad"
    end

    @user = User.new(params[:user])
    
    if current_user != nil && current_user.login != params[:user][:login]
      @user.is_active = false
    else
      @user.is_active = true
    end

    @user.status = params[:user][:status]
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    #@user = User.find(params[:id])
    if cannot? :modify_login, User
      params[:user][:login] = current_user.login
    end
    @user.status == params[:user][:status]

    # activate users whenever they are editied (meaning they log in for the first time)
    @user.is_active = true
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def logout
    session[:cas_user], @current_user = nil
    flash[:error] = "You've been logged out"
    RubyCAS::Filter.logout(self)
  end

end
