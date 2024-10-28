# frozen_string_literal: true

source "https://rubygems.org"

gemspec
gem "jekyll"

group :jekyll_plugins do
  # # 2024-06-04
  # # https://github.com/keithmifsud/jekyll-target-blank
  # # führt leider zu einem Fehler
  # gem 'jekyll-target-blank'
  gem 'jekyll-asciidoc'
  gem 'asciidoctor-diagram'
end

gem 'asciidoctor'
gem 'coderay'

# Diese Inhalte werden erstellt, wenn man eine ganz neue default site mit Jekyll erstellt:

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
# do not have a Java counterpart.
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]

gem "webrick", "~> 1.8"
