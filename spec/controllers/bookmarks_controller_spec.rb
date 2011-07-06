require 'spec_helper'

describe BookmarksController do

  before :all do
    @user       = Fabricate( :user )
    @bookmarks  = [
      Fabricate( :bookmark, :users => [ @user ] ),
      Fabricate( :bookmark, :users => [ @user ] ),
      Fabricate( :bookmark )
    ]
  end

  describe "GET 'index'" do
    it "should be successful" do
      sign_in @user
      get 'index'
      response.should be_success
    end
    it "assigns the user's bookmarks to @bookmarks" do
      sign_in @user
      get 'index'
      assigns( :bookmarks ).should eq( @user.bookmarks )
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      sign_in @user
      get 'show', :id => @bookmarks.first.id
      response.should be_success
    end
    it "assigns a bookmark to @bookmark" do
      sign_in @user
      get 'show', :id => @bookmarks.first.id
      assigns( :bookmark ).should eq( @bookmarks.first )
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      sign_in @user
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      sign_in @user
      post 'create'
      response.should be_success
    end
    it "should create a bookmark if it doesn't exist in database" do
      sign_in @user
      expect do
        bookmark = Fabricate( :bookmark, :users => [ @user ] )
        post 'create', Hash.from_xml( bookmark.to_xml )
      end.to change( @user, :bookmarks_count ).by( 1 )
    end
    it "should not create a bookmark if it already exists in database" do
      sign_in @user
      expect do
        post 'create', Hash.from_xml( @bookmarks.first.to_xml )
      end.to change( Bookmark, :count ).by( 0 )
    end
  end

  describe "GET 'import'" do
    it "should be successfull" do
      sign_in @user
      get 'import'
      response.should be_success
    end
  end

  describe "POST 'import_from_provider'" do

    context "provider is 'delicious'" do
      it "should import and create bookmarks" do
        path  = File.join Rails.root, 'spec', 'fixtures', 'bookmarks', 'delicious_feed.xml'
        xml   = File.read path
        Bookmark.delete_all
        Bookmark.stub( :retrieve_feed_from_delicious ) { Feedzirra::Feed.parse xml }
        params = {
          :provider           => 'delicious',
          :delicious_username => 'johntheripper'
        }
        sign_in @user
        expect do
          post 'import_from_provider', params
        end.to change( Bookmark, :count ).by( 3 )
      end
    end

    it "should redirect to bookmarks#index view" do
      sign_in @user
      params = {
        :provider           => 'delicious',
        :delicious_username => 'johntheripper'
      }
      post 'import_from_provider', params
      response.should redirect_to( bookmarks_path )
    end

  end

end
