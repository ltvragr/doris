class ProjectsController < ApplicationController
  load_and_authorize_resource except: :create

  # GET /projects
  # GET /projects.json
  def index
    # @projects = Project.all
    if params[:tag]
      project_list = Project.tagged_with(params[:tag])
    end
    respond_to do |format|
      
      if project_list == nil
        if params[:tag]
          flash.now[:error] = "There are no projects with the tag " + params[:tag]
        end
        format.html {render :index }
        format.json { render json: @projects }
      else
        @projects = project_list
        format.html # index.html.erb
        format.json { render json: @projects }
      end
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    # @project = Project.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    # @project = Project.new

    # params.merge!({:status => "undergrad"})
    @project = Project.new
    @project.labs << Lab.find(params[:lab_id]) if params[:lab_id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    # @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    tokens = params[:project][:user_tokens]
    unless tokens.empty?
      undergrad_params = User.ldap_undergrad_search(tokens.chomp('*'))[0]
      check_undergrad = User.where("login like ?", "%#{undergrad_params[:login]}%").where(status: 'undergrad').last
      if check_undergrad == nil
        check_undergrad = User.create! login: undergrad_params[:login], first_name: undergrad_params[:first_name], last_name: undergrad_params[:last_name], email: undergrad_params[:email], status: "undergrad", is_active: false
      end
      params[:project][:user_tokens] = check_undergrad.id.to_s
    end

    @project = Project.new(params[:project])

    # request project authorization from any PIs associated with a project
    if current_user.status == "undergrad"
      @project.is_confirmed = false
      @project.labs.each do |lab|
        lab.principles.each do |pi|
          UserMailer.project_confirm_email(pi).deliver
        end
      end
      # add user to project when it's created
      @project.users << current_user
    else
      # do for PI, admin
      @project.is_confirmed = true
    end

    respond_to do |format|
      if @project.save
        if(current_user.status == "undergrad")
          format.html { redirect_to @project, notice: 'An email was sent requesting approval for this project from your PI.' }
        else
          format.html { redirect_to @project, notice: 'Project was successfully created.' }
        end
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    # @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    # @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed" }
      format.json { head :no_content }
    end
  end

  def confirm
    @project = Project.find(params[:id])
    @project.is_confirmed = true
    @project.save
    respond_to do |format|
      format.html {redirect_to :back, notice: "This project has been confirmed."}
      format.json { render json: @project.errors, status: :unprocessable_entity }
    end
  end

  def add_self_to_project
    @project = Project.find(params[:id])
    @project.users << current_user
    @project.save
    respond_to do |format|
      format.html {redirect_to :back, notice: "You've been added to this project."}
      format.json { render json: @project.errors, status: :unprocessable_entity }
    end
  end

  def remove_self_from_project
    @project = Project.find(params[:id])
    @project.users.delete(current_user)
    @project.save
    respond_to do |format|
      format.html {redirect_to :back, notice: "You've been removed from this project."}
      format.json { render json: @project.errors, status: :unprocessable_entity }
    end
  end

end
