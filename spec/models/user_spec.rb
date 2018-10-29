require 'rails_helper'

RSpec.describe User, type: :model do
  it "hashes the password to password_digest" do
    user = FactoryBot.create(:user)
    expect(User.last.password_digest).to_not eq("supersecret")
  end
  it "titleizes first name" do
    user = FactoryBot.create(:user, first_name: "chano")
    expect(user.first_name).to eq("Chano")
  end
  it "titleizes last name" do
    user = FactoryBot.create(:user, last_name: "perez")
    expect(user.last_name).to eq("Perez")
  end
  describe "validations" do
    it "requires an email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors.messages).to have_key(:email)
    end
    it "requires valid email" do
      user = FactoryBot.build(:user, email: "invalid_email")
      user.valid?
      expect(user.errors.messages).to have_key(:email)
    end
    it "requires unique email" do
      user1 = FactoryBot.create(:user, email: "user@email.com")
      user2 = FactoryBot.build(:user, email: "user@email.com")
      user2.valid?
      expect(user2.errors.messages).to have_key(:email)
    end
  end
end
