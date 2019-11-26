require 'rails_helper'

RSpec.describe Item do
  describe '#create' do

    it "is invalid without a name" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a description" do
      item = build(:item, description: nil)
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    it "is invalid without a condition" do
      item = build(:item, condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("can't be blank")
    end

    it "is invalid without shipment_fee" do
      item = build(:item, shipment_fee: nil)
      item.valid?
      expect(item.errors[:shipment_fee]).to include("can't be blank")
    end

    it "is invalid without shipment_method" do
      item = build(:item, shipment_method: nil)
      item.valid?
      expect(item.errors[:shipment_method]).to include("can't be blank")
    end

    it "is invalid without prefecture_index" do
      item = build(:item, prefecture_index: nil)
      item.valid?
      expect(item.errors[:prefecture_index]).to include("can't be blank")
    end

    it "is invalid without price" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

    it "is invalid without size" do
      item = build(:item, size: nil)
      item.valid?
      expect(item.errors[:size]).to include("can't be blank")
    end
    
  end
end