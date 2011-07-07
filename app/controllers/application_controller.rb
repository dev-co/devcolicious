class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_bookmarks
    @bookmarks = Bookmark.all
  end

  def current_tags
    @current_tags ||= if params[:controller] == "tags"
                       (params[:id]||[]).split("+")
                      else
                       (params[:tags]||[]).split("+")
                      end
  end
  helper_method :current_tags

end
