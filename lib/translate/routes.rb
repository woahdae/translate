module Translate
  class Routes
    def self.translation_ui(map, options={})
      map.with_options(options.merge(:controller => 'translate')) do |t|
        t.translate_list 'translate', :path_prefix=>"/:locale"
        t.translate 'translate/translate', :action => 'translate', :path_prefix=>"/:locale"
        t.translate_reload 'translate/reload', :action => 'reload', :path_prefix=>"/:locale"
        t.translate_edit 'translate/edit', :action => 'edit', :path_prefix=>"/:locale"
      end
    end
  end
end
