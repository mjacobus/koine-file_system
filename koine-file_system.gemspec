# frozen_string_literal: true

require_relative 'lib/koine/file_system/version'

Gem::Specification.new do |spec|
  spec.name          = 'koine-file_system'
  spec.version       = Koine::FileSystem::VERSION
  spec.authors       = ['Marcelo Jacobus']
  spec.email         = ['marcelo.jacobus@gmail.com']

  spec.summary       = 'File System abstraction'
  spec.description   = 'File System abstraction'
  spec.homepage      = 'https://github.com/mjacobus/koine-file_system'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mjacobus/koine-file_system'
  spec.metadata['changelog_uri'] = 'https://github.com/mjacobus/koine-file_system/blob/CHANGELOG'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
