class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title

  # tells all queries to order by title
  default_scope order: 'title'

  has_many :line_items
  has_many :orders, through: :line_items

  # prevent removal of products that are referenced by line items
  before_destroy :ensure_not_referenced_by_any_line_item

  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

  validates :title, :description, :image_url, presence: { message: "^Did you forget the title?" }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: { message: "^%{value} has already been taken. Sorry." }
  validates :title, length: { minimum: 10, message: "is too short" }
  validates :image_url, format: {
  	with: %r{\.(gif|jpg|png)$}i,
  	message: 'must be a URL for GIF, JPG, or PNG image.'
  }
end
