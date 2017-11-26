require 'rails_helper'

describe UsersController, type: :controller do
  let(:new_user_params) do
    {
      first_name: 'John',
      last_name: 'Li',
      account_type: 'Developer',
      email: 'john@adspecter.com',
      password: 'password1'
    }
  end

  describe "#create" do

    it "creates a new user" do
      post :create, params: { user: new_user_params }, format: :json

      expect(response).to be_success
    end
  end
end
