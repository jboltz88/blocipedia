10.times do
  user = User.new(
    email: Faker::Internet.email,
    password: "password"
  )
  user.skip_confirmation!
  user.save!
end

admin = User.new(
  email: "admin@example.com",
  password: "password",
  role: "admin"
)
admin.skip_confirmation!
admin.save!

users = User.all

30.times do
  wiki = Wiki.create!(
    title: Faker::GameOfThrones.character,
    body: Faker::Lorem.paragraph(5, true, 4),
    private: Faker::Boolean.boolean(0.1),
    user: users.sample
  )
end

10.times do
  wiki = Wiki.create!(
    title: Faker::GameOfThrones.house,
    body: Faker::Lorem.paragraphs(2, true),
    private: Faker::Boolean.boolean(0.1),
    user: users.sample
  )
end

10.times do
  wiki = Wiki.create!(
    title: Faker::GameOfThrones.city,
    body: Faker::Lorem.paragraphs(1, true),
    private: Faker::Boolean.boolean(0.1),
    user: users.sample
  )
end

wikis = Wiki.all

puts "Seed Data Created"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
