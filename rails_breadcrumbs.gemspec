require 'date'
Gem::Specification.new do |s|
  s.name = %q{rails_breadcrumbs}
  s.version = "0.5.1"
  s.date = Date.today.to_s
  s.summary = %q{RailsBreadcrumbs is a gem that implements breadcrumbs.}
  s.description = %q{RailsBreadcrumbs is a gem that implements breadcrumbs.}
  s.author = %q{Artem Rufanov}
  s.email = %q{developers@majoron.com}
  s.homepage = %q{http://www.majoron.com/}
  s.files = Dir.glob('**/*') - Dir.glob('distrib/**/*') - Dir.glob('lib/api/**/*') - Dir.glob('doc/*.xpr')
  s.bindir = 'bin'
  s.executables = Dir.glob('bin/*').collect {|f| File.basename(f)}
  s.require_paths << 'doc' << 'examples' << 'lib' << 'test'
  s.has_rdoc = true
  s.required_ruby_version = '>= 1.8.7'
end
