# frozen_string_literal: true

class Product
  attr_accessor :name, :code, :price

  def initialize(name:, price:, code:)
    @name = name
    @price = price
    @code = code
  end
end
