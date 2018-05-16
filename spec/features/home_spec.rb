require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  let(:user) { create(:user) }

  background do
    visit root_path
  end

  scenario 'check presence of elements' do
    expect(page).to have_content(I18n.t('home.welcome_to_bookstore'))
    expect(page).to have_content(I18n.t('home.description'))
    expect(page).to have_content(I18n.t('home.get_started_btn'))
    expect(page).to have_content(I18n.t('home.best_sellers'))
    expect(page).to have_css '.shop-icon'
  end

  scenario 'check link to categories' do
    click_link I18n.t('home.get_started_btn')
    expect(page.current_path).to eq categories_path
  end

  scenario 'navigation for unauthorized' do
    ['Home', 'Shop', 'Log In', 'Sign Up'].each do |title|
      expect(page).to have_selector('ul.nav', text: title)
    end
    find('.nav .dropdown').click
    Category.all.each { |category| expect(page).to have_selector('.dropdown-menu li', text: category.title) }
  end

  scenario 'navigation with authorized user' do
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    first('[name = commit]').click

    ['Home', 'Shop', 'My Account'].each do |title|
      expect(page).to have_selector('ul.nav', text: title)
    end
    find('.nav .dropdown', text: 'My Account').click
    ['Orders', 'Settings', 'Log Out'].each do |title|
      expect(page).to have_selector('ul.nav', text: title)
    end
  end
end
