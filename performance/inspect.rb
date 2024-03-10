# frozen_string_literal: true

require 'rblineprof'
require 'rblineprof-report'
require 'mquve'

files = Dir.glob(File.join(File.dirname(__FILE__), '**', '*.md'))

files.each do |file|
  data = File.read(file)
  profile = lineprof(%r{#{Dir.pwd}/.}) do
    Mquve.to_html(data)
  end
  LineProf.report(profile)
end
