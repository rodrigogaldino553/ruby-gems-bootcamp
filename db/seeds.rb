# User.create!(email: Faker::Internet.email, password: '12345678', password_confirmation: '12345678')

PublicActivity.enabled = false
30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    description: Faker::TvShows::BigBangTheory.quote,
    user_id: User.first.id,
    short_description: Faker::Quote.famous_last_words,
    language: Faker::ProgrammingLanguage.name,
    level: "Beginner",
    price: Faker::Number.between(from: 1000, to: 20000)
  }])
end

PublicActivity.enabled = true
