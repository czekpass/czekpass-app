#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# Destroy all the objects before running the seed to prevent duplication
Perk.destroy_all
Purchase.destroy_all
BusinessCategory.destroy_all
Product.destroy_all
Employee.destroy_all
Business.destroy_all
User.destroy_all



# User faker to create the name then split the name into the first_name and last_name attributes.
  name = Faker::FunnyName.unique.two_word_name
  first_name = name.split(' ')[0]
  last_name = name.split(' ')[1]

# Here we seed the database with a 'Genesis' czekpass product so that we can decrement the providing_product_id to differentiate it from the providing_product_id in the perk seed.
# To have a product before we run the perk seed, we need to create the associated entities of the product which belongs to a business which belongs to a user.
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

# to seed the file 10 times we need a ruby loop. We use the faker gem (required above)
10.times do
  name = Faker::FunnyName.unique.two_word_name
  first_name = name.split(' ')[0]
  last_name = name.split(' ')[1]
  user = User.create!(
    email: Faker::Internet.unique.email,
    first_name: first_name,
    last_name: last_name,
     password: '1234567'
    )

business = Business.create!(
    name: Faker::Name.unique.name,
    description: Faker::Company.bs,
    user_id: user.id,
    logo: Faker::Company.logo,
    location: Faker::Address.unique.city
    )

Employee.create!(
    business_id: business.id,
    roles: Faker::Company.profession,
    user_id: user.id
    )

BusinessCategory.create!(
    name: Faker::Company.industry
    )

product = Product.create!(
    name: Faker::Appliance.equipment ,
    description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    price_cents: Faker::Number.number(digits: 5),
    category: Faker::Job.field ,
    business_id: business.id
   )

Purchase.create!(
    verified: [true, false].sample,
    expiration_date: Date.today + rand(1..30),
    user_id: user.id,
    product_id: product.id
    )

Perk.create!(
    kind: ["percentage", "dollars", "non-monetary"].sample,
    amount: rand(1..50),
    description: Faker::Vehicle.manufacture,
    providing_business_id: business.id - 1,
    providing_product_id: product.id - 1,
    receiving_product_id: product.id,
    )
  end

