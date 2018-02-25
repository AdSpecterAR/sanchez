require 'rails_helper'

describe AdUnitsController, type: :controller do
  let!(:ad_unit) { create(:ad_unit) }
  let(:ad_unit_params) do
    {
      title: ad_unit.title,
      description: ad_unit.description,
      click_url: ad_unit.click_url,
      ad_unit_url: ad_unit.click_url,
      active: true,
      user_id: ad_unit.user.id
    }
  end

  describe "#create" do
    it "creates a new ad_unit" do
      post :create, params: { ad_unit: ad_unit_params }, format: :json

      expect(response).to be_success
    end
  end

  describe "#default" do
    it "fetches default ad_unit" do
      get :default, format: :json

      expect(response).to be_success
    end
  end
end
