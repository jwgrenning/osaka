# encoding: utf-8
module Osaka
  
  class TypicalFindDialog

    def initialize(application_name, own_location)
      @control = Osaka::RemoteControl.new(application_name, own_location)
    end

    def find_replace_all string, replacement
      string_to_find string
      string_replacement replacement
      wait_for_replace_all_button?
      click_replace_all
      close
    end

    def string_to_find string
      @control.set("value", at.text_field(1), string)
    end

    def string_replacement replacement
      @control.set("value", at.text_field(2) , replacement)
    end

    def  wait_for_replace_all_button?
      @control.wait_until_exists(at.button("Replace All"))
    end
    
    def click_replace_all
      @control.click(at.button("Replace All"))
    end
    
    def close
      @control.keystroke('w', :command)
    end

  end      

end
