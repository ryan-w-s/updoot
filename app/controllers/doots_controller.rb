class DootsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_existing_doot, only: [:create]

  def create
    value = params[:value].to_i

    if @existing_doot
      if @existing_doot.value == value
        # If clicking the same doot, remove it
        @existing_doot.destroy
        message = "Doot removed"
      else
        # If clicking the opposite doot, update it
        @existing_doot.update(value: value)
        message = value == 1 ? "Updooted!" : "Downdooted!"
      end
    else
      # Create new doot
      @doot = current_user.doots.build(post: @post, value: value)
      if @doot.save
        message = value == 1 ? "Updooted!" : "Downdooted!"
      else
        message = "Unable to doot"
      end
    end

    respond_to do |format|
      format.html { redirect_back(fallback_location: collection_path(@post.collection), notice: message) }
      format.json { 
        render json: { 
          total: @post.reload.doot_total,
          updoots: @post.updoot_count,
          downdoots: @post.downdoot_count,
          user_doot: current_user.doot_value_for(@post)
        } 
      }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_existing_doot
    @existing_doot = current_user.doots.find_by(post: @post)
  end
end 