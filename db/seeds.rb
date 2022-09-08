# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Destroy all records in the database before creating new data:
Like.destroy_all
Idea.destroy_all
Review.destroy_all
User.destroy_all

# To access Faker, remember to add the faker gem to Gemfile and run: bundle

PASSWORD = "123"
super_user = User.create(
  first_name: "Admin",
  last_name: "User",
  email: "admin@user.com",
  password: PASSWORD,
  is_admin: true
)

10.times do 
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}@#{last_name}.com",
    password: PASSWORD
  )
end

users = User.all

50.times do
  created_at = Faker::Date.backward(days:365 * 5)

  q = Idea.create(
    title: Faker::Hacker.say_something_smart,
    description: Faker::ChuckNorris.fact,
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )
  if q.valid?
    rand(1..5).times do
      Review.create(body: Faker::Hacker.say_something_smart, idea:q, user: users.sample)
    end
    q.likers = users.shuffle.slice(0, rand(users.count))
  end
end

ideas = Idea.all
reviews = Review.all

puts Cowsay.say("Generated #{ideas.count} questions", :frogs)
puts Cowsay.say("Generated #{reviews.count} answers", :dragon)
puts Cowsay.say("Generated #{users.count} users", :koala)
puts Cowsay.say("Generated #{Like.count} likes", :cow)

# To run this file use command: rails db:seed