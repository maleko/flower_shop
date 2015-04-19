require 'spec_helper'

describe FlowerShop::Inventory do

  let(:inventory) { FlowerShop::Inventory.new(stock) }

  describe ".new" do

    context "only one item" do

      let(:stock) { [ { name: "Rose",   code: "R12", available_bundles: { 5 => 6.99,  10 => 12.99 } } ] }

      it 'has one type of stock' do
        expect(inventory.stock.count).to eql 1
      end

    end

    context "two or more items" do

      let(:stock) { [ { name: "Rose",   code: "R12", available_bundles: { 5 => 6.99,  10 => 12.99 } },
                      { name: "Lilies", code: "L09", available_bundles: { 3 => 9.95,  6 => 16.95,  9 => 24.95 } } ] }

      it 'has two types of stock' do
        expect(inventory.stock.count).to eql 2
      end

    end

  end

  describe "#find_flower" do

    let(:stock) { [ { name: name,   code: code, available_bundles: { 5 => 6.99,  10 => 12.99 } } ] }
    let(:code)  { "R12" }
    let(:name)  { "Rose" }

    subject     { inventory.find_flower(search_code) }

    context "existing flower_code" do

      let(:search_code) { code }

      it 'retrieves the flower' do
        expect(subject.class).to eq FlowerShop::Flower
      end

    end

    context "nonexistent flower_code" do

      let(:search_code) { "TEST" }

      it 'returns nil' do
        expect(subject).to be_nil
      end

    end

  end

end
