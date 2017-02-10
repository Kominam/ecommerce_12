require "rails_helper"

RSpec.describe Suggest, type: :model do
  describe "suggests validation" do
    context "association" do
      it {expect belong_to(:user)}
    end

    context "validation" do
      it {is_expected.to validate_presence_of(:title)}
    end

    context "column_specifications" do
      it {expect have_db_column(:title).of_type(:string)}
      it {expect have_db_column(:content).of_type(:string)}
      it {expect have_db_column(:user_id).of_type(:integer)}
      it {expect have_db_column(:status).of_type(:integer)}
      it {expect have_db_column(:category_id).of_type(:integer)}
    end
  end

  it "init suggest status" do
    suggest = FactoryGirl.create :suggest
    expect(suggest.status).to eql "processing"
  end
end
