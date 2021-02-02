class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_items

    validates :title, :description, :image_url, presence: true
    validates :title, uniqueness: true
    validates :price, numericality: { greater_than_or_equal_to: 0.01 }
    validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|jpeg|png)\z}i,
      message: 'must be a URL for a GIF, JPG, JPEG, or PNG image.'
    }

    validates :title, length: {minimum: 10}

    private

    def ensure_not_referenced_by_any_line_items
      unless line_items.empty?
        errors.add(:base, 'Line items present')
        throw :abort
      end
    end
end
