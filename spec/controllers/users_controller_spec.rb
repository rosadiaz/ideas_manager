require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "renders sign-up template" do
      get :new
      expect(response).to render_template(:new)  
    end
    it "stores user info in an instance of User" do
      get(:new)
      expect(assigns(:user)).to be_a_new(User)
    end
  end
  describe "#create" do
    context "with valid params" do
      it "adds user to db" do
        before_count = User.count
        post(:create, params: {user: FactoryBot.attributes_for(:user)})
        after_count = User.count
        expect(after_count).to eq(before_count + 1)
      end
      it "redirects to ideas index" do
        post(:create, params: {user: FactoryBot.attributes_for(:user)})
        expect(response).to redirect_to(root_path)
      end
      it "stores user id in session"
    end
    context "with invalid params" do
      it "stores input info in an instance of User"  
      it "renders sign up page"
    end
  end

end
