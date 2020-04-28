# frozen_string_literal: true

module Koine
  module FileSystem
    module Adapters
      # rubocop:disable Lint/UnusedMethodArgument
      class Base
        # @param path [String]  path
        #
        # @return string
        #
        # @raise [FileNotFound] when file does not exist or cannot be read
        def read(path)
          raise NotImplementedError
        end

        # @param path [String]  path
        #
        # @return Boolean
        #
        # @raise [FileNotFound] when file does not exist or cannot be read
        def read_stream(path)
          raise NotImplementedError
        end

        # @param path [String]  path
        # @param contents [String] the content
        # @param options [<Hash>] the options
        #
        # @return [void]
        def write(path, contents, options: {})
          raise NotImplementedError
        end

        # @param path [String]  path
        # @param contents [String] the content
        # @param options [<Hash>] the options
        #
        # @return [void]
        def write_stream(path, contents, options: {})
          raise NotImplementedError
        end

        # @param path [String]  path
        # @param contents [String] the new content
        # @param options [<Hash>] the options
        #
        # @return [void]
        #
        # @raise [FileNotFound] when file does not exist or cannot be read
        def update(path, contents, options: {})
          raise NotImplementedError
        end

        # @param path [String]  path
        # @param contents [String] the new content
        # @param options [<Hash>] the options
        #
        # @return [void]
        #
        # @raise [FileNotFound] when file does not exist or cannot be read
        def update_stream(path, contents, options: {})
          raise NotImplementedError
        end

        # @param path [String]  path
        #
        # @return Boolean
        def has?(path)
          raise NotImplementedError
        end

        # @param path [String]  path
        #
        # @return [void]
        #
        # @raise [FileNotFound] when file does not exist or cannot be read
        def delete(path)
          raise NotImplementedError
        end

        # @param path [String]  path
        #
        # @return [String]
        #
        # @raise [FileNotFound] when file does not exist or cannot be read
        def read_and_delete(path)
          raise NotImplementedError
        end

        # @param from [String]  path
        # @param to [String]  path
        #
        # @return [void]
        #
        # @raise [FileNotFound] when source file does not exist or cannot be read
        def rename(from, to)
          raise NotImplementedError
        end

        # @param from [String]  path
        # @param to [String]  path
        #
        # @return [void]
        #
        # @raise [FileNotFound] when source file does not exist or cannot be read
        def copy(from, to)
          raise NotImplementedError
        end

        # @param path [String]  path
        #
        # @return [String]
        #
        # @raise [FileNotFound] when source file does not exist or cannot be read
        def mime_type(path)
          raise NotImplementedError
        end

        # @param path [String]  path
        #
        # @return [Integer] Number of bytes
        #
        # @raise [FileNotFound] when file does not exist or cannot be read
        def size(path)
          raise NotImplementedError
        end

        # @param path [String]  path
        #
        # @return [void]
        def create_dir(path)
          raise NotImplementedError
        end

        # @param path [String]  path
        #
        # @return [void]
        def delete_dir(path)
          raise NotImplementedError
        end

        # @param path [String]  path
        # @param recursive [Bool]  path
        #
        # @return [void]
        def list(path, recursive: false)
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
