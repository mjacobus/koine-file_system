# frozen_string_literal: true

require 'fileutils'

module Koine
  module FileSystem
    module Adapters
      # rubocop:disable Lint/UnusedMethodArgument
      class Local < Base
        def initialize(root:, path_sanitizer: PathSanitizer.new)
          @root = root
          @path_sanitizer = path_sanitizer
        end

        def read(path)
          if has?(path)
            file = File.open(full_path(path), 'rb')
            content = file.read
            file.close
            return content
          end
          raise_not_found(path)
        end

        def has?(path)
          File.exist?(full_path(path))
        end

        def write(path, content, options: {})
          path = full_path(path)
          ensure_target_dir(path)
          File.open(path, 'w') do |f|
            f.write(content)
          end
        end

        private

        def full_path(path)
          File.expand_path(sanitize_path(path), @root)
        end

        def ensure_target_dir(path)
          dir = File.dirname(path)
          unless Dir.exist?(dir)
            FileUtils.mkdir_p(dir)
          end
        end

        def sanitize_path(path)
          @path_sanitizer.sanitize(path)
        end

        # def update(_path, _contents, options: {})
        # def delete(_path)
        # def read_and_delete(_path)
        # def rename(_from, _to)
        # def copy(_from, _to)
        # def mime_type(_path)
        # def size(_path)
        # def create_dir(_path)
        # def delete_dir(_path)
        # def list(_path, recursive: false)
      end
      # rubocop:enable Lint/UnusedMethodArgument
    end
  end
end
