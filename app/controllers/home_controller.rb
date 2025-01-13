class HomeController < ApplicationController
  def index
    base_query = Post.includes(:user, :collection, :doots)
                    .where('posts.created_at > ?', 1.week.ago)
                    .left_joins(:doots)
                    .group('posts.id')
                    .order('COUNT(doots.id) DESC, posts.created_at DESC')

    if user_signed_in?
      @posts = base_query.joins(collection: :watchers)
                        .where(watchers: { user_id: current_user.id })
    else
      @posts = base_query
    end

    @posts = @posts.page(params[:page]).per(10)
  end
end
