class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_bookmarks
    @bookmarks = Bookmark.all
  end

end
