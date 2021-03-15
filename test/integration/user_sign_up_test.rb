require 'test_helper'

class UserSignUptest < ActionDispatch::IntegrationTest
  test 'get signup form and create user' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: 'example', email: 'example@gmail.com', password: 'password' } }
      follow_redirect!
    end
    assert_template 'users/show'
    assert_equal(User.first.id, session[:user_id])
    assert_match 'example', response.body
  end
end
