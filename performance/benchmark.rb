# frozen_string_literal: true

require 'benchmark'
require 'rblineprof'
require 'rblineprof-report'
require 'mquve'
require 'kramdown'
require 'redcarpet'

files = Dir.glob(File.join(File.dirname(__FILE__), '**', '*.md'))

RUNS = 10

files.each do |file|
  data = File.read(file)
  Benchmark.bmbm do |benchmark|
    puts
    puts "Test using file #{file} and #{RUNS} runs"
    benchmark.report("mquve #{Mquve::VERSION}") do
      html = ''
      RUNS.times { html = Mquve.to_html(data) }
      html_file = File.join(File.dirname(__FILE__), 'html', "#{File.basename(file).split('.')[0]}_mquve.html")
      File.open(html_file, 'w+') do |f|
        f.write html
      end
    end
    benchmark.report("kramdown #{Kramdown::VERSION}") do
      html = ''
      RUNS.times { html = Kramdown::Document.new(data).to_html }
      html_file = File.join(File.dirname(__FILE__), 'html', "#{File.basename(file).split('.')[0]}_kramdown.html")
      File.open(html_file, 'w+') do |f|
        f.write html
      end
    end
    benchmark.report("redcarpet #{Redcarpet::VERSION}") do
      html = ''
      RUNS.times { html = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(data) }
      html_file = File.join(File.dirname(__FILE__), 'html', "#{File.basename(file).split('.')[0]}_redcarpet.html")
      File.open(html_file, 'w+') do |f|
        f.write html
      end
    end
  end
end
