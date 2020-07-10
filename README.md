# Koine::Filesystem

This will [hopefully] be a file system abstraction as good as the [PHP League's Flysystem](https://github.com/thephpleague/flysystem).

[![Build Status](https://travis-ci.org/mjacobus/koine-file_system.svg?branch=master)](https://travis-ci.org/mjacobus/koine-file_system)
[![Coverage Status](https://coveralls.io/repos/github/mjacobus/koine-file_system/badge.svg?branch=master)](https://coveralls.io/github/mjacobus/koine-file_system?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/ae41e3facbadaabaa463/maintainability)](https://codeclimate.com/github/mjacobus/koine-file_system/maintainability)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'koine-filesystem'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install koine-filesystem


## Usage

```ruby
adapter = Koine::Filesystem::Adapters::Local.new(
  root: '/users/my_user/sandbox'
)

fs = Koine::Filesystem::Filesystem.new(adapter)

files = fs.list('files', recursive: true)

# it returns a collectin of hash. But I am thingking of either returning a PORO file object
# or returning an object that carries the file system along with it so it can do stuff like

files.each do |file|
  file.directory?
  file.path
  file.name
  file.extension
  file.read
  file.read_stream
  file.upload_to(other_fs, path: 'foo/bar/baz.txt')
end

```

## [Partially] Supported adapters

- Local
- [Sftp](https://github.com/mjacobus/koine-filesystem-adapters-sftp)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mjacobus/koine-file_system. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/mjacobus/koine-file_system/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Koine::Filesystem project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mjacobus/koine-file_system/blob/master/CODE_OF_CONDUCT.md).
