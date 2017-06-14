puts "GATEKEEPER ENGAGED!"
require 'pry'
require 'onceover/testconfig'
require 'onceover/controlrepo'

repo = Onceover::Controlrepo.new
conf = Onceover::TestConfig.new(repo.onceover_yaml,{})

conf.spec_tests.each do |tst|
  puts tst.test_config
end
