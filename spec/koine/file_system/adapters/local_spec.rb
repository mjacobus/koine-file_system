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

  describe '#list' do
    let(:adapter) { described_class.new(root: "#{FIXTURES_PATH}/list_sandbox/") }

    it 'lists primary contents without args' do
      result = adapter.list

      paths = result.map { |r| r[:path] }.sort

      expect(paths).to eq(['folder1', 'sample.png', 'sample.txt'].sort)
    end

    it 'lists folder contents without recursion' do
      result = adapter.list('folder1')

      paths = result.map { |r| r[:path] }.sort

      expect(paths).to eq(['folder1/folder2', 'folder1/sample.png'].sort)
    end

    it 'lists folder contents with recursion' do
      result = adapter.list('folder1', recursive: true)

      paths = result.map { |r| r[:path] }.sort

      expect(paths).to eq([
        'folder1/folder2',
        'folder1/sample.png',
        'folder1/folder2/sample.txt'
      ].sort)
    end

    it 'returns type' do
      result = adapter.list

      map = result.map { |r| [r[:path], r[:type]] }.sort

      expected = [
        %w[folder1 dir],
        ['sample.png', 'file'],
        ['sample.txt', 'file']
      ].sort

      expect(map).to eq(expected)
    end

    it 'returns extensions' do
      result = adapter.list

      map = result.map { |r| [r[:path], r[:extension]] }.sort

      expected = [
        ['folder1', nil],
        ['sample.png', 'png'],
        ['sample.txt', 'txt']
      ].sort

      expect(map).to eq(expected)
    end

    it 'returns filenames' do
      result = adapter.list('folder1')

      map = result.map { |r| [r[:path], r[:filename]] }.sort

      expected = [
        ['folder1/folder2', 'folder2'],
        ['folder1/sample.png', 'sample.png']
      ].sort

      expect(map).to eq(expected)
    end

    it 'returns dirname' do
      result = adapter.list('folder1')

      map = result.map { |r| [r[:path], r[:dirname]] }.sort

      expected = [
        ['folder1/folder2', 'folder1'],
        ['folder1/sample.png', 'folder1']
      ].sort

      expect(map).to eq(expected)
    end

    it 'returns file sizes' do
      result = adapter.list

      map = result.map { |r| [r[:path], r[:size]] }.sort

      expected = [
        ['folder1', 4096],
        ['sample.png', 85_874],
        ['sample.txt', 40]
      ].sort

      expect(map).to eq(expected)
    end

    it 'returns file timestamps' do
      result = adapter.list

      map = result.map { |r| [r[:path], r[:timestamp].class.to_s] }.sort

      expected = [
        ['folder1', 'Time'],
        ['sample.png', 'Time'],
        ['sample.txt', 'Time']
      ].sort

      expect(map).to eq(expected)
    end
  end
end
