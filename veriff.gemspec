# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'veriff/version'

Gem::Specification.new do |spec|
  spec.name          = 'veriff'
  spec.version       = Veriff::VERSION
  spec.authors       = ['Wojtek Widenka']
  spec.email         = ['wojtek@codegarden.online']

  spec.summary       = 'Simple wrapper on Verff.com API'
  spec.description   = 'Simple wrapper on Verff.com API'
  spec.homepage      = 'https://github.com/BankToTheFuture/veriff_ruby'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/BankToTheFuture/veriff_ruby'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.17', '>= 0.17.3'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'timecop', '~> 0.9'
end
