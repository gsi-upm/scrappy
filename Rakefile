require 'rubygems'
require 'rake'
require 'echoe'
require './lib/scrappy'

Echoe.new('scrappy', Scrappy::VERSION) do |p|
  p.description    = "RDF web scraper"
  p.summary        = "Web scraper that allows producing RDF data out of plain web pages"
  p.url            = "http://github.com/josei/scrappy"
  p.author         = "Jose Ignacio"
  p.email          = "joseignacio.fernandez@gmail.com"
  p.ignore_pattern = ["pkg/*"]
  p.dependencies = [['activesupport','>= 2.3.5'], ['sinatra', '>= 1.1.2'], ['sinatra-flash', '>= 0.3.0'], ['thin', '>= 1.2.7'], ['nokogiri', '>= 1.4.1'], ['mechanize','>= 1.0.0'], ['lightrdf','>= 0.4.1'], ['i18n', '>= 0.4.2'], ['rest-client', '>=1.6.1'], ['haml', '>= 3.0.24'], ['rack-flash', '>= 0.1.1']]
end

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README.rdoc').include('lib/**/*.rb')
  rdoc.main = "README.rdoc"
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each
