# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::Filesystem::Filesystem do
  subject(:fs) { described_class.new(adapter) }

  let(:adapter) { instance_double(described_class) }

  it 'delegates #read to adapter' do
    stub(:read, 'path').and_return('foo')

    expect(fs.read('path')).to eq('foo')
  end

  it 'delegates #read_stream to adapter' do
    stub(:read_stream, 'path').and_return('foo')

    expect(fs.read_stream('path')).to eq('foo')
  end

  it 'delegates #write to adapter' do
    stub(:write, 'path', 'content', options: 'the-options').and_return('foo')

    expect(fs.write('path', 'content', options: 'the-options')).to eq('foo')
  end

  it 'delegates #write_stream to adapter' do
    stub(:write_stream, 'path', 'content', options: 'the-options').and_return('foo')

    expect(fs.write_stream('path', 'content', options: 'the-options')).to eq('foo')
  end

  it 'delegates #update to adapter' do
    stub(:update, 'path', 'content', options: 'the-options').and_return('foo')

    expect(fs.update('path', 'content', options: 'the-options')).to eq('foo')
  end

  it 'delegates #update_stream to adapter' do
    stub(:update_stream, 'path', 'content', options: 'the-options').and_return('foo')

    expect(fs.update_stream('path', 'content', options: 'the-options')).to eq('foo')
  end

  it 'delegates #has to adapter' do
    stub(:has?, 'path').and_return('foo')

    expect(fs.has?('path')).to eq('foo')
  end

  it 'delegates #delete to adapter' do
    stub(:delete, 'path').and_return('foo')

    expect(fs.delete('path')).to eq('foo')
  end

  it 'delegates #read_and_delete to adapter' do
    stub(:read_and_delete, 'path').and_return('foo')

    expect(fs.read_and_delete('path')).to eq('foo')
  end

  it 'delegates #rename to adapter' do
    stub(:rename, 'foo', 'bar').and_return('baz')

    expect(fs.rename('foo', 'bar')).to eq('baz')
  end

  it 'delegates #copy to adapter' do
    stub(:copy, 'foo', 'bar').and_return('baz')

    expect(fs.copy('foo', 'bar')).to eq('baz')
  end

  it 'delegates #mime_type to adapter' do
    stub(:mime_type, 'path').and_return('foo')

    expect(fs.mime_type('path')).to eq('foo')
  end

  it 'delegates #size to adapter' do
    stub(:size, 'path').and_return('foo')

    expect(fs.size('path')).to eq('foo')
  end

  it 'delegates #create_dir to adapter' do
    stub(:create_dir, 'path').and_return('foo')

    expect(fs.create_dir('path')).to eq('foo')
  end

  it 'delegates #delete_dir to adapter' do
    stub(:delete_dir, 'path').and_return('foo')

    expect(fs.delete_dir('path')).to eq('foo')
  end

  it 'delegates #list to adapter' do
    stub(:list, 'path', recursive: 'r').and_return('foo')

    expect(fs.list('path', recursive: 'r')).to eq('foo')
  end

  private

  def stub(*args)
    method = args.shift

    allow(adapter).to receive(method).with(*args)
  end
end
