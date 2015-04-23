require 'spec_helper'

describe FlowerShop::Cart do

  let(:rose)    { FlowerShop::Flower.new "Roses",   "R12", { 5 => 6.99,  10 => 12.99 } }
  let(:lily)    { FlowerShop::Flower.new "Lilies",  "L09", { 3 => 9.95,  6 => 16.95,  9 => 24.95 } }
  let(:cart)    { FlowerShop::Cart.new }

  describe "#add_item" do

    context "has no existing flowers" do

      let(:required_amount) { 5 }

      it 'adds the flower' do
        cart.add_item rose, required_amount
        expect(cart.items[rose]).to eql [required_amount]
      end

      it "doesn't have flowers that are not added" do
        expect(cart.items[lily]).to be_nil
      end

    end

    context "has existing flowers in cart" do

      let(:required_amount) { 5 }
      let(:existing_amount) { 5 }

      context "has different flowers" do

        before do
          cart.items[lily] = [3, 6]
          cart.add_item rose, required_amount
        end

        it 'just adds the new flower' do
          expect(cart.items.count).to eq 2
        end

        it 'lists both flowers' do
          expect(cart.items[rose]).to eql [required_amount]
        end

      end

      context "has same flowers" do

        before do
          cart.items[rose] = [existing_amount]
          cart.add_item rose, required_amount
        end

        it 'adds to the existing rose' do
          expect(cart.items.count).to eq 1
        end

        it 'would add to the existing bundles' do
          expect(cart.items[rose]).to eq [existing_amount, required_amount]
        end

      end

    end

  end

  describe "#collated_bundles" do

    subject { cart.collated_bundles(bundle_combo) }

    context "screwed up null combo" do

      let(:bundle_combo) { [nil, nil, 4, 5] }

      it 'returns only two combos' do
        expect(subject).to eql({ 4 => 1, 5 => 1 })
      end

    end

    context "unique bundles" do

      let(:bundle_combo) { [4, 5, 6] }

      it 'returns all combos' do
        expect(subject).to eql({ 4 => 1, 5 => 1, 6 => 1 })
      end

    end

    context "repeated bundles" do

      let(:bundle_combo) { [4, 4, 5] }

      it 'returns the two combos and their quantities' do
        expect(subject).to eql({ 4 => 2, 5 => 1 })
      end

    end

  end


end
