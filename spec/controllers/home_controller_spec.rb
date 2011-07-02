require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do

    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "assigns all bookmarks to @bookmarks" do
      bookmarks = Bookmark.all
      get 'index'
      assigns( :bookmarks ).should eq( bookmarks )
    end

  end

end
