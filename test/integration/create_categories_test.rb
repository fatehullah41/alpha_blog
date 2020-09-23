require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "usman30", email: "usman30@example.com", password: "password3", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user, "password3")
    get new_category_path
    assert_template   'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: {category: {name: "sports"}}
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end

  test "invalid category submission results in failures" do
    sign_in_as(@user, "password3")
    get new_category_path
    assert_template   'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: " "}}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-tittle'
    assert_select 'div.panel-body'
  end


end
