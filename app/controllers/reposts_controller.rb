class RepostsController < ApplicationController
  # GET /reposts
  # GET /reposts.json
  def index
    @reposts = Repost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reposts }
    end
  end

  # GET /reposts/1
  # GET /reposts/1.json
  def show
    @repost = Repost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repost }
    end
  end

  # GET /reposts/new
  # GET /reposts/new.json
  def new
    @repost = Repost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repost }
    end
  end

  # GET /reposts/1/edit
  def edit
    @repost = Repost.find(params[:id])
  end

  # POST /reposts
  # POST /reposts.json
  def create
    @repost = Repost.new(params[:repost])

    respond_to do |format|
      if @repost.save
        format.html { redirect_to @repost, notice: 'Repost was successfully created.' }
        format.json { render json: @repost, status: :created, location: @repost }
      else
        format.html { render action: "new" }
        format.json { render json: @repost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reposts/1
  # PUT /reposts/1.json
  def update
    @repost = Repost.find(params[:id])

    respond_to do |format|
      if @repost.update_attributes(params[:repost])
        format.html { redirect_to @repost, notice: 'Repost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reposts/1
  # DELETE /reposts/1.json
  def destroy
    @repost = Repost.find(params[:id])
    @repost.destroy

    respond_to do |format|
      format.html { redirect_to reposts_url }
      format.json { head :no_content }
    end
  end
end
