class WatchersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection

  def create
    @watcher = current_user.watchers.build(collection: @collection)
    
    if @watcher.save
      redirect_to @collection, notice: "You are now watching #{@collection.name}"
    else
      redirect_to @collection, alert: "Unable to watch this collection"
    end
  end

  def destroy
    @watcher = current_user.watchers.find_by(collection: @collection)
    
    if @watcher&.destroy
      redirect_to @collection, notice: "You are no longer watching #{@collection.name}"
    else
      redirect_to @collection, alert: "Unable to unwatch this collection"
    end
  end

  private

  def set_collection
    @collection = Collection.find(params[:collection_id])
  end
end
