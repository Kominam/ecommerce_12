require "rails_helper"
require "support/controller_helpers"

RSpec.describe Admin::ProductsController, type: :controller do
  before :each do
    sign_in FactoryGirl.create :user, role: 0
    category = FactoryGirl.create :category
    @product = FactoryGirl.create :product
    request.env["HTTP_REFERER"] = "sample_path"
  end

  describe "GET #index" do
    it "populates an array of products" do
      product = FactoryGirl.create :product
      get :index
      expect(assigns(:products)).to include product
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

  describe "POST #create" do
    it "create product successfully" do
      product_params = FactoryGirl.attributes_for(:product)
      expect{post :create, product: product_params}.to change(Product, :count).by 1
      expect(flash[:success]). to be_present
      expect(response).to redirect_to "sample_path"
    end

    it "create product fail" do
      product_params = FactoryGirl.attributes_for(:product, name: nil)
      expect{post :create, product: product_params}.to change(Product, :count).by 0
      expect(flash[:danger]). to be_present
      expect(response).to redirect_to "sample_path"
    end
  end

  describe "PUT #update" do
    it "update successfully" do
      product_params = FactoryGirl.attributes_for(:product, name: "hihi")
      put :update, id: @product.slug, product: product_params
      @product.reload
      expect(@product.name).to eq("hihi")
      expect(flash[:success]). to be_present
      expect(response).to redirect_to "sample_path"
    end

    it "update fail" do
      product_params = FactoryGirl.attributes_for(:product, name: nil)
      put :update, id: @product.slug, product: product_params
      expect(flash[:danger]). to be_present
      expect(response).to redirect_to "sample_path"
    end
  end

  describe "DELETE #destroy" do
    it "delete successfully" do
      session[:recent] = []
      session[:recent].push @product.id
      expect{delete :destroy, id: @product.slug}.to change(Product,:count).by -1
      expect(session[:recent]).not_to include @product.id
      expect(flash[:success]). to be_present
      expect(response).to redirect_to "sample_path"
    end

    it "delete fail" do
      allow_any_instance_of(Product).to receive(:destroy).and_return(false)
      expect{delete :destroy, id: @product.slug}.not_to change(Product, :count)
      expect(flash[:danger]). to be_present
      expect(response).to redirect_to "sample_path"
    end
  end

  describe "POST #import" do
    it "import successfully" do
      allow(Product).to receive(:import).with("example.xlsx").and_return(true)
      post :import, file: "example.xlsx"
      expect(flash[:success]).to be_present
      expect(response).to redirect_to admin_products_path
    end

    it "contain exist product" do
      allow(Product).to receive(:import).with("example.xlsx").and_return(false)
      post :import, file: "example.xlsx"
      expect(flash[:danger]).to be_present
      expect(response).to redirect_to admin_products_path
    end

    it "import fail" do
      allow(Product).to receive(:import).with("")
      post :import, file: ""
      expect(flash[:danger]).to be_present
      expect(response).to redirect_to admin_products_path
    end
  end
end
