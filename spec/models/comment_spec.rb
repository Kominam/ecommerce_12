require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "Comment validation" do
    context "association" do
      it {expect belong_to :user }
      it {expect belong_to :product}
    end

    context "validation" do
      it {is_expected.to validate_presence_of(:content)}
    end

    context "column_specifications" do
      it {expect have_db_column(:content).of_type(:string)}
      it {expect have_db_column(:user_id).of_type(:integer)}
      it {expect have_db_column(:product_id).of_type(:integer)}
    end
  end
end
