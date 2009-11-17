module Translate
  module EditInPlace
    class << self
      def options
        @options ||= {}
      end
    end
    
    def self.included(klass) 
      klass.class_eval do
        def translate_with_in_place_edit(*args)
          return translate_without_in_place_edit(*args) unless @translate_in_place
          
          msgid = args.first
          return msgid if msgid.start_with?("<span")
          if Translate::EditInPlace.options[:translate_in_same_window]
            translate_in_place_span(msgid, *args)
          else
            translate_in_popup_span(msgid, *args)
          end
        end
        
        alias_method_chain :translate, :in_place_edit
        alias :t :translate
        
      private

        def translate_in_place_span(msgid, *args)
          "<span class=\"translate\" onClick=\"javascript:top.document.location.href='/#{I18n.locale}/translate/edit?key=#{CGI::escape(msgid)}&redirect_to=#{request.url}';\">" + translate_without_in_place_edit(*args) + '</span>' 
        end

        def translate_in_popup_span(msgid, *args)
          "<span class=\"translate\" onClick=\"window.open('/#{I18n.locale}/translate/edit?key=#{CGI::escape(msgid)}','mywin','width=480,height=600,scrollbars=1,toolbar=0,resizable=1');\">" + translate_without_in_place_edit(*args) + '</span>' 
        end
      end
    end
  end
end

module ActionView #:nodoc:
  class Base
    include Translate::EditInPlace
  end
end

module ActionController #:nodoc:
  class Base
    include Translate::EditInPlace
    
    before_filter :set_translate_in_place
    
    def set_translate_in_place
      session[:translate_in_place] = @translate_in_place = params[:translate] == "true" unless params[:translate].nil?
    end
  end
end

