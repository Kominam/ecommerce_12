require "rails_helper"

RSpec.describe ApplicationRecord, type: :model do
  it "test enum to human readable friendliness" do
    suggest = FactoryGirl.create :suggest
    expect(Suggest.human_enum_name :status, suggest.status).to eql "Processing..."
  end
end
