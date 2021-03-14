require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: 'Example')
  end

  test 'category name be not be present' do
    assert @category.valid?
  end

  test 'category should be unique' do
    @category.save
    second_category = Category.new(name: 'Example')
    assert_not second_category.valid?
  end

  test 'category should not be too long' do
    @category.name = 'a' * 26
    assert_not @category.valid?
  end

  test 'category should not be too short' do
    @category.name = 'aa'
    assert_not @category.valid?
  end
end
