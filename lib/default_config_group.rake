namespace :test do
  desc "Test DefaultConfigGroup plugin"
  Rake::TestTask.new(:default_config_group) do |t|
    test_dir = File.join(File.dirname(__FILE__), '..', 'test')
    t.libs << ["test",test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
  end

end

Rake::Task[:test].enhance do
  Rake::Task['test:default_config_group'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:setup')
  Rake::Task["jenkins:unit"].enhance do
    Rake::Task['test:default_config_group'].invoke
  end
end
