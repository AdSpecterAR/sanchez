require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Users" do
	explanation "Users may open sessions with many developer apps. They can be created by a POST request."

	let(:new_user_params) do
    {
      first_name: 'John',
      last_name: 'Li',
      account_type: 'Developer',
      email: 'john@adspecter.com',
      password: 'password1'
    }
  end


	get "/users" do
		example "Authenticate user" do
			explanation "Currently a placeholder that automatically \"authenticates\""
			do_request

			status.should == 200
		end
	end

	post "/users" do
    parameter :user, "New user", :required => true
    parameter :first_name, "First name", :scope => :user
    parameter :last_name, "Last name", :scope => :user
    parameter :account_type, "Developer or Advertiser", :scope => :user
    parameter :email, "Email account", :scope => :user
    parameter :password, "Password", :scope => :user


		example "Create new user" do
			explanation "This method creates a new user."
			do_request(:user => new_user_params)

			status.should == 200
		end
	end
end
