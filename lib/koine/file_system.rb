# frozen_string_literal: true

require 'koine/file_system/version'
require 'koine/file_system/file_system'
require 'koine/file_system/adapters/base'
require 'koine/file_system/adapters/local'

module Koine
  module FileSystem
    class Error < StandardError; end
  end
end
