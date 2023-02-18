require "bundler/setup"
require "rspec/core/rake_task"

Dir["#{__dir__}/lib/tasks/**/*.rake"].sort.each do |path|
  load path
end

task default: :spec
RSpec::Core::RakeTask.new(:spec)
