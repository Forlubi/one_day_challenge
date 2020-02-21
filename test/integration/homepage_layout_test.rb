require 'test_helper'

class HomepageLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "homepage links" do
  	get root_path
  	assert_template 'home_page/home'
	  assert_select "a[href=?]", users_path
    assert_select "a[href=?]", challenges_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", new_challenge_path
  end
end
