require 'onceover/gatekeeper/cli'
require 'onceover/testconfig'
require 'onceover/controlrepo'

class Onceover
  class Gatekeeper
    def self.pre_spec(runner)
      compiler = Onceover::Gatekeeper::Compiler.new
      repo     = runner.repo
      config   = runner.config


    end

    def self.pre_write_spec_test(tst)
      require 'pry'
      binding.pry
    end
  end
end
