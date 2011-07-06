require 'spec_helper'

describe Bookmark do

  it { should have_and_belong_to_many :users }
  it { should validate_presence_of :url }

  it "should not be persisted when its url is invalid" do
    bookmark = Fabricate.build( :bookmark, :url => 'k4b00m' )
    bookmark.save.should be_false
  end

  it "should be persisted when its url is valid" do
    bookmark = Fabricate.build( :bookmark )
    bookmark.save.should be_true
  end

  it "should return 0 for users_count method when no user is associated" do
    bookmark = Fabricate( :bookmark )
    bookmark.users_count.should be_zero
  end

  it "should not return 0 for users_count method when an user is associated" do
    user      = Fabricate( :user )
    bookmark  = Fabricate( :bookmark, :users => [ user ] )
    bookmark.users_count.should_not be_zero
  end

  it "should sanitize its tags when saving" do
    dirty_tags = %w[ Ruby RAILS RubyOnRails RuBy rAiLs ]
    nifty_tags = %w[ ruby rails rubyonrails ]
    bookmark = Fabricate( :bookmark, :tags => dirty_tags )
    bookmark.tags.should eq( nifty_tags )
  end

  it "should receive a comma separated list of tags and normalize it" do
    dirty_tags  = 'mongo db, no sql, sql'
    nifty_tags  = %w[ mongodb nosql sql ]
    Bookmark.tags_from_string( dirty_tags ).should eq( nifty_tags )
  end

  it "retrieves a list of bookmarks from Delicious given a delicious username" do
    path  = File.join Rails.root, 'spec', 'fixtures', 'bookmarks', 'delicious_feed.xml'
    xml   = File.read path
    Bookmark.delete_all
    Bookmark.stub!( :retrieve_feed_from_delicious ) { Feedzirra::Feed.parse xml }
    expect do
      user                = Fabricate( :user )
      delicious_username  = 'johntheripper'
      Bookmark.from_delicious_feed user, delicious_username
    end.to change( Bookmark, :count ).by( 3 )
  end

end
