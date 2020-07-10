# frozen_string_literal: true

require 'koine/filesystem/version'
require 'koine/filesystem/filesystem'
require 'koine/filesystem/path_sanitizer'
require 'koine/filesystem/adapters/base'
require 'koine/filesystem/adapters/local'

module Koine
  module Filesystem
    class Error < StandardError; end
    class FileNotFound < Error; end
  end
end
