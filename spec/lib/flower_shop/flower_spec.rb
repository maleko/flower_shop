require 'spec_helper'

describe FlowerShop::Flower do

  let(:flower)         { FlowerShop::Flower.new("Orchid", "O100", bundle) }

  describe "#sorted_bundle_sizes" do

    let(:flower)         { FlowerShop::Flower.new("Orchid", "O100", bundle) }
    let(:expected_order) { [15, 9, 4] }

    subject      { flower.sorted_bundle_sizes }

    context "bundle order" do
      let(:bundle) { {9 => "8.00", 4 => "5.00", 15 => "12.00"} }

      it 'returns the bundle sorted' do
        expect(subject).to eql expected_order
      end
    end

    context "bundle order" do
      let(:bundle) { {4 => "5.00", 15 => "12.00", 9 => "8.00"} }

      it 'returns the bundle sorted' do
        expect(subject).to eql expected_order
      end
    end

  end

  describe "#calculate_cost" do

    let(:bundle) { {4 => 5.00, 15 => 12.00, 9 => 8.00} }

    subject      { flower.calculate_cost(required_flowers) }

    context "one small bundle only" do
      let(:required_flowers) { [4] }

      it 'returns the cost' do
        expect(subject).to eq bundle[4]
      end
    end

    context "two bundles of the same size" do
      let(:required_flowers) { [4, 4] }

      it 'returns the cost' do
        expect(subject).to eq( bundle[4] * 2 )
      end
    end

    context "complicated bundles of one each" do
      let(:required_flowers) { [4, 15, 9] }

      it 'returns the cost' do
        expect(subject).to eq( bundle[4] + bundle[15] + bundle[9] )
      end
    end

  end

  describe "#select_bundles" do

    subject { flower.select_bundles(required_flowers) }

    context "simple bundle" do

      let(:bundle) { {4 => 5.00, 15 => 12.00, 9 => 8.00} }

      context "smallest bundle only" do
        let(:required_flowers) { 4 }

        it 'returns the required bundle size' do
          expect(subject).to eq [4]
        end
      end

      context "two of the same bundles" do
        let(:required_flowers) { 8 }

        it 'returns the required bundle size' do
          expect(subject).to eq [4, 4]
        end
      end

      context "complicated bundle" do
        let(:required_flowers) { 24 }

        it 'returns the required bundle size' do
          expect(subject).to eq [15, 9]
        end
      end

      context "too small a bundle" do
        let(:required_flowers) { 3 }

        it 'returns nil' do
          expect(subject).to eq []
        end
      end

      context "unfulfillable bundle" do
        let(:required_flowers) { 5 }

        it 'returns nil' do
          expect(subject).to eq []
        end
      end
    end

  end

end
