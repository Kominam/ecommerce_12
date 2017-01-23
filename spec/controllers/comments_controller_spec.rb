require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  before :each do
    category = FactoryGirl.create :category
    sign_in FactoryGirl.create :user
    @product = FactoryGirl.create :product
  end

  describe "POST #create" do
    it "condition required" do
      post :create, {product_id: @product.slug, comment: {content: "Lorems"}}
    end

    it "create comment successful" do
      expect{
        post :create, product_id: @product.slug,
          comment: {content: "first comment"}
      }.to change(Comment, :count).by 1
    end

    it "create fail if blank content" do
      expect{
        post :create, product_id: @product.slug, comment: {content: ""}
      }.to change(Comment, :count).by 0
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @comment = FactoryGirl.create :comment
    end

    it "delete comment successful" do
      expect{
        delete :destroy, product_id: @product.id, id: @comment.id
      }.to change(Comment, :count).by -1
    end
  end
end
