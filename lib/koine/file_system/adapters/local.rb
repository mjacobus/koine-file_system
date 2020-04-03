# frozen_string_literal: true

require 'fileutils'

module Koine
  module FileSystem
    module Adapters
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
            # return File.read(full_path(path))
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
            f.puts(content)
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

        # def read_stream(_path)
        # def write(_path, _contents, options: {})
        # def write_stream(_path, _contents, options: {})
        # def update(_path, _contents, options: {})
        # def update_stream(_path, _contents, options: {})
        # def has?(_path)
        # def delete(_path)
        # def read_and_delete(_path)
        # def rename(_from, _to)
        # def copy(_from, _to)
        # def mime_type(_path)
        # def size(_path)
        # def create_dir(_path)
        # def delete_dir(_path)
        # def list_contents(_path)
        # def list(_path, recursive: false)
      end
    end
  end
end
