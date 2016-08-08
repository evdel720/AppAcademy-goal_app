require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

   let(:jack) { User.create!(username: 'jack_bruce', password: 'abcdef') }

  describe "GET #new" do

    context 'when logged in' do
      before do
        allow(controller).to receive(:current_user) { jack }
      end

      it 'renders new goal page when logged in' do
        get :new
        expect(response).to render_template("new")
      end
    end

    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to new login page' do
        get :new
        expect(response).to redirect_to(new_session_url)
      end
    end

  end

  describe "POST #create" do
   let(:jack) { User.create!(username: 'jack_bruce', password: 'abcdef') }
    before do
      allow(controller).to receive(:current_user) { jack }
    end

    context "with valid params" do
      it 'redirects to the show page' do
        post :create, goal:{title: "Goal Title", details: "Goal Details", goal_private: false, completed: false }
        expect(response).to redirect_to(goal_url(Goal.last))
      end
    end

    context "with invalid params" do
      it 'shows error messages' do
        post :create, goal:{title: "Goal Title", goal_private: false, completed: false }
        expect(flash[:errors]).to be_present
        expect(response).to render_template("new")
      end
    end

    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to new login page' do
        post :create, goal:{title: "Goal Title", details: "Goal Details", goal_private: false, completed: false }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end


  describe "GET #show" do
    let(:jack) { User.create!(username: 'jack_bruce', password: 'abcdef') }
    let(:goal) { FactoryGirl.create(:goal) }

    before do
      allow(controller).to receive(:current_user) { jack }
    end

    context "renders the show page" do
      it 'redirects to the show page' do
        get :show, id: goal.id
        expect(response).to render_template("show")
      end
    end


    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to new login page' do
        get :show, id: goal.id
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "GET #index" do
    let(:jack) { User.create!(username: 'jack_bruce', password: 'abcdef') }
    # let(:goal) { FactoryGirl.create(:goal) }

    before do
      allow(controller).to receive(:current_user) { jack }
    end

    context "renders all goals" do
      it 'redirects to the show page' do
        get :index
        expect(response).to render_template("index")
      end
    end

    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to new login page' do
        get :index
        expect(response).to redirect_to(new_session_url)
      end
    end

  end
end
