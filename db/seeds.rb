30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    description: Faker::TvShows::BigBangTheory.quote
  }])
end
