# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
puts "Clearing existing data..."
Watcher.destroy_all
Moderator.destroy_all
Post.destroy_all
Collection.destroy_all
User.destroy_all

# Create users
puts "Creating users..."
users = {
  admin: User.create!(name: 'ryanadmin', email: 'ryan.stolliker@gmail.com', password: 'topsecret', password_confirmation: 'topsecret'),
  alice: User.create!(name: 'alice', email: 'alice@example.com', password: 'password123', password_confirmation: 'password123'),
  bob: User.create!(name: 'bob', email: 'bob@example.com', password: 'password123', password_confirmation: 'password123'),
  charlie: User.create!(name: 'charlie', email: 'charlie@example.com', password: 'password123', password_confirmation: 'password123'),
  david: User.create!(name: 'david', email: 'david@example.com', password: 'password123', password_confirmation: 'password123')
}

# Create collections
puts "Creating collections..."
collections = {
  memes: Collection.create!(name: 'memes', description: 'A collection of memes'),
  programming: Collection.create!(name: 'programming', description: 'Programming jokes and discussions'),
  gaming: Collection.create!(name: 'gaming', description: 'Gaming community and discussions'),
  news: Collection.create!(name: 'news', description: 'Latest updates and news'),
  pets: Collection.create!(name: 'pets', description: 'Cute pet pictures and stories'),
  food: Collection.create!(name: 'food', description: 'Food pictures and recipes')
}

# Create moderators
puts "Creating moderators..."
# Admin moderates memes and programming
Moderator.create!(collection: collections[:memes], user: users[:admin])
Moderator.create!(collection: collections[:programming], user: users[:admin])

# Alice moderates gaming and pets
Moderator.create!(collection: collections[:gaming], user: users[:alice])
Moderator.create!(collection: collections[:pets], user: users[:alice])

# Bob moderates food and news
Moderator.create!(collection: collections[:food], user: users[:bob])
Moderator.create!(collection: collections[:news], user: users[:bob])

# Create watchers (with some collections being more popular than others)
puts "Creating watchers..."
# Memes - most popular
[users[:alice], users[:bob], users[:charlie], users[:david]].each do |user|
  Watcher.create!(collection: collections[:memes], user: user)
end

# Programming - second most popular
[users[:alice], users[:bob], users[:charlie]].each do |user|
  Watcher.create!(collection: collections[:programming], user: user)
end

# Gaming - medium popularity
[users[:bob], users[:charlie]].each do |user|
  Watcher.create!(collection: collections[:gaming], user: user)
end

# Others - less popular
Watcher.create!(collection: collections[:pets], user: users[:david])
Watcher.create!(collection: collections[:food], user: users[:charlie])

# Create some sample posts
puts "Creating posts..."
collections.each do |name, collection|
  # Create 2-4 posts for each collection
  rand(2..4).times do |i|
    user = users.values.sample
    Post.create!(
      title: "Sample #{name} post #{i + 1}",
      content: "This is a sample post for the #{name} collection. It contains some example content.",
      collection: collection,
      user: user
    )
  end
end

puts "Seed completed successfully!"