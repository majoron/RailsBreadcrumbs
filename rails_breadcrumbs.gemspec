require 'date'
Gem::Specification.new do |s|
  s.name = %q{rails_breadcrumbs}
  s.version = "0.5.0"
  s.date = Date.today.to_s
  s.summary = %q{The AntHill is a powerful networking library which implements network fail-over and scaling functionality for any user applications.}
  s.description = %q{The AntHill is a powerful networking library which implements network fail-over and scaling functionality for any user applications..}
  s.author = %q{Artem Rufanov}
  s.email = %q{arufanov@gmail.com}
  s.homepage = %q{http://www.majoron.com/}
  s.files = Dir.glob('**/*') - Dir.glob('distrib/**/*') - Dir.glob('lib/api/**/*') - Dir.glob('doc/*.xpr')
  s.bindir = 'bin'
  s.executables = Dir.glob('bin/*').collect {|f| File.basename(f)}
  s.require_paths << 'doc' << 'examples' << 'lib' << 'test'
  s.rubyforge_project = %q{anthill}
  s.has_rdoc = true
  s.required_ruby_version = '>= 1.8.2'
end