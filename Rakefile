require "bundler/gem_tasks"
require "rake/testtask"
require "rubocop/rake_task"
require "syntax_tree/rake_tasks"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

RuboCop::RakeTask.new do |task|
  task.requires << "rubocop-minitest"
  task.requires << "rubocop-rake"
end
task default: %i[test rubocop]

SyntaxTree::Rake::CheckTask.new
SyntaxTree::Rake::WriteTask.new
