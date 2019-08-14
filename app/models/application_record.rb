class ApplicationRecord < ActiveRecord::Base
  # Not sure what abstract class means 'https://api.rubyonrails.org/classes/ActiveRecord/Inheritance/ClassMethods.html'
  self.abstract_class = true
end
