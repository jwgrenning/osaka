
require 'osaka'

describe "Osaka::ApplicationWrapper" do

  name = "ApplicationName"
  quoted_name = "\"#{name}\""
  subject { Osaka::ApplicationWrapper.new(name) }
  
  it "Should be able to tell applications to do something" do
    Osaka::ScriptRunner.should_receive(:execute).with("tell application #{quoted_name}; command; end tell")
    subject.tell("command")
  end

  it "Can also pass multi-line commands to telling an application what to do" do
    Osaka::ScriptRunner.should_receive(:execute).with("tell application #{quoted_name}; activate; quit; end tell")
    subject.tell("activate; quit")
  end

  it "Has a short-cut method for activation" do
    Osaka::ScriptRunner.should_receive(:execute).with(/activate/)
    subject.activate
  end
  
  it "Has a short-cut method for quitting" do
    Osaka::ScriptRunner.should_receive(:execute).with(/quit/)
    subject.quit
  end
    
  it "Should be able to generate events via the Systems Events" do
    Osaka::ScriptRunner.should_receive(:execute).with(/tell application "System Events"; tell process #{quoted_name}; quit; end tell; end tell/)
    subject.system_event!("quit")
  end

  it "Should be able to generate events via the Systems Events and activate the application first" do
    subject.should_receive(:activate)
    subject.should_receive(:system_event!).with("quit")
    subject.system_event("quit")
  end
  
  it "Should be able to wait for for a specific element existing" do
    Osaka::ScriptRunner.should_receive(:execute).with(/repeat until exists window 1; end repeat/)
    subject.wait_until_exists!("window 1")
  end
  
  it "Should be able to wait until exists and activate the application first" do
    subject.should_receive(:activate)
    subject.should_receive(:wait_until_exists!).with("window 1")
    subject.wait_until_exists("window 1")    
  end

  it "Should be able to wait for a specific element to not exist anymore" do
    Osaka::ScriptRunner.should_receive(:execute).with(/repeat until not exists window 1; end repeat/)
    subject.wait_until_not_exists!("window 1")    
  end
  
  it "Should be able to wait_until_not_exists and activate" do
    subject.should_receive(:activate)
    subject.should_receive(:wait_until_not_exists!).with("window 1")
    subject.wait_until_not_exists("window 1")        
  end
  
  it "Should be able to generate keystroke events" do
    Osaka::ScriptRunner.should_receive(:execute).with(/keystroke "p"/)
    subject.keystroke!("p")
  end
  
  it "Should be able to keystroke and activate" do
    subject.should_receive(:activate)
    subject.should_receive(:keystroke!).with("a", [])
    subject.keystroke("a", [])        
  end
  
  it "Should be able to do keystrokes with command down" do
    Osaka::ScriptRunner.should_receive(:execute).with(/keystroke "p" using {command down}/)
    subject.keystroke!("p", :command)    
  end

  it "Should be able to do keystrokes with option and command down" do
    Osaka::ScriptRunner.should_receive(:execute).with(/keystroke "p" using {option down, command down}/)
    subject.keystroke!("p", [ :option, :command ])    
  end
  
  it "Should be able to do a keystroke and wait until something happen in one easy command" do
    subject.should_receive(:keystroke!).with("p", [])
    subject.should_receive(:wait_until_exists!).with("window 1")
    subject.keystroke_and_wait_until_exists!("p", [], "window 1")
  end
  
  it "Should be able to keystroke_and_wait_until_exists and activate" do
    subject.should_receive(:activate)
    subject.should_receive(:keystroke_and_wait_until_exists!).with("p", [], "window 1")
    subject.keystroke_and_wait_until_exists("p", [], "window 1")    
  end
  
  it "Should be able to do clicks" do
    Osaka::ScriptRunner.should_receive(:execute).with(/click menu button "PDF"/)
    subject.click!('menu button "PDF"')
  end
  
  it "Should be able to do click and activate" do
    subject.should_receive(:activate)
    subject.should_receive(:click!).with("button")
    subject.click("button")    
  end
  
  it "Should be able to do clicks and wait until something happened in one easy command" do
    subject.should_receive(:click!).with("button")
    subject.should_receive(:wait_until_exists!).with("window")
    subject.click_and_wait_until_exists!("button", "window")
  end
  
  it "Should be able to click_and_wait_until_exists and activate" do
    subject.should_receive(:activate)
    subject.should_receive(:click_and_wait_until_exists!).with("button", "window")
    subject.click_and_wait_until_exists("button", "window")
  end
    
  it "Should be able to click and wait until something doesn't exist anymore" do
    subject.should_receive(:click!).with("button1")
    subject.should_receive(:wait_until_not_exists!).with("window 1")
    subject.click_and_wait_until_not_exists!('button1', 'window 1')
  end

  it "Should be able to click_and_wait_until_not_exists and activate" do
    subject.should_receive(:activate)
    subject.should_receive(:click_and_wait_until_not_exists!).with("button", "window")
    subject.click_and_wait_until_not_exists('button', 'window')    
  end
  
  it "Should be able to set a value to an element" do
    subject.should_receive(:system_event!).with(/set value of window to "newvalue"/)
    subject.set!("value of window", "newvalue")
  end
  
  it "Should be able to set a value and activate" do
    subject.should_receive(:activate)
    subject.should_receive(:set!).with("value of window", "newvalue")
    subject.set("value of window", "newvalue")
  end
  
  
  
end