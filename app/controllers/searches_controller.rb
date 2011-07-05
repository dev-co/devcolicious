class SearchesController < ApplicationController

  def bookmarks_by_tag
    if params[ :tags ].empty?
      redirect_to root_path and return
    end
    tags = Bookmark.tags_from_string params[ :tags ]
    if current_user
      if params[ :global ]
        @bookmarks = Bookmark.any_in :tags => tags
      else
        @bookmarks = current_user.bookmarks.any_in :tags => tags
      end
    else
      @bookmarks = Bookmark.any_in :tags => tags
    end
    render 'home/index'
  end

end
