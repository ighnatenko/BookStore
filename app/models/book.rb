# frozen_string_literal: true

# Book
class Book < ApplicationRecord
  FILTERS = %i[newest popular price_asc price_desc
               by_title_asc by_title_desc].freeze

  DEFAULT_FILTER = :newest
  PER_PAGE = 5
  CURRENT_PAGE = 1

  has_many :images, dependent: :destroy
  belongs_to :category
  has_and_belongs_to_many :authors
  has_many :positions
  has_many :orders, through: :positions, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, :price, :materials, presence: true
  validates :height, :width, :depth,
            numericality: { greater_than_or_equal_to: 0 }
  validates :publication_year,
            numericality: { less_than_or_equal_to: Time.current.year }

  scope :for_slider, -> { order(:created_at).last(3) }
  scope :newest, -> { order(created_at: :desc) }
  scope :price_asc, -> { order(:price) }
  scope :price_desc, -> { order(price: :desc) }
  scope :by_title_asc, -> { order(:title) }
  scope :by_title_desc, -> { order(title: :desc) }

  scope :best_sellers, (lambda do
    left_outer_joins(:positions)
    .select('books.*, COUNT(positions) as count')
    .group('books.id')
    .order('count desc')
    .limit 4
  end)

  scope :popular, (lambda do
    left_outer_joins(:positions)
    .select('books.*, COALESCE(SUM(positions.quantity), 0) as positions_sum')
    .group('books.id')
    .order('positions_sum desc')
  end)

  scope :by_filter, (lambda do |filter, page|
    public_send(filter).page(CURRENT_PAGE).per(PER_PAGE * page)
  end)
end
