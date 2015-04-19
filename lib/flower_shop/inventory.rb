class FlowerShop::Inventory

  attr_accessor :stock

  def initialize *args
    @stock = {}
    args.pop.each do |inv_type|
      @stock[inv_type[:code]] = FlowerShop::Flower.new(inv_type[:name], inv_type[:code], inv_type[:available_bundles])
    end
  end

  def find_flower flower_code
    @stock[flower_code]
  end

end
