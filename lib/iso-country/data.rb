module Iso
  module Country
    module Data
      CORE_FILE = File.expand_path(File.join(File.dirname(__FILE__), 'data', '20120215', 'ISO_3166-1.core.json'))
      I18N_FILE = File.expand_path(File.join(File.dirname(__FILE__), 'data', '20120215', 'ISO_3166-1.i18n.json'))

      CORE = JSON.parse(File.open(CORE_FILE, 'rb') { |file| file.read })
      I18N = JSON.parse(File.open(I18N_FILE, 'rb') { |file| file.read })
      DICTIONARY = { countries: CORE, localizations: I18N }
    end
  end
end