module Iso
  module I3316
    module Finders
      def all
        @countries.values || {}
      end

      def find(*args)
        unless args.first.is_a?(Symbol)
          raise ArgumentError, 'Find takes one or more symbol IDs. Try #where'
        end

        case args.first
        when :all
          send(args.first)
        else
          find_with_ids(*args)
        end
      end

      def find_with_ids(*ids)
        case ids.size
        when 0
          raise "Couldn't find Country without an ID"
        when 1
          find_one(ids.first)
        else
          find_some(ids)
        end
      end

      def find_one(id)
        unless @countries[id]
          raise CountryNotFound, "Couldn't find Country with id=#{id}"
        end

        @countries[id]
      end

      def find_some(ids)
        ids.map {|id| find_one(id) }
      end

      def where(opts)
        if opts.is_a?(Array) || opts.is_a?(Symbol)
          find(opts)
        elsif opts.is_a?(String) && opts.length == 2
          find_with_alpha2(opts)
        elsif opts.is_a?(String) && opts.length == 3
          find_with_alpha3(opts)
        elsif opts.is_a?(String) && opts.length > 3
          find_with_name(opts)
        elsif opts.is_a?(Numeric)
          find_with_numeric(opts)
        else
          if opts[:alpha2]
            find_with_alpha2(opts[:alpha2])
          elsif opts[:alpha3]
            find_with_alpha3(opts[:alpha3])
          elsif opts[:numeric]
            find_with_numeric(opts[:numeric])
          end
        end
      end

      def find_with_alpha2(alpha2)
        all.find {|country| country.alpha2 == alpha2.to_s.upcase }
      end

      def find_with_alpha3(alpha3)
        all.find {|country| country.alpha3 == alpha3.to_s.upcase }
      end

      def find_with_numeric(numeric)
        all.find {|country| country.numeric == numeric.to_i }
      end

      def find_with_name(name, locale = nil)
        if !locale
          all.find {|country| country.names.values.include?(name) }
        else
          all.find {|country| country.names[locale] == name }
        end
      end
    end
  end
end
