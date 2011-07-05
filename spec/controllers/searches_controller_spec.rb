require 'spec_helper'

describe SearchesController do

  before :all do
    @bookmarks = [ Fabricate( :bookmark ) ]
  end

  context "user is not logged in" do
    describe "GET 'bookmarks_by_tag'" do
      it "should be successful" do
        post 'bookmarks_by_tag', :tags => 'mongodb, nosql'
        response.should be_success
      end
      it "assigns found bookmarks to @bookmarks" do
        post 'bookmarks_by_tag', :tags => 'mongodb, nosql'
        assigns( :bookmarks ).should eq( @bookmarks )
      end
      it "should redirect to home page when no tags specified" do
        post 'bookmarks_by_tag', :tags => ''
        response.should redirect_to( root_path )
      end
    end
  end

  context "user is logged in" do
    before :all do
      @user = Fabricate( :user )
      @bookmarks  = []
      3.times { @bookmarks << Fabricate( :bookmark ) }
    end
    describe "GET 'bookmarks_by_tag'" do
      it "should be successful" do
        sign_in @user
        post 'bookmarks_by_tag', :tags => 'nosql, sql'
        response.should be_success
      end

      context "search is not global" do

        it "should find no results when user has no bookmarks with the given tags" do
          sign_in @user
          post 'bookmarks_by_tag', :tags => 'mongodb, sql, nosql'
          assigns( :bookmarks ).to_a.should be_empty
        end

        it "should find some results when user has bookmarks with the given tags" do
          @user.bookmarks = @bookmarks
          sign_in @user
          post 'bookmarks_by_tag', :tags => 'mongodb, sql, nosql'
          assigns( :bookmarks ).to_a.should eq( @user.bookmarks )
        end

      end

      context "search is global" do
        it "should find some results even though user has no bookmarks witht the given tags" do
          sign_in @user
          post 'bookmarks_by_tag', :tags => 'mongodb, sql, nosql'
          assigns( :bookmarks ).to_a.should eq( @bookmarks )
        end
      end

    end
  end

end
