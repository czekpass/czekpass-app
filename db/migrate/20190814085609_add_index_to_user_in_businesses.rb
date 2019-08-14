class AddIndexToUserInBusinesses < ActiveRecord::Migration[5.2]
  def change
    # Making sure that a user can create only one bunsiness, since this cannot be done using 'has_one' association alone
    # I'm indexing the user_id in the businesses table then checking the scope between the business and user id's
    # First I need to remove the current index form businesses table, then add it again with the correct validation. (unique = true")
    remove_index :businesses, :user_id
    add_index :businesses, :user_id, unique: true

  end
end
