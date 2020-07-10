# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::Filesystem::PathSanitizer do
  subject(:sanitizer) { described_class.new }

  describe '#sanitize' do
    {
      '.././foo/bar/.././../../file.txt' => 'foo/bar/file.txt'
    }.each do |key, value|
      it "transforms #{key} in #{value}" do
        expect(sanitizer.sanitize(key)).to eq(value)
      end
    end
  end
end
