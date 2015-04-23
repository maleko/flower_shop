class FlowerShop::Cart

  attr_accessor :items

  def initialize
    @items = {}
  end

  def add_item(flower, required_number_of_flowers)
    @items[flower] = (@items[flower] || []) + flower.select_bundles(required_number_of_flowers)
  end

  def list_items
    @items.each do |flower, bundle_combo|
      if bundle_combo.count > 0
        puts "#{bundle_combo.inject(:+)} #{flower.code} $#{flower.calculate_cost(bundle_combo)}"
        collated_bundles(bundle_combo).each do |bundle_size, number_of_bundles|
          puts "    #{number_of_bundles} X #{bundle_size} $#{flower.available_bundles[bundle_size]}"
        end
      end
    end
  end

  def collated_bundles(bundle_combo)
    bundle_combo.compact.inject({}){ |hash, number| hash[number] = (hash[number] ? hash[number] : 0 )+ 1; hash }
  end

end
