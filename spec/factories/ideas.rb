FactoryBot.define do
  factory :idea do
    association(:user, factory: :user)
    title { Faker::DumbAndDumber.quote }
    description { 
      Faker::MostInterestingManInTheWorld.quote 
      + ". Coming from " 
      + Faker::HitchhikersGuideToTheGalaxy.planet 
      + " in a " 
      + Faker::HitchhikersGuideToTheGalaxy.starship
    }
  end
end
