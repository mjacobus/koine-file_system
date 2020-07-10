# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::Filesystem do
  it 'has a version number' do
    expect(Koine::Filesystem::VERSION).not_to be nil
  end
end
