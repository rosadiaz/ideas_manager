User.destroy_all
Idea.destroy_all

NUM_OF_USERS = 20
NUM_OF_IDEAS = 50

NUM_OF_USERS.times do |n|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email.sub("@", ".#{n}@"),
    password: "password"
  )
end

all_users = User.all
NUM_OF_IDEAS.times do
  p = Idea.create(
    title: ( Faker::MostInterestingManInTheWorld.quote ),
    description: (Faker::HitchhikersGuideToTheGalaxy.marvin_quote), 
    user_id: all_users.sample.id
  )
  # if p.valid?
  #   rand(0..5).times do
  #     p.reviews << Review.new( body: Faker::DumbAndDumber.quote, user_id: all_users.sample.id )
  #   end
  # end
  
end

puts ("🚶‍♂️ Generated #{User.count} users")
puts ("💡 Generated #{Idea.count} ideas")
# puts ("💭 Generated #{Review.count} reviews")
