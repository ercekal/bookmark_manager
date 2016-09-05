require 'spec_helper'

feature 'List links' do
  scenario 'User can list links' do
    visit '/'
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit 'listed_links'
    expect(page.status_code).to eq 200

    within 'ul#links' do
    expect(page).to have_content('Makers Academy')
    end
  end  
end
