require 'faker'

# Destroy all the objects before running the seed to prevent duplication
puts "Destroy everything"

# Reordered these by association because seed failing.
Perk.destroy_all
Purchase.destroy_all
Product.destroy_all
Employee.destroy_all
Business.destroy_all
BusinessCategory.destroy_all
User.destroy_all

####################
# Global variables #
####################

products_array = []
users_array = []
businesses_array = []


############################################################
#   Create Czekpass to start partronized/purchased chain   #
############################################################

# Here we seed the database with a 'Genesis' czekpass product so that we can decrement the purchased_product_id to differentiate it from the purchased_product_id in the perk seed.
# To have a product before we run the perk seed, we need to create the associated entities of the product which belongs to a business which belongs to a user.
puts "Creating network bootstrap objects (Czeckpass)"

# User faker to create the name then split the name into the first_name and last_name attributes.
name = Faker::FunnyName.unique.two_word_name
first_name = name.split(' ')[0]
last_name = name.split(' ')[1]

user = User.create!(

    email: Faker::Internet.unique.email,
    first_name: first_name,
    last_name: last_name,
     password: '1234567'
    )

  BusinessCategory.create!(
    name: Faker::Company.industry
    )

  business = Business.create!(
    name: Faker::Company.unique.name,
    description: Faker::Company.bs,
    user_id: user.id,
    logo: Faker::Company.logo,
    location: Faker::Address.unique.city,
    business_category: BusinessCategory.last
    )

czekpass_product = Product.create!(
    name: "Czekpass sign up" ,
    description: "Perk from the first purchase",
    price_cents: 0,
    category: "Lifestyle" ,
    business_id: czekpass.id
  )

##############################################################
#   First loop of businesses and users to seed the database  #
##############################################################

# to seed the file 10 times we need a ruby loop. We use the faker gem (required above)
puts "10 times ruby loop for users, businesses, products and perks"

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

  users_array << user
  user.save!

  BusinessCategory.create!(
    name: Faker::Company.industry
    )

  business = Business.new(
    name: Faker::Company.unique.name,
    description: Faker::Company.bs,
    user_id: user.id,
    logo: Faker::Company.logo,
    location: Faker::Address.unique.city,
    business_category: BusinessCategory.last
    )
  businesses_array << business
  business.save!

  # Removed employees.
  # Add employess after inital loop so that they are not the same users as the owners.

  10.times do
    product = Product.new(
        name: Faker::Appliance.equipment ,
        description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
        price_cents: Faker::Number.number(digits: 5),
        category: Faker::Job.field,
        business_id: business.id
       )
    products_array << product
    product.save!
  end
end

################################
#   Create perks on products   #
################################

# Initial loop created businesses and products.
# Now we can add perks based on passed purchases

# Could be interesting to do this for all the products of a business at the same time.
# So, create a method to take a business and get it's products.
# If it is the business id the same as the business creating it, take again.
# If the business is another business,

businesses_array.each do |business|
  # Iterate on all the products of that business
  business.products.each do |product|
    patronized_business = businesses_array.sample
    perk = Perk.new(
      product_id: product.id,
      kind: ["percentage", "dollars", "non-monetary"].sample,
      amount: rand(1..50),
      description: Faker::Vehicle.manufacture,
      business_id: business.id,
      patronized_business_id: patronized_business.id == business.id ? businesses_array.sample.id : patronized_business.id,
      purchased_product_id: patronized_business.products.sample.id,
    )
    perk.save!
  end
end


## Once all products and perks are in place, we can create purchases for users in the DB.

# Do we want to do it for us or for others? Right now, most of the testing will be done on us.
# So all the scenarios should be on current_user
# Are there other methods we might want to call? Business.perks -
# we might want the business to have more perks, some that might not be available to current_user
# If so, we should do the list.


# For the create purchase user, we want every user to have at lest five purchases

users_array.each do |user|
  rand(5..10).times do
    purchased_products = products_array.select do |product|
      # return product unless that product is offered by the user's business
      product unless user.business.products.include? product
    end

    Purchase.create!(
      verified: [true, false].sample,
      expiration_date: Date.today - rand(1..30),
      user_id: user.id,
      product_id: purchased_products.sample.id
    )
  end
end

puts "Purchases created!"
# patronized_business = Business.find(business.id - 1)


########################################################################
#  Creates own user and admin (with a business) for testing purposes   #
########################################################################

puts "Create users for Czekpass developers"

czekpass_employees = ['Myles', 'Nick', 'Amir', 'Alex']
who_is_seeder = 2 # Use reference to create the seeds
businesses = Business.all

czekpass_user = User.new(
  email: "#{czekpass_employees[who_is_seeder].downcase}@czekpass.com",
  first_name: czekpass_employees[who_is_seeder],
  last_name: "Czekpass",
  password: '1234567'
)

czekpass_user.save!

rand(1..5).times do
  Purchase.create!(
    verified: [true, false].sample,
    expiration_date: Date.today + rand(1..30),
    user_id: czekpass_user.id,
    product_id: businesses.sample.products.sample.id
    )
end

czekpass_admin = User.new(
  email: "#{czekpass_employees[who_is_seeder].downcase}.admin@czekpass.com",
  first_name: czekpass_employees[who_is_seeder],
  last_name: "Czekpass Admin",
  password: '1234567',
  admin: true
)
czekpass_admin.save!

czekpass_admin_business = Business.new(
  name: Faker::Company.unique.name,
  description: Faker::Company.bs,
  user_id: czekpass_admin.id,
  logo: Faker::Company.logo,
  location: Faker::Address.unique.city,
  business_category: BusinessCategory.last
)

czekpass_admin_business.save!

czekpass_admin_business_products_array = []

rand(1..10).times do
  product = Product.new(
    name: Faker::Appliance.equipment ,
    description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    price_cents: Faker::Number.number(digits: 5),
    category: Faker::Job.field,
    business_id: czekpass_admin_business.id
  )
  product.save!
  czekpass_admin_business_products_array << product
end

czekpass_admin_business_products_array.each do |product|

  rand(1..10).times do

    patronized_business = businesses.sample

    Perk.create!(
      kind: ["percentage", "dollars", "non-monetary"].sample,
      amount: rand(1..50),
      description: Faker::Vehicle.manufacture,
      business_id: czekpass_admin_business.id,
      patronized_business_id: patronized_business.id,
      purchased_product_id: patronized_business.products.sample.id,
      product_id: product.id,
    )
  end

end
