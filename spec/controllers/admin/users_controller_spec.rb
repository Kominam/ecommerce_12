require "rails_helper"
require "support/controller_helpers"

RSpec.describe Admin::UsersController, type: :controller do
  before :each do
    sign_in FactoryGirl.create :user, role: 0
    @user = FactoryGirl.create :user
    request.env["HTTP_REFERER"] = "sample_path"
  end

  describe "GET #index" do
    it "populates an array of users" do
      user = FactoryGirl.create :user
      get :index
      expect(assigns(:users)).to include user
    end

    it "render template index" do
      get :index
      expect(response).to render_template :index
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "ransack search" do
      get :index, q: "hi"
      expect(controller.params[:q]).to eql "hi"
    end
  end

  describe "PUT #update" do
    it "update user successfully" do
      put :update, id: @user.id, role: "admin"
      @user.reload
      expect(@user.role).to eq("admin")
      expect(flash[:success]). to be_present
    end

    it "update user fail" do
      allow_any_instance_of(User).to receive(:update_attributes).and_return(false)
      put :update, id: @user.id, role: "admin"
      expect(@user.role).to eq("user")
      expect(flash[:danger]). to be_present
    end
  end

  describe "DELETE #destroy" do
    it "delete user successfully" do
      expect{delete :destroy, id: @user.id}.to change(User,:count).by -1
      expect(flash[:success]). to be_present
      expect(response).to redirect_to "sample_path"
    end

    it "delete fail" do
      allow_any_instance_of(User).to receive(:destroy).and_return(false)
      expect{delete :destroy, id: @user.id}.not_to change(User, :count)
      expect(flash[:danger]). to be_present
      expect(response).to redirect_to "sample_path"
    end
  end
end
