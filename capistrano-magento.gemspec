##
# Copyright © 2019 by Itonomy B.V. All rights reserved
#
# Licensed under the MIT Licence (MIT)
# See included LICENSE file for full text of MIT
#
# https://itonomy.nl
##
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/magento/version'

Gem::Specification.new do |gem|
  gem.name          = "capistrano-magento"
  gem.version       = Capistrano::Magento::VERSION
  gem.authors       = ["Robin Rijkeboer"]
  gem.email         = ["robin.rijkeboer@itonomy.nl"]
  gem.description   = %q{Magento specific tasks for Capistrano}
  gem.summary       = %q{Magento specific tasks for Capistrano}
  gem.homepage      = "http://github.com/itonomy/capistrano-magento1"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "capistrano", "~> 3.1"

  gem.add_development_dependency 'bundler', '~> 1.7'
  gem.add_development_dependency 'rake', '~> 10.0'
end
