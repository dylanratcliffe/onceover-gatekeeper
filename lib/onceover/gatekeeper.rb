require 'onceover/gatekeeper/cli'
require 'onceover/testconfig'
require 'onceover/controlrepo'

class Onceover
  class Gatekeeper
    attr_accessor :config, :repo

    def self.pre_prepare(runner)
      # Get the config and repo objects that are in use for reference later
      @config = runner.config
      @repo   = runner.repo
    end

    def self.pre_write_spec_test(tst)
      require 'json'

      c = Onceover::Gatekeeper::Compiler.new

      # Set up settings from onceover
      c.node_name = tst.nodes[0].fact_set['fqdn']
      c.facts = tst.nodes[0].fact_set
      c.hiera_config = @repo.hiera_config
      c.code = "include #{tst.classes[0].name}"
      c.environment = 'production'
      c.modulepath = @repo.temp_modulepath.split(':')

      # Template variables
      examples_name = tst.classes[0].name
      class_name    = tst.classes[0].name
      resources = c.build


      require 'pry'
      binding.pry

      #c.hiera_config = @repo
    end

    def evaluate_template(template_name,bind)
      template_dir = File.expand_path('../../templates',File.dirname(__FILE__))
      template = File.read(File.expand_path("./#{template_name}",template_dir))
      ERB.new(template, nil, '-').result(bind)
    end
  end
end
