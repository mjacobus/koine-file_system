# frozen_string_literal: true

require_relative './setup'

# This must be required
require 'koine/file_system/adapters/aws_s3'

client = Aws::S3::Client.new(
  region: ENV.fetch('AWS_S3_REGION'),
  credentials: ::Aws::Credentials.new(
    ENV.fetch('AWS_S3_KEY'),
    ENV.fetch('AWS_S3_SECRET')
  )
)

adapter = Koine::FileSystem::Adapters::AwsS3.new(
  s3_client: client,
  bucket_name: ENV.fetch('AWS_S3_BUCKET')
)
filesystem = Koine::FileSystem::FileSystem.new(adapter)

# ap filesystem.read(ENV.fetch('TEST_FILE'))
ap filesystem.list(ENV.fetch('PATH_TO_LIST'))
# ap filesystem.list('')
