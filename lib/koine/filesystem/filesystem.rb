# frozen_string_literal: true

module Koine
  module Filesystem
    # Inspired on
    # https://flysystem.thephpleague.com/v1/docs/usage/filesystem-api/
    class Filesystem
      def initialize(adapter)
        @adapter = adapter
      end

      def read(path, &block)
        @adapter.read(path, &block)
      end

      def read_stream(path, &block)
        @adapter.read_stream(path, &block)
      end

      def write(path, contents, options: {})
        @adapter.write(path, contents, options: options)
      end

      def write_stream(path, contents, options: {})
        @adapter.write_stream(path, contents, options: options)
      end

      def update(path, contents, options: {})
        @adapter.update(path, contents, options: options)
      end

      def update_stream(path, contents, options: {})
        @adapter.update_stream(path, contents, options: options)
      end

      def has?(path)
        @adapter.has?(path)
      end

      def delete(path)
        @adapter.delete(path)
      end

      def read_and_delete(path)
        @adapter.read_and_delete(path)
      end

      def rename(from, to)
        @adapter.rename(from, to)
      end

      def copy(from, to)
        @adapter.copy(from, to)
      end

      def mime_type(path)
        @adapter.mime_type(path)
      end

      def size(path)
        @adapter.size(path)
      end

      def create_dir(path)
        @adapter.create_dir(path)
      end

      def delete_dir(path)
        @adapter.delete_dir(path)
      end

      def list(path, recursive: false)
        @adapter.list(path, recursive: recursive)
      end
    end
  end
end
