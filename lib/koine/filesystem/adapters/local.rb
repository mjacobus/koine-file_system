# frozen_string_literal: true

require 'fileutils'

module Koine
  module Filesystem
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

        def list(dir = '', recursive: false)
          Dir[create_list_pattern(dir, recursive)].map do |file|
            metadata_for(file)
          end
        end

        def size(path)
          File.size(full_path(path))
        end

        private

        # rubocop:disable Metrics/MethodLength
        def metadata_for(file)
          relative_path = file.sub("#{@root}/", '')
          type = File.directory?(file) ? 'dir' : 'file'
          filename = File.basename(file)

          {
            path: relative_path,
            type: type,
            extension: type == 'dir' ? nil : filename.split('.').last,
            filename: filename,
            dirname: File.dirname(relative_path),
            timestamp: File.mtime(file),
            size: size(relative_path)
          }
        end
        # rubocop:enable Metrics/MethodLength

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

        def create_list_pattern(dir, recursive)
          dir = sanitize_path(dir)
          parts = [@root]

          unless dir.empty?
            parts << dir
          end

          if recursive
            parts << '**'
          end

          parts << '*'
          parts.join('/')
        end
      end
      # rubocop:enable Lint/UnusedMethodArgument
    end
  end
end
