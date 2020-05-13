
require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelplers

  setup do
    get '/users/sign_in'
    sign_in users(:one)
  end

end