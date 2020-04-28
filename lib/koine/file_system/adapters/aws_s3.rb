# frozen_string_literal: true

require 'aws-sdk-s3'

module Koine
  module FileSystem
    module Adapters
      class AwsS3 < Base
        def initialize(s3_client:, bucket_name:, max_keys: 1000)
          @client = s3_client
          @bucket = bucket_name
          @max_keys = max_keys
        end

        def read(path)
          object(path).body.read
        end

        # @see https://docs.aws.amazon.com/sdk-for-ruby/v2/api/Aws/S3/Client.html#list_objects_v2-instance_method
        def list(path, recursive: false)
          continuation_token = nil

          unless recursive
            # this is not really working
            # https://github.com/thephpleague/flysystem-aws-s3-v3/blob/master/src/AwsS3Adapter.php#L273
            # params[:delimiter] = '/'
            # path = "#{path}/"
          end
          params = { bucket: @bucket, prefix: path, max_keys: @max_keys }

          contents = []

          loop do
            response = request_list(params.merge(continuation_token: continuation_token))
            continuation_token = response.next_continuation_token
            contents += normalized_contents(response.contents)

            unless response.is_truncated
              break
            end
          end

          contents
        end

        private

        # Need to properly set some keys
        def normalized_contents(contents)
          # folders end with /
          contents.map do |content|
            {
              size: content.size,
              path: content.key,
              timestamp: content.last_modified
            }
          end
        end

        def request_list(params)
          @client.list_objects_v2(params.compact)
        end

        def object(key)
          @client.get_object(bucket: @bucket, key: key)
        end
      end
    end
  end
end
