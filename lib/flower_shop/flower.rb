class FlowerShop::Flower

  attr_accessor :name, :code, :available_bundles

  def initialize name, code, available_bundles
    @name              = name
    @code              = code
    @available_bundles = available_bundles
  end

  def sorted_bundle_sizes
    @sorted_bundle_sizes ||= available_bundles.keys.sort{ |a,b| b<=> a }
  end

  def calculate_cost(bundles)
    "%.2f" % (bundles.inject(0) { |sum, bundle| sum += available_bundles[bundle] })
  end

  # http://rubyquiz.com/quiz154.html
  def select_bundles(flowers_required)
     optimum_combo = Hash.new do |hash, key|
       hash[key] = if key < sorted_bundle_sizes.min
         []
       elsif sorted_bundle_sizes.include?(key)
         [key]
       else
         sorted_bundle_sizes.
           # prune unhelpful bundles
           reject { |bundle| bundle > key }.

           # prune bundles that are factors of larger bundles
           inject([]) {|mem, var| mem.any? {|c| c%var == 0} ? mem : mem+[var]}.

           # recurse
           map { |bundle| [bundle] + hash[key - bundle] }.

           # prune unhelpful solutions
           reject { |bundle| bundle.inject(:+) != key }.

           # pick the smallest, empty if none
           min { |a, b| a.size <=> b.size } || []
       end
     end
     optimum_combo[flowers_required]
  end

end
