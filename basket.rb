# frozen_string_literal: true

require './product'
require './delivery_calculator'
require './promo'

class Basket
  attr_accessor :products, :delivery_options

  def initialize(product_catalog:, delivery_options:, offer: nil)
    @product_catalog = product_catalog
    @delivery_options = delivery_options
    @offer = offer

    @product_codes = []
    @products = []

    @total = 0
    @delivery_cost = 4.95
  end

  def add_product(product_code:)
    @product_codes << product_code
  end

  def calcualte_total
    select_products
    @total = total_products_cost
    @total += delivery_cost

    @total = ((@total * 100).floor / 100.0).round(2)

    @total
  end

  private

  def select_products
    @product_codes.each do |product_code|
      @products << @product_catalog.find { |p| p.code == product_code }
    end
  end

  def total_products_cost
    promo_widgets.each_slice(2) do |pair|
      @total += if pair.size == 2
                  apply_promo_price(pair[0].price)
                else
                  pair[0].price
                end
    end

    @total += regular_widgets.map(&:price).sum
  end

  def apply_promo_price(price)
    promo = Promo.new(discount_percent: @offer[:discount].to_i)
    price + promo.apply_discount(price)
  end

  def delivery_cost
    @delivery_options.calculate(@total)
  end

  def promo_widgets
    @products.select { |product| pass_widget_code?(product.code) }
  end

  def regular_widgets
    @products.reject { |product| pass_widget_code?(product.code) }
  end

  def pass_widget_code?(product_code)
    return false if @offer.nil?

    product_code.match(/#{@offer[:code]}\d\d/)
  end
end
