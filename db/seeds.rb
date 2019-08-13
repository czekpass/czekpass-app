#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Perk.destroy_all
Purchase.destroy_all
BusinessCategory.destroy_all
Product.destroy_all
Employee.destroy_all
Business.destroy_all
User.destroy_all




  name = Faker::FunnyName.unique.two_word_name
  first_name = name.split(' ')[0]
  last_name = name.split(' ')[1]

czekpass_user = User.create!(
    email: Faker::Internet.unique.email,
    first_name: first_name,
    last_name: last_name,
     password: '1234567'
  )

czekpass = Business.create!(
    name: "Czeckpass",
    description: "Loyalty for nomads",
    user_id: czekpass_user.id,
    logo: Faker::Company.logo,
    location: Faker::Address.unique.city
    )



czekpass_product = Product.create!(
    name: "Czekpass sign up" ,
    description: "Perk from the first purchase",
    price_cents: 0,
    category: "Lifestyle" ,
    business_id: czekpass.id
  )

10.times do
  name = Faker::FunnyName.unique.two_word_name
  first_name = name.split(' ')[0]
  last_name = name.split(' ')[1]

  user = User.new(
    email: Faker::Internet.unique.email,
    first_name: first_name,
    last_name: last_name,
     password: '1234567'
    )
  user.save!

  business = Business.new(
    name: Faker::Company.unique.name,
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

  purchase = Purchase.new(
    verified: [true, false].sample,
    expiration_date: Date.today + rand(1..30),
    user_id: user.id,
    product_id: product.id
    )
  purchase.save!

  perk = Perk.new(
    kind: ["percentage", "dollars", "non-monetary"].sample,
    amount: rand(1..50),
    description: Faker::Vehicle.manufacture,
    providing_business_id: business.id - 1,
    providing_product_id: product.id - 1,
    receiving_product_id: product.id,
    )
  perk.save!
  end

