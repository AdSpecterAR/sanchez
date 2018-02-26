require 'rails_helper'

describe DeveloperApp, type: :model do
  let(:developer_app) { create(:developer_app) }

  describe "validations" do
    it "should create a valid developer app" do
      expect(developer_app).to be_valid
    end

    it "should not be valid without a name" do
      developer_app.name = nil

      expect(developer_app).not_to be_valid
    end

    it "should not be valid without a valid platform" do
      developer_app.platform = 'blackberry'

      expect(developer_app).not_to be_valid
    end
  end
end
