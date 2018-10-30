require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  def current_user
    @current_user ||= FactoryBot.create(:user)  
  end
  describe "#new" do
    context "without signed in user" do
      it "redirects to new session" do
        get :new
        expect(response).to redirect_to(new_session_path)  
      end
    end
    context "with signed in user" do
      before do
        session[:user_id] = current_user.id
        get :new
      end
      it "renders new idea template" do
        expect(response).to render_template(:new)  
      end
      it "saves idea as an instance of Idea" do
        expect(assigns(:idea)).to be_a_new(Idea)
      end
    end
  end
  describe "#create" do
    def valid_request
      post(:create, params: { idea: FactoryBot.attributes_for(:idea)}) 
    end
    context "with out signed in user" do
      it "redirects to new session" do
        valid_request
        expect(response).to redirect_to(new_session_path)  
      end
    end
    context" with signed in user" do
      before do
        session[:user_id] = current_user.id  
      end
      context "with out valid params" do
        before do
          post(:create, params: { idea: FactoryBot.attributes_for(:idea, title: nil)}) 
        end
        it "renders the new idea page" do
          expect(response).to render_template(:new)
        end
        it "stores the invalid idea to an instance of Idea" do
          expect(assigns(:idea)).to be_a(Idea)
        end
      end
      context "with valid params" do
        it "associates idea with user" do
          valid_request
          expect(Idea.last.user).to eq(current_user)  
        end
        it "creates new idea in db" do
          before_count = Idea.count
          valid_request
          after_count = Idea.count
          expect(after_count).to eq(before_count + 1)
        end
        it "redirects to ideas index" do
          valid_request
          idea = Idea.last
          expect(response).to redirect_to(root_path)  
        end
      end
    end
  end
  describe "#show" do
    before do
      @idea = FactoryBot.create(:idea)
      get(:show, params: {id: @idea.id})
    end
    it "renders the selected idea page" do
      expect(response).to render_template(:show)
    end
    it "displays the params for the selected idea" do
      expect(assigns(:idea)).to eq(@idea)
    end
  end
  describe "#index" do
    before do
      idea = FactoryBot.create(:idea)
      get :index
    end
    it "renders the ideas index" do
      expect(response).to render_template(:index)
    end
    it "displays the titles for all the ideas in the db" do
      expect(assigns(:ideas)).to eq(Idea.all)
    end
  end
end
