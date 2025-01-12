class ModeratorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection
  before_action :ensure_moderator
  before_action :set_target_user, only: [:destroy]

  def create
    @user = User.find_by(email: params[:user_email])
    
    if @user.nil?
      redirect_to edit_collection_path(@collection), alert: "User not found."
      return
    end

    if @collection.mods.include?(@user)
      redirect_to edit_collection_path(@collection), alert: "User is already a moderator."
      return
    end

    @moderator = @collection.moderators.build(user: @user)

    if @moderator.save
      redirect_to edit_collection_path(@collection), notice: "Moderator was successfully added."
    else
      redirect_to edit_collection_path(@collection), alert: "Unable to add moderator."
    end
  end

  def destroy
    if @collection.mods.count <= 1
      redirect_to edit_collection_path(@collection), alert: "Cannot remove the last moderator."
      return
    end

    @moderator = @collection.moderators.find_by(user: @target_user)
    
    if @moderator&.destroy
      redirect_to edit_collection_path(@collection), notice: "Moderator was successfully removed."
    else
      redirect_to edit_collection_path(@collection), alert: "Unable to remove moderator."
    end
  end

  private

  def set_collection
    @collection = Collection.find(params[:collection_id])
  end

  def set_target_user
    @target_user = User.find(params[:id])
  end

  def ensure_moderator
    unless @collection.moderator?(current_user)
      redirect_to collection_path(@collection), alert: "You must be a moderator to perform this action."
    end
  end
end 