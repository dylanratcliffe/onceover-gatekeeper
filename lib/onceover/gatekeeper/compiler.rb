require 'rspec-puppet'

class Onceover
  class Gatekeeper
    class Compiler
      include RSpec::Puppet::Support

      attr_accessor :code, :node_name, :facts, :hiera_config, :environment
      attr_reader :modulepath

      def modulepath=(value)
        Puppet[:modulepath] = value
      end

      def adapter
        @adapter ||= begin
          adapter = RSpec::Puppet::Adapters.get
          adapter.setup_puppet(self)
          Puppet::Test::TestHelper.initialize
          Puppet::Test::TestHelper.before_each_test
          adapter
        end
      end

      def build
        build_catalog_without_cache(node_name, facts, hiera_config, code, nil).resources.reject { |r|
          ['Class', 'Stage'].include?(r.type)
        }.map { |r|
          temp = r.to_hash.merge(:type => r.type.downcase)

          if r.builtin_type?
            temp[:name] = r.uniqueness_key.first
            temp.delete(r.key_attributes.first)
          end

          temp
        }
      end
    end
  end
end
