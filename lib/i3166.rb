# encoding: UTF-8

require 'json'

require 'i3166/version'
require 'i3166/data'
require 'i3166/exceptions'
require 'i3166/finders'
require 'i3166/instance'
require 'i3166/mongoid'

module Iso
  module I3316
    include Iso::I3316::Exceptions
    include Iso::I3316::Data

    class Country
      include Iso::I3316::InstanceMethods

      @countries = {}

      def self.demongoize(country)
        find(country)
      end

      def self.evolve(country)
        country.id
      end

      Iso::I3316::Data::DICTIONARY[:countries].each do |c|
        localizations = {}
        if Iso::I3316::Data::DICTIONARY[:localizations][c['alpha-2']]
          localizations = Iso::I3316::Data::DICTIONARY[:localizations][c['alpha-2']].inject({}){|memo, (k,v)| memo[k.to_sym] = v; memo}
        end

        country = Country.new(c['alpha-2'], c['alpha-3'], c['numeric'], localizations)
        @countries[country.id] = country
      end

      extend Iso::I3316::Finders
      include Iso::I3316::Mongoid
    end
  end
end
