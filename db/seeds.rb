User.create!(email: Faker::Internet.email, password: '12345678', password_confirmation: '12345678')

30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    description: Faker::TvShows::BigBangTheory.quote,
    user_id: User.first.id
  }])
end
