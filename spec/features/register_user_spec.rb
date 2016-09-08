require 'spec_helper'

feature 'registering users' do

  scenario 'sign up a user' do
    # User.create(username: 'Erce', email: 'erce@erce.com', password: '123456')
    # visit '/sign-up'

    expect { sign_up }.to change(User, :count).by(1)
    new_user = User.first
    expect(new_user.email).to eq('erce@erce.com')
    expect(page).to have_content 'Welcome, Erce'
    end

    scenario 'sign up with mismatched password confirmation' do
      expect { sign_up_confirm_bad }.not_to change(User, :count)
      expect(page).to have_current_path('/signup')
      expect(page).to have_content('Password and confirmation password do not match')
    end

    scenario 'user leaves email field blank' do
      expect { sign_up_no_email }.not_to change(User, :count)
      expect(page).to have_current_path('/signup')
      expect(page).to have_content('Please enter email!')
    end

    scenario 'user enters a non-valid email' do
      expect { sign_up_bad_email }.not_to change(User, :count)
      expect(page).to have_content("Doesn't look like an email address to me ...")
    end
  end
