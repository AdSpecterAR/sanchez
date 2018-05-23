require 'rails_helper'

describe Impression, type: :model do
  let(:developer) { create(:user, :developer) }
  let(:advertiser) { create(:user, :advertiser) }
  let(:developer_app) { create(:developer_app, user: developer) }
  let(:ad_unit) { create(:ad_unit, user: advertiser) }
  let(:impression) { create(:impression, ad_unit: ad_unit, developer_app: developer_app) }

  describe "validations" do
    it "should be a valid impression" do
      expect(impression).to be_valid
    end
  end

  describe "#ratio_interacted" do
    it "should return the correct ratio" do
      impression.update(interaction_length: 15000)
      impression.ad_unit.update(video_length: 30000)
      impression.ad_unit.update(rewarded: true)

      expect(impression.ratio_interacted).to eql 0.5
    end
  end


end
