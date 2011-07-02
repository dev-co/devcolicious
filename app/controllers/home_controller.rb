class HomeController < ApplicationController

  before_filter :load_bookmarks, :only => [ :index ]

  def index
  end

end
