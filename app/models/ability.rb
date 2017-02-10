class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when "admin"
      can :manage, :all
    when "user"
      can :read, [Category, Comment, Product, User,
        Rate, Order, OrderDetail, Suggest]
      can :create, [Comment, Suggest, Order, Rate]
      can :update, [Comment], user_id: user.id
      can :update, [Rate], rater_id: user.id
      can :update, [User], id: user.id
    else
      can :read, [Category, Comment, Product, Coupon, User,
        Rate, Order, OrderDetail, Suggest]
    end
  end
end
