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
      require 'fileutils'

      c = Onceover::Gatekeeper::Compiler.new

      # Set up settings from onceover
      c.node_name    = tst.nodes[0].fact_set['fqdn']
      c.facts        = tst.nodes[0].fact_set
      c.hiera_config = @repo.hiera_config
      c.code         = "include #{tst.classes[0].name}"
      c.environment  = 'production'
      c.modulepath   = @repo.temp_modulepath.split(':')

      # Template variables
      examples_name  = tst.to_s
      class_name     = tst.classes[0].name
      resources      = c.build

      require 'pry'
      binding.pry

      shared_example = Onceover::Gatekeeper.evaluate_template('shared_example.erb',binding)
      FileUtils.mkdir_p("#{@repo.tempdir}/spec/shared_examples")
      File.write("#{@repo.tempdir}/spec/shared_examples/#{examples_name}_spec.rb",shared_example)

      # Modify the test to include the extra line
      tst.test_config['in_context_additions'] << "include_examples \"#{tst.to_s}\""
    end

    def self.evaluate_template(template_name,bind)
      template_dir = File.expand_path('../../templates',File.dirname(__FILE__))
      template = File.read(File.expand_path("./#{template_name}",template_dir))
      ERB.new(template, nil, '-').result(bind)
    end
  end
end
