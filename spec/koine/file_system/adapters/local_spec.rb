# frozen_string_literal: true

require 'spec_helper'
require 'digest'

RSpec.describe Koine::FileSystem::Adapters::Local do
  let(:adapter) { described_class.new(root: FIXTURES_PATH) }

  before do
    system("rm -rf #{FIXTURES_PATH}/sandbox")
  end

  describe '#read' do
    it 'raises when file does not exist' do
      expect do
        adapter.read('unexisting')
      end.to raise_error(
        Koine::FileSystem::FileNotFound,
        'File not found: unexisting'
      )
    end

    it 'returns the content of the file when it exists' do
      contents = adapter.read('sample.txt')

      expected = <<~STR
        This is a sample file
        For local adapter
      STR

      expect(contents).to eq(expected)
    end
  end

  describe '#write' do
    let(:content) do
      <<~STR
        This is a sample file
        For local adapter
      STR
    end

    it 'creates a file' do
      adapter.write('sandbox/foo/bar.txt', content)

      expect(File.read(FIXTURES_PATH + '/sandbox/foo/bar.txt')).to eq(content)
    end

    it 'creates filters malicious files' do
      adapter.write('../../sandbox/../.././../../foo/bar.txt', content)

      expect(File.read(FIXTURES_PATH + '/sandbox/foo/bar.txt')).to eq(content)
    end

    it 'keeps the original file digest' do
      content = adapter.read('sample.txt')
      adapter.write('sandbox/text/sample.txt', content)

      original_content_digest = Digest::SHA1.hexdigest(adapter.read('sample.txt'))
      copy_content_digest = Digest::SHA1.hexdigest(adapter.read('sandbox/text/sample.txt'))

      expect(copy_content_digest).to eq(original_content_digest)
    end

    it 'writes binary file' do
      content = adapter.read('sample.png')
      adapter.write('sandbox/binary/sample.png', content)

      # da39a3ee5e6b4b0d3255bfef95601890afd80709  spec/fixtures/sample.png
      # adc83b19e793491b1c6ea0fd8b46cd9f32e592fc  spec/fixtures/sandbox/binary/sample.png

      original_content_digest = Digest::SHA1.hexdigest(adapter.read('sample.png'))
      copy_content_digest = Digest::SHA1.hexdigest(adapter.read('sandbox/binary/sample.png'))

      expect(copy_content_digest).to eq(original_content_digest)

      original = Digest::SHA1.file("#{FIXTURES_PATH}/sample.png")
      copy = Digest::SHA1.file("#{FIXTURES_PATH}/sandbox/binary/sample.png")

      expect(copy).to eq(original)
    end
  end
end
