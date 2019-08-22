require 'yaml'

# Destroy all the objects before running the seed to prevent duplication
# Puts "Destroying all content"

Perk.destroy_all
Purchase.destroy_all
Product.destroy_all
Employee.destroy_all
Business.destroy_all
BusinessCategory.destroy_all
User.destroy_all

# puts User.all

seed = YAML.load(open('db/seed_data.yml').read)

users = {}

puts "Creating main demo users"

seed["users"]["demo_users"].each do |user|

  users[user[1]["slug"]] = User.create!(
      first_name: user[1]["first_name"],
      last_name: user[1]["last_name"],
      email: user[1]["email"],
      admin: user[1]["admin"],
      password: user[1]["password"]
      )
end

seed["users"]["business_owners"].each do |user|

  users[user[1]["slug"]] = User.create!(
      first_name: user[1]["first_name"],
      last_name: user[1]["last_name"],
      email: user[1]["email"],
      admin: user[1]["admin"],
      password: user[1]["password"]
      )
end


#####################
# Create demo users #
#####################

puts "Creating demo users"

seed["users"]["users"].each do |user|

  users[user[1]["slug"]] = User.create!(
      first_name: user[1]["first_name"],
      last_name: user[1]["last_name"],
      email: user[1]["email"],
      admin: user[1]["admin"],
      password: user[1]["password"]
      )
end


####################################
#   Create Businesses Categories   #
####################################

business_categories = {}

seed["business_categories"].each do |category|
  business_categories[category[1]["slug"]] = BusinessCategory.create!(
      name: category[1]["name"]
    )
end



#########################
#   Create Businesses   #
#########################


businesses = {}


seed["businesses"].each do |business|

    user_id = business[1]["user_id_slug"]
    business_category_id = business[1]["business_category_id_slug"]

    businesses[business[1]["slug"]] =  Business.create!(
      name: business[1]["name"],
      description: business[1]["description"],
      logo: business[1]["logo"],
      location: business[1]["location"],
      user_id: users[user_id].id,
      business_category_id: business_categories[business_category_id].id
      )
end


#########################
#    Create Products    #
#########################


products = {}

puts "Creating products"

seed["products"].each do |company|

    company[1].each do |product|


      business_id = businesses[product[1]["business_id"]].id

      products[product[1]["slug"]] =  Product.create!(
      name: product[1]["name"],
      description: product[1]["description"],
      category: product[1]["category"],
      photo: product[1]["photo"],
      business_id: business_id,
      price_cents: product[1]["price_cents"]
      )
    end

end


#########################
#     Create Perks      #
#########################

perks = {}

puts "Creating perks"


seed["perks"].each do |perk|

    patronized_business_id = businesses[perk[1]["patronized_business_id_slug"]].id
    business_id = businesses[perk[1]["business_id_slug"]].id
    purchased_product_id = products[perk[1]["purchased_product_id_slug"]].id
    product_id = products[perk[1]["product_id_slug"]].id

    perks[perk[0]] =  Perk.create!(
      kind: perk[1]["kind"],
      amount: perk[1]["amount"],
      patronized_business_id: patronized_business_id,
      purchased_product_id: purchased_product_id,
      product_id: product_id,
      description: perk[1]["description"],
      business_id: business_id,
      discounted_price: perk[1]["discounted_price"]
      )

end


#############################
#     Create Purchases      #
#############################

puts "Creating purchases"

purchases = {}

seed["purchases"].each do |purchase|


  user_id = users[purchase[1]["user_id_slug"]].id
  product_id = products[purchase[1]["product_id_slug"]].id
  perk_id = perks[purchase[1]["perk_id_slug"]].id


  purchases[purchase[1]["slug"]] = Purchase.create!(
    verified: purchase[1]["verfied"],
    user_id: user_id,
    product_id: product_id,
    created_at: Date.today - rand(7..90),
    perk_id: perk_id
    )

  # byebug
end

puts "All done!"
