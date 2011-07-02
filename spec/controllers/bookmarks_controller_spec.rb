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
      expect {
        bookmark = Fabricate( :bookmark, :users => [ @user ] )
        post 'create', Hash.from_xml( bookmark.to_xml )
      }.to change( @user, :bookmarks_count ).by( 1 )
    end
    it "should not create a bookmark if it already exists in database" do
      sign_in @user
      expect {
        post 'create', Hash.from_xml( @bookmarks.first.to_xml )
      }.to change( Bookmark, :count ).by( 0 )
    end
  end

end
