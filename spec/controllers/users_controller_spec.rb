require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it 'renders sign up page' do
      get :new
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "redirects to somewhere.."

      it "signs user in and sets sesison token" do
        post :create, user: {username: "Something", password: "password"}
        expect(session[:session_token]).to eq(User.last.session_token)
      end
    end

    context "with invalid params" do

      it "renders new page" do
        post :create, user: {username: "Something", password: "pass"}
        expect(response).to render_template("new")
      end

      it "has errors" do
        post :create, user: {username: "Something", password: "pass"}
        expect(flash[:errors]).to be_present
      end

    end
  end
end
