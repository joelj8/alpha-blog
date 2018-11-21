require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
      @category = Category.create(name: "Sports")
      @user = User.create(username: "admin_user", email: "admin_user@alphablog.com", password: "admin1", admin: true)
  end
  
  def sign_in_as(user,password)
    post login_path, params: {session: {email: user.email, password: password}}
  end

  test "should get categories index" do 
    get categories_path
    assert_response :success
  end

  test "shoult get new" do
    sign_in_as(@user,"admin1")
    get new_category_path
    assert_response :success
  end
  
  test "should get show" do
    get category_path(@category)
    assert_response :success
  end
  
  test "Shoulld redirect create when adminn not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: 'Sports'}}
    end
    assert_redirected_to categories_path
  end
end