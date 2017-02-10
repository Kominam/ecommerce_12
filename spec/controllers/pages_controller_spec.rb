require "rails_helper"

RSpec.describe PagesController, type: :controller do
  describe "Static pages render:" do
    it "render #home page" do
      get :show, page: "home"
      expect(response).to render_template :home
    end

    it "render #help page" do
      get :show, page: "help"
      expect(response).to render_template :help
    end

    it "render #about page" do
      get :show, page: "about"
      expect(response).to render_template :about
    end

    it "render 404 not found page" do
      get :show, page: "404"
      expect(response).to render_template file: "#{Rails.root}/public/404.html"
    end
  end
end
