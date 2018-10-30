require 'rails_helper'

RSpec.describe Idea, type: :model do
  describe "validations" do
    it "requires a title" do
      idea = FactoryBot.build(:idea, title: nil)
      idea.valid?
      expect(idea.errors.messages).to have_key(:title)
    end
    it "requires a description" do
      idea = FactoryBot.build(:idea, description: nil)
      idea.valid?
      expect(idea.errors.messages).to have_key(:description)
    end
  end
end
