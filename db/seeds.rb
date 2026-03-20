user = User.find_or_create_by!(email: 'admin@example.com') do |u|
  u.password = 'password'
  u.password_confirmation = 'password'
  u.confirmed_at = Time.now
end

PublicActivity.enabled = false
30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    description: Faker::TvShows::BigBangTheory.quote,
    user_id: user.id,
    short_description: Faker::Quote.famous_last_words,
    language: Faker::ProgrammingLanguage.name,
    level: "Beginner",
    price: Faker::Number.between(from: 1000, to: 20000)
  }])
end

PublicActivity.enabled = true
