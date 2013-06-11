class TagsController < ApplicationController
  load_and_authorize_resource
  
  # GET /tags
  # GET /tags.json
  def index
    # @tags = Tag.order(:name)
    return_tags = @tags.where("name like?", "%#{params[:q]}%")
    #need to add an if statement essentially saying do not make a new tag if the query matchs an existing tag
    t = Tag.new
    t.name = params[:q]
    return_tags << t
    
    respond_to do |format|
      if cannot? :look_at, Tag
        format.html { redirect_to home_path }
      else
        format.html # index.html.erb
      end
        format.json { render json: return_tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    # @tag = Tag.find(params[:id])
    respond_to do |format|
      if cannot? :look_at, Tag
        format.html { redirect_to home_path }
      else
        format.html # show.html.erb
      end
      format.json { render json: @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    # @tag = Lab.new

    respond_to do |format|
      if cannot? :look_at, Tag
        format.html { redirect_to home_path }
      else
        format.html # new.html.erb
      end
      format.json { render json: @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    # @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.json
  def create
    # @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Info field was successfully created.' }
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    # @tag = Tag.find(params[:id])
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    # @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url, notice: "Tag was successfully destroyed."}
      format.json { head :no_content }
    end
  end
end
