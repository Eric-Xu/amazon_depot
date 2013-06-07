class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title

  validates :title, :description, :image_url, presence: { message: "^Did you forget the title?" }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: { message: "^%{value} has already been taken. Sorry." }
  validates :title, length: { minimum: 10, message: "is too short" }
  validates :image_url, format: {
  	with: %r{\.(gif|jpg|png)$}i,
  	message: 'must be a URL for GIF, JPG, or PNG image.'
  }
end
