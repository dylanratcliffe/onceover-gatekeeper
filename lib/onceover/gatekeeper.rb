require 'onceover/gatekeeper/cli'
require 'onceover/testconfig'
require 'onceover/controlrepo'

class Onceover
  class Gatekeeper
    attr_accessor :config, :repo

    def self.pre_prepare(runner)
      @config = runner.config
      @repo   = runner.repo
    end

    def self.pre_write_spec_test(tst)
      c = Onceover::Gatekeeper::Compiler.new

      c.node_name = 'foo'
      c.facts = tst.nodes[0].fact_set
      #c.hiera_config = @repo

      require 'pry'
      binding.pry

    end
  end
end
