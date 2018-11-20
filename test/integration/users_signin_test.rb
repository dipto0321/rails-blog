require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  test "signin with invalid information" do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, params: { session: { email:"", password: "" } }
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
