class Category < ApplicationRecord
  has_many :products
  has_many :suggests

  validates :name, presence: true, uniqueness: true, allow_blank: false

  def update_category id
    current_right = last_right
    if id.empty?
      if current_right.nil?
        self.update(lft: 1, rgt: 2, depth: 0)
      else
        self.update(lft: current_right + 1, rgt: current_right + 2, depth: 0)
      end
    else
      parent_category = Category.find_by id: id
      Category.where("rgt >= ?", parent_category.rgt)
        .update_all("rgt = rgt + 2")
      Category.where("lft >= ?", parent_category.rgt)
        .update_all("lft = lft + 2")
      self.update(lft: parent_category.rgt, rgt: parent_category.rgt + 1,
        depth: parent_category.depth + 1)
    end
  end

  private
  def last_right
    Category.maximum(:rgt)
  end
end
