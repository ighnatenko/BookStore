# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Books', type: :feature do
  let(:book) { create(:book).decorate }
  let(:user) { create(:user) }
  let(:review) { create(:review, book: book) }

  background do
    visit book_path(book, locale: I18n.locale)
  end

  scenario 'check page elements' do
    expect(page).to have_css('h1', text: book.title)
    expect(page).to have_css('p', text: book.authors_names)
    expect(page).to have_css('p', text: book.price.to_f)
    expect(page).to have_css('p', text: book.publication_year)
    expect(page).to have_css('p', text: book.description)
    expect(page).to have_css('p', text: book.dimensions)
  end

  scenario 'buy a book' do
    find('.items .btn').click
    expect(page).to have_css('.alert-success',
                             text: I18n.t('cart.successful_added'))
  end

  scenario 'make a review' do
    sign_in(user)
    visit book_path(book, locale: I18n.locale)
    first('i.fa.fa-star.rate-star').click
    fill_in 'review_description', with: review.description
    find('.review .btn').click
    expect(page).to have_css('.alert-success',
                             text: I18n.t('review.successful.create'))
  end
end
