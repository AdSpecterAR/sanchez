require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Impressions" do
  explanation "Within an app session many advertisements may be served, each advertisement of which may receive multiple impressions.\nImpressions may be received, shown, and or clicked."

  let(:developer_app) { create(:developer_app) }
  let(:app_session) { create(:app_session, developer_app: developer_app) }
  let(:impression) { create(:impression, app_session: app_session, developer_app: developer_app) }
  let(:impression_params) do
    {
      ad_unit_id: impression.ad_unit.id,
      developer_app_id: impression.developer_app.id,
      app_session_id: impression.app_session.id,
      served: true,
      served_at: Time.now,
      shown: false,
      shown_at: nil,
      clicked: false,
      clicked_at: nil
    }
  end
	
  post "/impressions" do
    parameter :impression, "Impression", :required => true
    parameter :ad_unit_id, "Ad unit", :scope => :impression
    parameter :developer_app_id, "Developer App Id", :scope => :impression
    parameter :app_session_id, "App Session Id", :scope => :impression
    parameter :served, "Whether ad has been served", :scope => :impression
    parameter :served_at, "When ad was served", :scope => :impression
    parameter :shown, "Whether ad has been shown", :scope => :impression
    parameter :show_at, "When ad was shown", :scope => :impression
    parameter :clicked, "Whether ad was clicked", :scope => :impression
    parameter :clicked_at, "When ad was clicked", :scope => :impression

    example "Creates a new impression" do
      explanation "This method creates a new impression."
      do_request(:impression => impression_params)

      status.should == 200
    end
  end

  put "/impressions" do
    parameter :impression, "Impression", :required => true
    parameter :ad_unit_id, "Ad unit", :scope => :impression
    parameter :developer_app_id, "Developer App Id", :scope => :impression
    parameter :app_session_id, "App Session Id", :scope => :impression
    parameter :served, "Whether ad has been served", :scope => :impression
    parameter :served_at, "When ad was served", :scope => :impression
    parameter :shown, "Whether ad has been shown", :scope => :impression
    parameter :show_at, "When ad was shown", :scope => :impression
    parameter :clicked, "Whether ad was clicked", :scope => :impression
    parameter :clicked_at, "When ad was clicked", :scope => :impression

    example "Creates a new impression" do
      explanation "This method creates a new impression."
      do_request(:impression => impression_params)

      status.should == 200
    end
  end
end
