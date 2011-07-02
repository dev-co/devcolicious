require 'spec_helper'

describe User do

  it { should validate_presence_of :email         }
  it { should have_and_belong_to_many :bookmarks  }

  it "should return 0 for bookmarks_count method when no bookmark is associated" do
    user = Fabricate( :user )
    user.bookmarks_count.should be_zero
  end

  it "should not return 0 for bookmarks_count method when a bookmark is associated" do
    bookmark  = Fabricate( :bookmark )
    user      = Fabricate( :user, :bookmarks => [ bookmark ] )
    user.bookmarks_count.should_not be_zero
  end

end
