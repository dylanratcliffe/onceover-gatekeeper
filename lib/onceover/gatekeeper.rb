require 'onceover/gatekeeper/cli'
require 'onceover/testconfig'
require 'onceover/controlrepo'

class Onceover
  class Gatekeeper
    def self.pre_spec
      compiler = Onceover::Gatekeeper::Compiler.new
      repo     = Onceover::Controlrepo.new({})
      config   = Onceover::TestConfig.new(repo.onceover_yaml,{})

      require 'pry'
      binding.pry
    end
  end
end
