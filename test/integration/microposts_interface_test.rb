# frozen_string_literal: true

require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'micropost interface' do
    sign_in_as(@user)
    get root_path
    assert_select 'ul.pagination'
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: '' } }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = 'This micropost really ties the room together'
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete post
    assert_select 'a', text: 'Delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # Visit different user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', text: 'Delete', count: 0
  end

  test 'micropost sidebar count' do
    sign_in_as(@user)
    get root_path
    assert_match "<p class=\"btn btn-warning\"><span class= \"badge badge-light\">#{@user.microposts.count}</span> microposts</p>", response.body
    # User with zero microposts
    other_user = users(:malory)
    sign_in_as(other_user)
    get root_path
    assert_match "<p class=\"btn btn-warning\"><span class= \"badge badge-light\">#{other_user.microposts.count}</span> microposts</p>", response.body
    other_user.microposts.create!(content: 'A micropost')
    get root_path
    assert_match "<p class=\"btn btn-warning\"><span class= \"badge badge-light\">#{other_user.microposts.count}</span> micropost</p>", response.body
  end
end
