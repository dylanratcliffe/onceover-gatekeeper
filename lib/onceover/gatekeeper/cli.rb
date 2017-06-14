require 'onceover/gatekeeper/compiler'
require 'onceover/cli'

class Onceover
  class CLI
    class Compile
      def self.command
        @cmd ||= Cri::Command.define do
          name 'compile'
          usage 'compile <puppet class> [options]'
          summary 'see description'
          description 'see summary'

          # TODO: Integrate this correctly
          option :n, :node, 'The name of the node', {:argument => :required}
          option :f, :facts, 'The path to the facts json', {:argument => :required}
          option :r, :hiera, 'The path to the hiera config file', {:argument => :required}
          option :e, :environment, 'The environment name', {:argument => :required}
          option :m, :modulepath, 'The path to the modules', {:argument => :required, :multiple => true}

          flag :h, :help, 'Show this help message' do |_, c|
            puts c.help
            exit 0
          end

          run do |opts, args, cmd|
            klass = args.first
            pattern = "**/#{File.join(klass.split('::').insert(1, 'manifests'))}.pp"

            s = SOE::Compiler.new
            manifest_file = opts[:modulepath].map { |r| Dir.glob("#{r}/#{pattern}") }.flatten.first
            s.code = File.read(manifest_file) + "\ninclude #{klass}"

            s.node_name = opts.fetch(:node, 'testhost.example.com')
            s.facts = opts.key?(:facts) ? JSON.parse(File.read(opts[:facts])) : {}
            s.environment = opts.fetch(:environment, 'production')
            s.hiera_config = opts.fetch(:hiera_config, nil)
            s.modulepath = opts[:modulepath].join(':')
            puts JSON.generate(s.build)
          end
        end


        def self.run(args)
          @cmd.run(args)
        end
      end
    end
  end
end

Onceover::CLI.command.add_command(Onceover::CLI::Compile.command)
