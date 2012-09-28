class InfoFieldsController < ApplicationController
  # GET /info_fields
  # GET /info_fields.json
  def index
    @info_fields = InfoField.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @info_fields }
    end
  end

  # GET /info_fields/1
  # GET /info_fields/1.json
  def show
    @info_field = InfoField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @info_field }
    end
  end

  # GET /info_fields/new
  # GET /info_fields/new.json
  def new
    @info_field = InfoField.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @info_field }
    end
  end

  # GET /info_fields/1/edit
  def edit
    @info_field = InfoField.find(params[:id])
  end

  # POST /info_fields
  # POST /info_fields.json
  def create
    @info_field = InfoField.new(params[:info_field])

    respond_to do |format|
      if @info_field.save
        format.html { redirect_to @info_field, notice: 'Info field was successfully created.' }
        format.json { render json: @info_field, status: :created, location: @info_field }
      else
        format.html { render action: "new" }
        format.json { render json: @info_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /info_fields/1
  # PUT /info_fields/1.json
  def update
    @info_field = InfoField.find(params[:id])

    respond_to do |format|
      if @info_field.update_attributes(params[:info_field])
        format.html { redirect_to @info_field, notice: 'Info field was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @info_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /info_fields/1
  # DELETE /info_fields/1.json
  def destroy
    @info_field = InfoField.find(params[:id])
    @info_field.destroy

    respond_to do |format|
      format.html { redirect_to info_fields_url }
      format.json { head :no_content }
    end
  end
end
