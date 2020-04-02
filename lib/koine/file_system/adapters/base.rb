# frozen_string_literal: true

module Koine
  module FileSystem
    module Adapters
      # rubocop:disable Lint/UnusedMethodArgument
      class Base
        def read(_path)
          raise NotImplementedError
        end

        def read_stream(_path)
          raise NotImplementedError
        end

        def write(_path, _contents, options: {})
          raise NotImplementedError
        end

        def write_stream(_path, _contents, options: {})
          raise NotImplementedError
        end

        def update(_path, _contents, options: {})
          raise NotImplementedError
        end

        def update_stream(_path, _contents, options: {})
          raise NotImplementedError
        end

        def has?(_path)
          raise NotImplementedError
        end

        def delete(_path)
          raise NotImplementedError
        end

        def read_and_delete(_path)
          raise NotImplementedError
        end

        def rename(_from, _to)
          raise NotImplementedError
        end

        def copy(_from, _to)
          raise NotImplementedError
        end

        def mime_type(_path)
          raise NotImplementedError
        end

        def size(_path)
          raise NotImplementedError
        end

        def create_dir(_path)
          raise NotImplementedError
        end

        def delete_dir(_path)
          raise NotImplementedError
        end

        def list_contents(_path)
          raise NotImplementedError
        end

        def list(_path, recursive: false)
          raise NotImplementedError
        end

        private

        def raise_not_found(file)
          raise FileNotFound, "File not found: #{file}"
        end
      end
      # rubocop:enable Lint/UnusedMethodArgument
    end
  end
end
