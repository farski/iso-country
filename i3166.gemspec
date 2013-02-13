# -*- encoding: utf-8 -*-
require File.expand_path('../lib/i3166/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Chris Kalafarski']
  gem.email         = ['chris@farski.com']
  gem.description   = %q{A standard way of handling country data}
  gem.summary       = %q{A standard way of handling country data}
  gem.homepage      = 'https://github.com/farski/iso-country'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'i3166'
  gem.require_paths = ['lib']
  gem.version       = Iso::I3166::VERSION
end
