require 'rails_helper'

RSpec.describe user, type: :model do
  describe '#create' do

    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(uiser.errors[:nickname]).to include("can't be blank")
