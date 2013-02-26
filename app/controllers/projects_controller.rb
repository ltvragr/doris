class ProjectsController < ApplicationController
  load_and_authorize_resource
  # GET /projects
  # GET /projects.json
  def index
    # @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
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
    # @project = Project.new(params[:project])

    # request project authorization from PI
    if current_user.status == "undergrad"
      @project.is_confirmed = false
      UserMailer.project_confirm_email(@project.labs.first.principles.first).deliver
    else
      @project.is_confirmed = true
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
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
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def confirm
    @project = Project.find(params[:id])
    @project.is_confirmed = true
    @project.save
    respond_to do |format|
      format.html {redirect_to :back}
      format.json { render json: @project.errors, status: :unprocessable_entity }
    end
  end
end
