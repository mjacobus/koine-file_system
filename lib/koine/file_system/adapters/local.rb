# frozen_string_literal: true

module Koine
  module FileSystem
    module Adapters
      class Local < Base
        def initialize(root:)
          @root = root
        end

        def read(path)
          if has?(path)
            return File.read(full_path(path))
          end

          raise_not_found(path)
        end

        def has?(path)
          File.exist?(full_path(path))
        end

        private

        def full_path(path)
          File.expand_path(path, @root)
        end

        # def read(_path)
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
