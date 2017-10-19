require 'rails_helper'

describe ImpressionsController, type: :controller do
  let(:campaign) { create(:campaign) }
  let(:developer_app) { create(:developer_app) }
  let(:impression_params) do
    {
      impression_started_at: Time.now - 20.seconds,
      impression_ended_at: Time.now,
      campaign_id: "1",                 # TODO: change to variables after migration to MySQL2
      developer_app_id: "1",            # TODO: change to variables after migration to MySQL2
      clicked: false
    }
  end

  describe "#create" do

    it "creates a new impression" do
      post :create, params: { impression: impression_params }, format: :json

      expect(response).to be_success
    end
  end
end
