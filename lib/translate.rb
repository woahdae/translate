module Translate
  def translate(msgid)
    return msgid if msgid.start_with?("<span")
    if $translate_in_same_window
      "<span class=\"gettext\" onClick=\"javascript:top.document.location.href='/translate/edit?key=#{CGI::escape(msgid)}';\">" + I18n.translate(msgid) + '</span>' 
    else
      "<span class=\"gettext\" onClick=\"window.open('/translate/edit?key=#{CGI::escape(msgid)}','mywin','width=400,height=600,scrollbars=1,toolbar=0,resizable=1');\">" + I18n.translate(msgid) + '</span>' 
    end
  end
  alias :t :translate
  module_function :translate, :t
end
 
module ApplicationHelper
  include Translate
end
 
module Controller
  include Translate
end
 
module ActiveRecord
  class Base
    include Translate
  end
end

require File.join(File.dirname(__FILE__), "translate_controller")
require File.join(File.dirname(__FILE__), "translate_helper")
Dir[File.join(File.dirname(__FILE__), "translate", "*.rb")].each do |file|
  require file
end


