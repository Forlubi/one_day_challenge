require 'test_helper'

class HomepageLayoutTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  en
  # test "homepage links" do
  # 	get root_path
  # 	assert_template 'pages/home'
  #   assert_select "a[href=?]", root_path, count: 2
  #   assert_select "a[href=?]", challenges_path
  #   assert_select "a[href=?]", about_path

    # assert_select "a[href=?]", login_path

   #  assert_select "a[href=?]", users_path
   #  assert_select "a[href=?]", signup_path
   #  assert_select "a[href=?]", new_challenge_path
  # end
end
