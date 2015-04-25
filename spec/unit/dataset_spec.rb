require 'spec_helper'

describe ROM::CSV::Dataset do
  let(:data) { [{ id: 1 }, { id: 2 }] }
  let(:dataset) { ROM::CSV::Dataset.new(double(ROM::CSV::Connection), data) }

  describe '#each' do
    it 'returns hash elements' do
      dataset.each do |tuple|
        expect(tuple).to be_a(Hash)
      end
    end
  end

  describe '#to_a' do
    it 'returns array with hash elements' do
      result = dataset.to_a
      expect(result).to eql(data)
    end
  end

  describe '#first' do
    it 'returns hash element' do
      result = dataset.first
      expect(result).to eql(data.first)
    end
  end
end
