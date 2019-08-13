require 'faker'


BusinessCategory.destroy_all
Product.destroy_all
Employee.destroy_all
Business.destroy_all
User.destroy_all

10.times do
  name = Faker::FunnyName.unique.two_word_name
  first_name = name.split(' ')[0]
  last_name = name.split(' ')[1]
  user = User.new(
    email: Faker::Internet.unique.email,
    first_name: first_name,
    last_name: last_name,
     password: '1234567',
    )
  user.save!

  business = Business.new(
    name: Faker::Name.unique.name,
    description: Faker::Company.bs,
    user_id: user.id,
    logo: Faker::Company.logo,
    location: Faker::Address.unique.city
    )
  business.save!

  employee = Employee.new(
    business_id: business.id,
    roles: Faker::Company.profession,
    user_id: user.id
    )
  employee.save!

  business_category = BusinessCategory.new(
    name: Faker::Company.industry
    )
  business_category.save!

  product = Product.new(
    name: Faker::Appliance.equipment ,
    description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    price_cents: Faker::Number.number(digits: 5),
    category: Faker::Job.field ,
    business_id: business.id
   )
  product.save!
  end

