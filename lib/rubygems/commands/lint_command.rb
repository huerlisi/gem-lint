require 'rubygems/command'
require 'gem_lint'

class Gem::Commands::LintCommand < Gem::Command
  def description # :nodoc:
    'Check a gem file for common mistakes and errors'
  end

  def arguments # :nodoc:
    "GEM       built gem to check"
  end

  def usage # :nodoc:
    "#{program_name} GEM"
  end

  def initialize
    super 'lint', description
  end

  def execute
    runner = GemLint::Runner.new(get_one_gem_name)
    tags = runner.tags
    if tags.empty?
      puts "No test failures!"
      puts
    else
      puts "#{tags.size} failures"
      tags.each do |tag|
        puts "- #{tag}"
      end
      puts
      exit 1
    end
  end

end