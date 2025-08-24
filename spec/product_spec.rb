# frozen_string_literal: true

# spec/product_spec.rb
require 'rspec'
require_relative '../product'

RSpec.describe Product do
  let(:product) { described_class.new(name: 'Red Widget', price: 32.95, code: 'R01') }

  describe '#initialize' do
    it 'sets the name' do
      expect(product.name).to eq('Red Widget')
    end

    it 'sets the price' do
      expect(product.price).to eq(32.95)
    end

    it 'sets the code' do
      expect(product.code).to eq('R01')
    end
  end

  describe 'attribute accessors' do
    it 'allows updating the name' do
      product.name = 'Blue Widget'
      expect(product.name).to eq('Blue Widget')
    end

    it 'allows updating the price' do
      product.price = 25.50
      expect(product.price).to eq(25.50)
    end

    it 'allows updating the code' do
      product.code = 'B01'
      expect(product.code).to eq('B01')
    end
  end
end
