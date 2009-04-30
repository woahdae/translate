module Translate
  class Routes
    def self.translation_ui(map, options={})
      map.with_options(options.merge(:controller => 'translate')) do |t|
        t.translate_list 'translate'
        t.translate 'translate/translate', :action => 'translate'
        t.translate_reload 'translate/reload', :action => 'reload'
        t.translate_edit 'translate/edit', :action => 'edit'
      end
    end
  end
end
