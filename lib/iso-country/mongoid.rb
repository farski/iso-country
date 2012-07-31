module Iso
  module Country
    module Mongoid
      def mongoize
        id
      end

      # def self.demongoize(country)
      #   "find(country)"
      # end

      # def self.evolve(country)
      #   country.id
      # end
    end
  end
end
