class LabsController < ApplicationController
  load_and_authorize_resource
  # GET /labs
  # GET /labs.json
  def index
    # @labs = Lab.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @labs.where("name like ?", "%#{params[:q]}%") }
    end
  end

  # GET /labs/1
  # GET /labs/1.json
  def show
    # @lab = Lab.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lab }
    end
  end

  # GET /labs/new
  # GET /labs/new.json
  def new
    # @lab = Lab.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lab }
    end
  end

  # GET /labs/1/edit
  def edit
    # @lab = Lab.find(params[:id])
  end

  # POST /labs
  # POST /labs.json
  def create
    # @lab = Lab.new(params[:lab])

    # Fill in missing fields for a requested lab
    if current_user.status == "undergrad"
      @lab.is_authorized = false
      @lab.name = @lab.principles.first.last_name + " Lab"
      @lab.url = ""
      @lab.description = "This lab is unauthorized."
      #send an email to PI
      pi = User.joins(:labs).where(:id => @lab.principles.first.id)
    else
      @lab.is_authorized = true
    end
    
    respond_to do |format|
      if pi.size == 0
        if @lab.save
          if current_user.status == "undergrad"
            format.html { redirect_to labs_url, notice: 'Lab was successfully created. Your PI will be notified shortly.' }
          else
            format.html { redirect_to @lab, notice: 'Lab was successfully created.' }
          end
          format.json { render json: @lab, status: :created, location: @lab }
        else
          format.html { render action: "new" }
          format.json { render json: @lab.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to labs_url, notice: 'This PI already has a lab' }
        format.json { render json: @lab}
      end
    end
  end

  # PUT /labs/1
  # PUT /labs/1.json
  def update
    # @lab = Lab.find(params[:id])

    respond_to do |format|
      if @lab.update_attributes(params[:lab])
        format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    # @lab = Lab.find(params[:id])
    @lab.destroy

    respond_to do |format|
      format.html { redirect_to labs_url }
      format.json { head :no_content }
    end
  end

  def authorize
    @lab = Lab.find(params[:id])
    @lab.is_authorized = true
    @lab.save
    respond_to do |format|
      format.html {redirect_to @lab}
      format.json { render json: @lab.errors, status: :unprocessable_entity }
    end
  end
end
