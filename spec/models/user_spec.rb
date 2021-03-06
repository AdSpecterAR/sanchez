require 'rails_helper'

describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it "should be valid" do
      expect(user).to be_valid
    end

    it "should not be valid without a first name" do
      user.update(first_name: nil)

      expect(user).not_to be_valid
    end

    it "should not be valid without a last name" do
      user.update(last_name: nil)

      expect(user).not_to be_valid
    end

    it "should not be valid without the correct email format" do
      user.update(email: "john@adspectercom")

      expect(user).not_to be_valid
    end
  end
end
