# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
  	title {Faker::Commerce.product_name}
  	rating {['G', 'PG', 'PG-13', 'NC-17', 'R'].sample}
  	director {Faker::Name.name}
  	release_date {[Time.now, 10.years.ago, 1.years.ago, Time.now - 10.days].sample}
  	description {Faker::Lorem.paragraph(2)}
  end
end