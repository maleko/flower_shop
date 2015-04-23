#
# This is the main file for the FlowerShop application.  It expects to be called:
#
#   FlowerShop.application.run
#

require 'highline'
require 'awesome_print'
require 'flower_shop/flower'
require 'flower_shop/inventory'
require 'flower_shop/cart'

module FlowerShop

  class << self

    def application
      @application ||= FlowerShop::Application.new
    end

  end

  class Application

    def initialize
      puts "Initialising Stock....."

      @inventory = FlowerShop::Inventory.new([
        { name: "Rose",   code: "R12", available_bundles: { 5 => 6.99,  10 => 12.99 } },
        { name: "Lilies", code: "L09", available_bundles: { 3 => 9.95,  6 => 16.95,  9 => 24.95 } },
        { name: "Tulips", code: "T58", available_bundles: { 3 => 5.95,  5 => 9.95,   9 => 16.99 } },
      ])

      @cart      = FlowerShop::Cart.new
    end

    def process_order(input)
      input.split("\n").each do |line_item|
        process_item line_item.split(' ')
      end
    end

    def process_item(params)
      required_number_of_flowers  = params[0]
      flower_code                 = params[1]
      if flower_code
        flower = @inventory.find_flower flower_code
        @cart.add_item flower, required_number_of_flowers.to_i if flower
      end
    end

    def list_cart
      @cart.list_items
    end

  end

end

flower_shop = FlowerShop::Application.new

puts "🎴🌻  Welcome to the Flower Shop! 🌻 🎴"
puts "Enter your order below. Please separate each line item with a new line"
puts "The required format is {Quantity} {Flower Code}"
puts "Complete the order with a 'END'"
$/ = "END"
user_input = STDIN.gets
items_required = user_input.gsub("END", "")
puts "\n"
flower_shop.process_order items_required

flower_shop.list_cart


