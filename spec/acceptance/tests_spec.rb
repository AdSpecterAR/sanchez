require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Tests" do
	get "/test" do
		example "Test request" do
			do_request

			status.should == 200
		end
	end
end
