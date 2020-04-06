# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::FileSystem::PathSanitizer do
  subject(:sanitizer) { described_class.new }

  describe '#sanitize' do
    SAMPLES = {
      '.././foo/bar/.././../../file.txt' => 'foo/bar/file.txt'
    }.freeze

    SAMPLES.each do |key, value|
      it "transforms #{key} in #{value}" do
        expect(sanitizer.sanitize(key)).to eq(value)
      end
    end
  end
end
