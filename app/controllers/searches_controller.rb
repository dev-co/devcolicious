class SearchesController < ApplicationController

  def bookmarks_by_tag
    if params[ :tags ].empty?
      redirect_to root_path and return
    end
    tags = Bookmark.tags_from_string params[ :tags ]
    if current_user
      if params[ :global ]
        @bookmarks = Bookmark.find_by_tags tags
      else
        @bookmarks = current_user.bookmarks.find_by_tags tags
      end
    else
      @bookmarks = Bookmark.find_by_tags tags
    end
    render 'home/index'
  end

end
