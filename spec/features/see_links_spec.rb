require 'spec_helper'

feature 'To see a list of links of the homepage' do
  scenario 'a user visits the homepage, they will see a list of links' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

    visit '/links'

    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end

  scenario 'user can add a new link' do
    visit '/links/new'
    fill_in('Bookmark title', with: 'Yahoo')
    fill_in('Link url', with: 'www.yahoo.com')
    click_button('Submit')
    visit '/links'
    within 'ul#links' do
      expect(page).to have_content('Yahoo')
    end
  end
end
