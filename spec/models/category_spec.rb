require "rails_helper"

RSpec.describe Category, type: :model do
  describe "Category attritubtes" do
    context "column" do
      it {should have_db_column(:name).of_type(:string)}
      it {should have_db_column(:description).of_type(:string)}
      it {should have_db_column(:depth).of_type(:integer)}
      it {should have_db_column(:lft).of_type(:integer)}
      it {should have_db_column(:rgt).of_type(:integer)}
    end
  end

  describe "validations" do
    context "association" do
      it {is_expected.to have_many :products}
      it {is_expected.to have_many :suggests}
    end
  end

  describe "category instance method" do
    subject{FactoryGirl.create :category}

    it ".leaf?" do
      expect(subject.is_leaf?).to be false
    end

    it ".delete_category" do
      expect(subject.delete_category).to be_an Integer
    end

    it ".update_category" do
      expect(subject.update_category "1").to be true
    end

    it ".update greater than parent category" do
      expect(subject.update_category "").to be true
    end
  end
end
