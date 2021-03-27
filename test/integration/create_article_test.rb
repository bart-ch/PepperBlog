require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'example', email: 'example@gmail.com', password: 'password')
  end
  test 'get new article form and create article' do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: 'example', description: 'sample description', user: @user } }
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match 'example', response.body
  end
end