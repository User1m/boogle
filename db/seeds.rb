PageContent.create!(
  page_id: 0,
  content: "elementary my dear watson"
  )

PageContent.create!(
  page_id: 300,
  content: "the quick brown fox jumped over the lazy dog"
  )

100.times do |i|
  if i < 30
    quote = Faker::Book.title
  elsif i < 60
    quote = Faker::StarWars.quote
  else
    quote = Faker::TwinPeaks.quote
  end
  PageContent.create!(
    page_id: i+1,
    content: quote
    )
end