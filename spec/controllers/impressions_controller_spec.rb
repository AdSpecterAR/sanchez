require 'rails_helper'

describe ImpressionsController, type: :controller do

  # TODO: clean up verbose associations & reevaluate developer_app, impression, & app_session relationships
  let(:developer_app) { create(:developer_app) }
  let(:app_session) { create(:app_session, developer_app: developer_app) }
  let(:impression) { create(:impression, app_session: app_session, developer_app: developer_app) }

  before do
    Timecop.freeze(Time.current)
  end

  def verify_impression_json(json)
    expect(json[:ad_unit][:id]).to eql impression.ad_unit.id
    expect(json[:developer_app][:id]).to eql impression.developer_app.id
    expect(json[:app_session][:id]).to eql impression.app_session.id
    expect(json[:served]).to eql impression.served
    expect(json[:served_at].present?).to eql impression.served_at.present?
    expect(json[:shown]).to eql impression.shown
    expect(json[:shown_at].present?).to eql impression.shown_at.present?
    expect(json[:clicked]).to eql impression.clicked
    expect(json[:clicked_at].present?).to eql impression.clicked_at.present?
  end

  describe "#create" do
    it "creates a new impression" do
      impression_params = {
        ad_unit_id: impression.ad_unit.id,
        developer_app_id: impression.developer_app.id,
        app_session_id: impression.app_session.id,
        served: true,
        served_at: Time.now,
        shown: false,
        shown_at: nil,
        clicked: false,
        clicked_at: nil,
      }

      post :create, params: { impression: impression_params }, format: :json

      expect(response).to be_success

      response_json = parsed_response_json(response)
      verify_impression_json(response_json[:impression])
    end
  end

  context "#update" do
    it "updates impression after ad is shown" do
      impression_params = {
        ad_unit_id: impression.ad_unit.id,
        developer_app_id: impression.developer_app.id,
        app_session_id: impression.app_session.id,
        served: true,
        served_at: Time.now - 1.second,
        shown: true,
        shown_at: Time.now,
        clicked: false,
        clicked_at: nil,
      }

      params = {
        impression: impression_params,
        id: impression.id
      }

      put :update, params: params, format: :json

      expect(response).to be_success
      response_json = parsed_response_json(response)

      impression.reload

      verify_impression_json(response_json[:impression])
    end

    it "updates impression after ad is clicked" do
      impression_params = {
        ad_unit_id: impression.ad_unit.id,
        developer_app_id: impression.developer_app.id,
        app_session_id: impression.app_session.id,
        served: true,
        served_at: Time.now - 2.seconds,
        shown: true,
        shown_at: Time.now - 1.second,
        clicked: true,
        clicked_at: Time.now,
      }

      params = {
        impression: impression_params,
        id: impression.id
      }

      put :update, params: params, format: :json

      impression.reload

      expect(response).to be_success
      response_json = parsed_response_json(response)

      verify_impression_json(response_json[:impression])
    end
  end
end
