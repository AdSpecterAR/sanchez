require 'rails_helper'

describe ImpressionsController, type: :controller do

  # TODO: clean up verbose associations & reevaluate developer_app, impression, & app_session relationships
  let(:developer_app) { create(:developer_app) }
  let(:app_session) { create(:app_session, developer_app: developer_app) }
  let(:impression) { create(:impression, app_session: app_session, developer_app: developer_app) }
  let(:impression_attribution_params) do
    {
      impression_id: impression.id,
      attribution_partner: "adjust"
    }
  end
  before do
    Timecop.freeze(Time.current)
  end

  def verify_impression_json(json, impression)
    expect(json[:id]).to eql impression.id
    expect(json[:ad_unit][:id]).to eql impression.ad_unit.id
    expect(json[:developer_app_id]).to eql impression.developer_app.id
    expect(json[:app_session][:id]).to eql impression.app_session.id
    expect(json[:served]).to eql impression.served
    expect(json[:shown]).to eql impression.shown
    expect(json[:clicked]).to eql impression.clicked
    expect(json[:installed]).to eql impression.installed
    expect(json[:interaction_length]).to eql impression.interaction_length

    if json[:served_at]
      expect(json[:served_at]).to eql impression.served_at.iso8601(3)
    end

    if json[:shown_at]
      expect(json[:shown_at]).to eql impression.shown_at.iso8601(3)
    end

    if json[:clicked_at]
      expect(json[:clicked_at]).to eql impression.clicked_at.iso8601(3)
    end

    if json[:installed_at]
      expect(json[:installed_at]).to eql impression.installed_at.iso8601(3)
    end
  end

  context "#shown" do
    it "updates impression after ad is shown" do
      put :shown, params: { impression_id: impression.id }, format: :json

      expect(response).to be_success
      response_json = parsed_response_json(response)

      impression.reload

      verify_impression_json(response_json[:impression], impression)
    end
  end

  context "#clicked" do
    it "updates impression after ad is clicked" do
      put :clicked, params: { impression_id: impression.id }, format: :json

      expect(response).to be_success
      response_json = parsed_response_json(response)

      impression.reload

      verify_impression_json(response_json[:impression], impression)
    end
  end

  context "#installed" do
    it "updates impression after ad is installed" do
      put :shown, params: impression_attribution_params, format: :json

      response_json = parsed_response_json(response)

      expect(response).to be_success
      expect(response_json[:response]).to eql "postback received by AdSpecter server"
    end
  end
end
