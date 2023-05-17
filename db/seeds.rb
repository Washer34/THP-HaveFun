# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# Création d'utilisateurs factices
#User.create!(email: 'admin@example.com', password: 'password') # Utilisateur admin pour l'exemple
3.times do
  User.create!(email: Faker::Internet.email, password: 'password', description: Faker::Lorem.paragraph, first_name: Faker::Name.first_name,)
end

# Création d'événements factices
User.all.each do |user|
  2.times do
    event = Event.new(
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 2),
      location: Faker::Address.city,
      price: rand(0..200),
      admin_id: user.id
    )
    event.duration = rand(1..4) # Durée aléatoire entre 1 et 4 heures
    event.start_date = Faker::Time.between_dates(from: Date.today, to: Date.today + 7, period: :day)
    event.save
  end
end