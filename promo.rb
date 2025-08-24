# frozen_string_literal: true

class Promo
  def initialize(discount_percent:)
    @discount_percent = discount_percent
  end

  def apply_discount(price)
    multiplier = (100 - @discount_percent) / 100.0
    (price * multiplier)
  end
end
