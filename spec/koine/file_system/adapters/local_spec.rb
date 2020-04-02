# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::FileSystem::Adapters::Local do
  let(:adapter) { described_class.new(root: FIXTURES_PATH) }

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
end
