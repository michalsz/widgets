# frozen_string_literal: true

# spec/basket_spec.rb
require 'rspec'
require_relative '../product'
require_relative '../basket'

RSpec.describe Basket do
  let(:delivery_calculator) { DeliveryCalculator.new }

  let(:red)   { Product.new(name: 'Red Widget',   code: 'R01', price: 32.95) }
  let(:green) { Product.new(name: 'Green Widget', code: 'G01', price: 24.95) }
  let(:blue)  { Product.new(name: 'Blue Widget',  code: 'B01', price: 7.95) }

  let(:basket) do
    Basket.new(product_catalog: [red, blue, green],
               delivery_options: delivery_calculator,
               offer: { code: 'R', discount: '50%' })
  end
  before do
    # Default delivery cost stub (could be dynamic if needed)
    # allow(delivery_calculator).to receive(:calculate).and_return(4.95)
  end

  describe '#calcualte_total' do
    context 'when basket has no products' do
      it 'returns just the delivery cost' do
        basket = Basket.new(product_catalog: [], delivery_options: delivery_calculator,
                            offer: { code: 'R', discount: '50%' })
        expect(basket.calcualte_total).to eq(4.95)
      end
    end

    context 'when no offer basket has red widgets only' do
      it 'sums up prices and adds delivery' do
        basket = Basket.new(product_catalog: [red, blue, green],
                            delivery_options: delivery_calculator)
        basket.add_product(product_code: 'R01')
        basket.add_product(product_code: 'R01')
        expect(basket.calcualte_total).to eq(68.85)
      end
    end

    context 'when basket has non-red widgets only' do
      it 'sums up prices and adds delivery' do
        basket.add_product(product_code: 'B01')
        basket.add_product(product_code: 'G01')
        expect(basket.calcualte_total).to eq(37.85)
      end
    end

    context 'when basket has two red widgets' do
      it 'applies buy-one-get-second-half promo' do
        # basket = Basket.new(product_catalog: [red, blue, green], delivery_options: delivery_calculator)
        basket.add_product(product_code: 'R01')
        basket.add_product(product_code: 'R01')
        expected_total = 54.37
        expect(basket.calcualte_total).to eq(expected_total.round(2))
      end
    end

    context 'when basket has one red widget and one green' do
      it 'does not apply promo and sums both with delivery' do
        basket.add_product(product_code: 'R01')
        basket.add_product(product_code: 'G01')
        expected_total = 60.85
        expect(basket.calcualte_total).to eq(expected_total.round(2))
      end
    end

    context 'when basket has three red widgets' do
      it 'applies promo to two and leaves one full price' do
        basket = Basket.new(product_catalog: [red, green, blue],
                            delivery_options: delivery_calculator,
                            offer: { code: 'R', discount: '50%' })

        basket.add_product(product_code: 'B01')
        basket.add_product(product_code: 'B01')
        basket.add_product(product_code: 'R01')
        basket.add_product(product_code: 'R01')
        basket.add_product(product_code: 'R01')
        expected_total = 98.27
        expect(basket.calcualte_total).to eq(expected_total.round(2))
      end
    end
  end
end
