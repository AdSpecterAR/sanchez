require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Users" do
	explanation "Users may open sessions with many developer apps. They can be created by a POST request."

	get "/users" do
		example "Authenticate user" do
			explanation "Currently a placeholder that automatically \"authenticates\""
			do_request

			status.should == 200
		end
	end

	post "/users" do
		example "Create new user" do
			explanation "This method creates a new user."
			do_request

			status.should == 200
		end
	end
end
