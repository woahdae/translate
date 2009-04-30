#
module EditInPlace
  def translate(msgid)
    return msgid if msgid.start_with?("<span")
    if $translate_in_same_window
      "<span class=\"translate\" onClick=\"javascript:top.document.location.href='/#{I18n.locale}/translate/edit?key=#{CGI::escape(msgid)}';\">" + I18n.translate(msgid) + '</span>' 
    else
      "<span class=\"translate\" onClick=\"window.open('/#{I18n.locale}/translate/edit?key=#{CGI::escape(msgid)}','mywin','width=480,height=600,scrollbars=1,toolbar=0,resizable=1');\">" + I18n.translate(msgid) + '</span>' 
    end
  end
  alias :t :translate
  module_function :translate, :t
end

module ApplicationHelper
  include EditInPlace
end

module Controller
  include EditInPlace
end

module ActiveRecord
  class Base
    include EditInPlace
  end
end

  
#end