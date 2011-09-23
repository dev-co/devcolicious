class TagsController < ApplicationController
  def index
    @tags = Tag.all
    if params[:group_by] == "alpha"
      @tags = @tags.order_by(["name", "asc"])
    end

    p "-"*80
    p params[:sort_by] == "counter"
    if params[:sort_by] == "counter"
      @tags = @tags.order_by(["count", "desc"])
    end
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @tag_names = @current_tags = current_tags
    @tags = Tag.where( :name.in => @tag_names )

    @bookmarks = Bookmark.where( :tags.in => @tag_names )
  end
end
