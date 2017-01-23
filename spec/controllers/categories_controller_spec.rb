require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  describe "GET #show" do
    subject {FactoryGirl.create :category}

    it "render template show" do
      get :show, id: subject
      expect(response).to render_template :show
    end

    it "responds successfully with an HTTP 200 status code" do
      get :show, id: subject
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "ransack search" do
      get :show, id: subject, q: "valentine"
      expect(controller.params[:q]).to eql "valentine"
    end
  end
end
