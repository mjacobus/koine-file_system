# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::FileSystem do
  it 'has a version number' do
    expect(Koine::FileSystem::VERSION).not_to be nil
  end
end
