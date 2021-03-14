require 'test_helper'

class CreateCategoriesTests < ActionDispatch::IntegrationTest
  def setup
    @admin_user = User.create(username: 'example', email: 'example@gmail.com', password: 'password', admin: true)
  end
  test 'get new category form and create category' do
    sign_in_as(@admin_user, 'password')
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: 'sports' } }
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match 'sports', response.body
  end

  test 'invalid category submission result in failure' do
    sign_in_as(@admin_user, 'password')
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: ' ' } }
    end
    assert_template 'categories/new'
    assert_select 'h1.text-center'
    assert_match 'The following errors prevented the category from getting created', response.body
  end
end
