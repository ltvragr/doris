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

    params.merge!({:status => "pi"})

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lab }
    end
  end

  def request_new
    respond_to do |format|
      format.html # new.html.erb
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

    respond_to do |format|
      if @lab.save
        format.html { redirect_to @lab, notice: 'Lab was successfully created.' }
        format.json { render json: @lab, status: :created, location: @lab }
      else
        format.html { render action: "new" }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
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
