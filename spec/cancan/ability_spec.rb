require "rails_helper"
require "cancan/matchers"

describe Ability, type: :model do
  describe "as an admin user" do
    before(:each) do
      @user ||= FactoryGirl.create(:user, role: 0)
      @ability = Ability.new(@user)
    end

    it "should be able to manage all" do
      expect(@ability).to be_able_to(:manage, :all)
    end
  end

  describe "as a usual user" do
    let!(:category){FactoryGirl.create :category}
    let!(:product){FactoryGirl.create :product}
    let!(:other_user){FactoryGirl.create :user}
    let!(:suggest){FactoryGirl.create :suggest}
    let!(:comment){FactoryGirl.create :comment}
    before(:each) do
      @user = @user ||= FactoryGirl.create(:user)
      @ability = Ability.new(@user)
    end

    context "User's permission to read test case: " do
      it {expect(@ability).to be_able_to(:read, category)}
      it {expect(@ability).to be_able_to(:read, product)}
      it {expect(@ability).to be_able_to(:read, comment)}
      it {expect(@ability).to be_able_to(:read, other_user)}
      it {expect(@ability).to be_able_to(:read, Rate.new)}
      it {expect(@ability).to be_able_to(:read, Order.new)}
      it {expect(@ability).to be_able_to(:read, OrderDetail.new)}
      it {expect(@ability).to be_able_to(:read, suggest)}
    end

    context "User's permission to create (Success case): " do
      it {expect(@ability).to be_able_to(:create, comment)}
      it {expect(@ability).to be_able_to(:create, Rate.new)}
      it {expect(@ability).to be_able_to(:create, Order.new)}
      it {expect(@ability).to be_able_to(:create, suggest)}
    end

    context "User's permission to create (Failure case): " do
      it {expect(@ability).not_to be_able_to(:create, product)}
      it {expect(@ability).not_to be_able_to(:create, category)}
      it {expect(@ability).not_to be_able_to(:create, OrderDetail.new)}
      it {expect(@ability).not_to be_able_to(:create, other_user)}
    end

    context "User's permission to update test case (Success case): " do
      it {expect(@ability).to be_able_to(:update, Comment.new(user_id: @user.id))}
      it {expect(@ability).to be_able_to(:update, Rate.new(rater_id: @user.id))}
      it {expect(@ability).to be_able_to(:update, @user)}
    end

    context "User's permission to update test case (Failure case): " do
      it {expect(@ability).not_to be_able_to(:update, Comment.new(user_id: other_user))}
      it {expect(@ability).not_to be_able_to(:update, Rate.new(rater_id: other_user))}
      it {expect(@ability).not_to be_able_to(:update, other_user)}
    end
  end
end
