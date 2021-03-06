# frozen_string_literal: true

require 'fileutils'

module Koine
  module Filesystem
    class PathSanitizer
      def sanitize(path)
        path.to_s.gsub('/../', '/').gsub(%r{\.?\./}, '')
      end
    end
  end
end
