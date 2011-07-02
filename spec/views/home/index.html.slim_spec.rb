require 'spec_helper'

describe "home/index.html.slim" do

  it "render the @bookmarks" do
    bookmarks = [ Fabricate( :bookmark ) ]
    assign :bookmarks, bookmarks
    render
    rendered.should =~ /MongoDB/
  end

end
