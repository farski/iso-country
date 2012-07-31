# encoding: UTF-8

require 'json'

require 'iso-country/version'
require 'iso-country/data'
require 'iso-country/exceptions'
require 'iso-country/finders'
require 'iso-country/instance'
require 'iso-country/mongoid'

module Iso
  module Country
    include Iso::Country::Exceptions
    include Iso::Country::Data

    class Country
      include Iso::Country::InstanceMethods

      @countries = {}

      def self.demongoize(country)
        find(country)
      end

      def self.evolve(country)
        country.id
      end

      Iso::Country::Data::DICTIONARY[:countries].each do |c|
        localizations = {}
        if Iso::Country::Data::DICTIONARY[:localizations][c['alpha-2']]
          localizations = Iso::Country::Data::DICTIONARY[:localizations][c['alpha-2']].inject({}){|memo, (k,v)| memo[k.to_sym] = v; memo}
        end

        country = Country.new(c['alpha-2'], c['alpha-3'], c['numeric'], localizations)
        @countries[country.id] = country
      end

      extend Iso::Country::Finders
      include Iso::Country::Mongoid
    end
  end
end
