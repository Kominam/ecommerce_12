require "rails_helper"
require "support/controller_helpers"

RSpec.describe Admin::SuggestsController, type: :controller do
  before :each do
    sign_in FactoryGirl.create(:user, role: 0)
  end

  describe "GET #index" do
    it "populates an array of suggests" do
      suggest = FactoryGirl.create :suggest
      get :index
      expect(assigns(:suggests)).to eq([suggest])
    end

    it "render template index" do
      get :index
      expect(response).to render_template :index
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "ransack search" do
      get :index, q: "hi"
      expect(controller.params[:q]).to eql "hi"
    end
  end

  describe "PUT #update" do
    before :each do
      @suggest = FactoryGirl.create :suggest
      request.env["HTTP_REFERER"] = "sample_path"
    end

    it "update suggest successfully" do
      put :update, id: @suggest.id, status: :accepted
      @suggest.reload
      expect(@suggest.status).to eq("accepted")
      expect(flash[:success]). to be_present
      expect(response).to redirect_to "sample_path"
    end

    it "update suggest fail" do
      allow_any_instance_of(Suggest).to receive(:update_attributes).and_return(false)
      put :update, id: @suggest.id, status: :accepted
      expect(@suggest.status).to eq("processing")
      expect(flash[:notice]). to be_present
      expect(response).to redirect_to "sample_path"
    end
  end
end
