require "rails_helper"

RSpec.describe RatingCache, type: :model do
  describe "Association" do
    it {expect belong_to(:cacheable)}
  end
end
