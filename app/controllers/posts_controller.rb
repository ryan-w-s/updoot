class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize_post, only: [:edit, :update]
  before_action :authorize_post_deletion, only: [:destroy]

  # GET /collections/:collection_id/posts
  def index
    @posts = @collection.posts.order(created_at: :desc)
  end

  # GET /collections/:collection_id/posts/1
  def show
  end

  # GET /collections/:collection_id/posts/new
  def new
    @post = @collection.posts.build
  end

  # GET /collections/:collection_id/posts/1/edit
  def edit
  end

  # POST /collections/:collection_id/posts
  def create
    @post = @collection.posts.build(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to collection_url(@collection), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/:collection_id/posts/1
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to collection_url(@collection), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/:collection_id/posts/1
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to collection_url(@collection), notice: "Post was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    def set_collection
      @collection = Collection.find(params[:collection_id])
    end

    def set_post
      @post = @collection.posts.find(params[:id])
    end

    def authorize_post
      unless @post.user == current_user
        redirect_to collection_path(@collection), alert: "You can only edit your own posts."
      end
    end

    def authorize_post_deletion
      unless @post.user == current_user || @collection.moderator?(current_user)
        redirect_to collection_path(@collection), alert: "You can only delete your own posts or posts in collections you moderate."
      end
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
