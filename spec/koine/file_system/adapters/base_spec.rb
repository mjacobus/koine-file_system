# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::FileSystem::Adapters::Base do
  subject(:adapter) { described_class.new }

  let(:path) { 'foo' }
  let(:contents) { 'bar' }
  let(:options) { {} }
  let(:from) { 'from' }
  let(:to) { 'to' }

  # rubocop:disable RSpec/ExampleLength
  it 'raises on every method' do
    expect do
      adapter.read(path)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.read_stream(path)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.write(path, contents, options: {})
    end.to raise_error(NotImplementedError)

    expect do
      adapter.write_stream(path, contents, options: {})
    end.to raise_error(NotImplementedError)

    expect do
      adapter.update(path, contents, options: {})
    end.to raise_error(NotImplementedError)

    expect do
      adapter.update_stream(path, contents, options: {})
    end.to raise_error(NotImplementedError)

    expect do
      adapter.has?(path)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.delete(path)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.read_and_delete(path)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.rename(from, to)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.copy(from, to)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.mime_type(path)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.size(path)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.create_dir(path)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.delete_dir(path)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.list_contents(path)
    end.to raise_error(NotImplementedError)

    expect do
      adapter.list(path, recursive: false)
    end.to raise_error(NotImplementedError)
  end
  # rubocop:enable RSpec/ExampleLength
end
