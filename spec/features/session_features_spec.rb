require 'rails_helper'

describe "application layout" do

  context "when user is signed in" do
    before do
      @user = create(:user)
      login_as(@user, scope: :user)
      visit root_path
    end

    it "should provide a 'Logout' link" do
      expect(page).to have_selector(:link_or_button, 'Logout')
    end
    it "should provide a 'Profile' link" do
      expect(page).to have_selector(:link_or_button, 'Profile')
    end
    it "should display the current user when 'Profile' is clicked" do
      click_link_or_button 'Profile'
      expect(current_path).to eq(user_path(@user))
    end
  end

  context "when user is not signed in" do
    before do
      visit root_path
    end

    it "should provide a 'Login' link" do
      expect(page).to have_selector(:link_or_button, 'Login')
    end
    it "should not provide a 'Profile' link" do
      expect(page).to_not have_selector(:link_or_button, 'Profile')
    end
  end
end
