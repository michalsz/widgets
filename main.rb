# frozen_string_literal: true

require './product'
require './delivery_calculator'
require './basket'

red_widget = Product.new(name: 'Red Widget',
                         code: 'R01',
                         price: 32.95)
red_widget2 = Product.new(name: 'Red Widget',
                         code: 'R02',
                         price: 32.95)


green_widget = Product.new(name: 'Green Widget',
                           code: 'G01',
                           price: 24.95)

blue_widget = Product.new(name: 'Blue Widget',
                          code: 'B01',
                          price: 7.95)

delivery_calculator = DeliveryCalculator.new
basket1 = Basket.new(product_catalog: [red_widget, green_widget, blue_widget],
                     delivery_options: delivery_calculator,
                     offer: { code: 'R', discount: '50%' })

basket1.add_product(product_code: 'B01')
basket1.add_product(product_code: 'G01')
p basket1.calcualte_total

basket2 = Basket.new(product_catalog: [red_widget, green_widget, blue_widget],
                     delivery_options: delivery_calculator,
                     offer: { code: 'R', discount: '50%' })

basket2.add_product(product_code: 'R01')
basket2.add_product(product_code: 'R01')
p basket2.calcualte_total

basket2a = Basket.new(product_catalog: [red_widget, red_widget2,
                                         green_widget, blue_widget],
                     delivery_options: delivery_calculator,
                     offer: { code: 'R', discount: '50%' })

basket2a.add_product(product_code: 'R01')
basket2a.add_product(product_code: 'R02')
p basket2a.calcualte_total

basket3 = Basket.new(product_catalog: [red_widget, green_widget, blue_widget],
                     delivery_options: delivery_calculator,
                     offer: { code: 'R', discount: '50%' })

basket3.add_product(product_code: 'R01')
basket3.add_product(product_code: 'G01')
p basket3.calcualte_total

basket4 = Basket.new(product_catalog: [red_widget, green_widget, blue_widget],
                     delivery_options: delivery_calculator,
                     offer: { code: 'R', discount: '50%' })

basket4.add_product(product_code: 'B01')
basket4.add_product(product_code: 'B01')
basket4.add_product(product_code: 'R01')
basket4.add_product(product_code: 'R01')
basket4.add_product(product_code: 'R01')
p basket4.calcualte_total
