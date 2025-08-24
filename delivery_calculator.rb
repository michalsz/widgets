# frozen_string_literal: true

class DeliveryCalculator
  def calculate(total)
    delivery_cost(total)
  end

  private

  def delivery_cost(total)
    return 0 if total > 90

    if total < 50
      4.95
    elsif total < 90
      2.95
    end
  end
end
