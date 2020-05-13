require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # include Devise::Test::IntegrationHelplers
  include Devise::Test::IntegrationHelpers

  test "the truth" do
    assert true
  end
  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'devise/registrations/new'
  end
  
  test "valid signup information" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    assert_template 'devise/mailer/confirmation_instructions'
    
  end
end
