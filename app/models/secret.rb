class Secret < ApplicationRecord


  validates :algorithm,
    presence: true, 
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 1 }

end
