class BookmarksController < ApplicationController

  before_filter :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks
    respond_to do |format|
      format.html
      format.json { render :json => @bookmarks }
    end
  end

  def show
    @bookmark = Bookmark.find params[ :id ]
    respond_to do |format|
      format.html
      format.json { render :json => @bookmark }
    end
  end

  def new
    @bookmark = Bookmark.new
    respond_to do |format|
      format.html
      format.json { render :json => @bookmark }
    end
  end

  def create
    @bookmark = Bookmark.create params[ :bookmark ]
    respond_to do |format|
      format.html do
        if @bookmark.persisted?
          flash[ :notice ] = 'Bookmark successfully created.'
          redirect_to bookmark_path( @bookmark )
        else
          flash[ :error ] = 'Bookmark could not be saved.'
          render :new
        end
      end
      format.json do
        result = {}
        if @bookmark.persisted?
          result = {
            :status   => 'ok',
            :message  => 'Bookmark successfully created',
            :bookmark => @bookmark
          }
        else
          result = {
            :status   => 'error',
            :message  => 'Bookmark could not be saved.',
            :errors   => @bookmark.errors.full_messages
          }
        end
        render :json => result
      end
    end
  end

end
