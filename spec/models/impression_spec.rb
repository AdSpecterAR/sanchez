require 'rails_helper'

describe Impression, type: :model do
  let(:developer) { create(:user, :developer) }
  let(:advertiser) { create(:user, :advertiser) }
  let(:developer_app) { create(:developer_app, user: developer) }
  let(:campaign) { create(:campaign, user: advertiser) }
  let(:impression) { create(:impression, campaign: campaign, developer_app: developer_app) }

  describe "validations" do
    it "should be a valid impression" do
      expect(impression).to be_valid
    end
  end
end
