require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "admin_user", email: "admin_user@alphablog.com", password: "admin1", admin: true)
  end
  
  test "Get new category form and create category" do
    sign_in_as(@user,"admin1")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do 
      post categories_path, params: {category:{name: "Sports"}} 
      get categories_path
    end
    assert_template 'categories/index'
    assert_match 'Sports', response.body
  end
  
  test "Invalid category submission resullts in failure" do 
    sign_in_as(@user,"admin1")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do 
      post categories_path, params: {category:{name: " "}} 
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title' 
    assert_select 'div.panel-body'
  end
  
end