
require 'osaka'

describe "Location path for an applescript command" do
  
  it "Should be able to create a valid location when appending two locations" do
    location = Osaka::Location.new("scrollbar") + Osaka::Location.new("window 1")
    expect(location.to_s).to eq "scrollbar of window 1"
  end
  
  it "Should be able to add empty locations" do
    location = Osaka::Location.new("location") + ""
    expect(location.to_s).to eq "location"
  end
  
  it "Should be able to get the top-level element out" do
    location = at.sheet(1).sheet(2).window("three")
    expect(location.top_level_element).to eq at.window("three")
  end
  
  
  it "Should be able to create locations using at" do
    at.button(1).to_s.should == "button 1"
  end
  
  it "Should be able to create empty prefixed locations" do
    Osaka::Location.new("").as_prefixed_location.should == ""
  end
  
  it "Should be able to check whether the location already has a window" do
    Osaka::Location.new("").has_window?.should == false
    at.window("one").has_window?.should == true
  end
  
  it "Should be able to create groups" do
    at.group(1).to_s.should == "group 1"
  end
  
  it "Should be able to combine buttons with groups" do
    at.button("1").group(2).to_s.should == 'button "1" of group 2'
  end
  
  it "Should be able to combine groups with windows" do
    at.button(1).group(2).window("Name").to_s.should == 'button 1 of group 2 of window "Name"'
  end
  
  it "Can compare different locations" do
    at.button(1).should == at.button(1)
  end
  
  it "Should be able to convert to a prefixed location" do
    at.button(1).as_prefixed_location == " of button 1"
  end
  
  it "Cannot create a location with two times window" do
    lambda {at.window(1).window(1)}.should raise_error(Osaka::InvalidLocation, "Invalid location: window 1 of window 1")
  end

end
