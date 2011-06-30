require 'spec_helper'

describe Bookmark do

  it { should have_and_belong_to_many :users }

  it "should not be persisted when its url is invalid" do
    @bookmark = Fabricate.build( :bookmark, :url => 'k4b00m' )
    @bookmark.save.should be_false
  end

  it "should be persisted when its url is valid" do
    @bookmark = Fabricate.build( :bookmark )
    @bookmark.save.should be_true
  end

end
