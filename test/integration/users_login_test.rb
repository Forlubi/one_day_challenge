require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end

  def setup
    @user = users(:one)
  end

  test "login with invalid information" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { session: { email: "", password: "" } }
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get new_user_session_path
    post user_session_path, params: { email:    @user.email,
                                          password: '123456' }

    delete destroy_user_session_path
    assert_redirected_to root_url
  end

  test "login with valid email/invalid password" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { email:    @user.email,
                                          password: "invalid" }
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

end
