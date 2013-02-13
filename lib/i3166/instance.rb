module Iso
  module I3316
    module InstanceMethods
      attr_reader :id, :alpha2, :alpha3, :numeric

      def initialize(alpha2, alpha3, numeric, localizedNames = {})
        @id = alpha2.downcase.to_sym
        @alpha2 = alpha2
        @alpha3 = alpha3
        @numeric = numeric.to_i
        @localizedNames = localizedNames
      end

      def names
        @localizedNames
      end

      def name(locale = :en)
        if @localizedNames.empty?
          "#{alpha3} (#{"%03d" % numeric})"
        else
          @localizedNames[locale]
        end
      end

      alias :__to_s :to_s

      def to_s
        name
      end

      def inspect
        __to_s()
      end
    end
  end
end
