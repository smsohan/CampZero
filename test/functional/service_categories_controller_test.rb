require 'test_helper'

class ServiceCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_category" do
    assert_difference('ServiceCategory.count') do
      post :create, :service_category => { }
    end

    assert_redirected_to service_category_path(assigns(:service_category))
  end

  test "should show service_category" do
    get :show, :id => service_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => service_categories(:one).to_param
    assert_response :success
  end

  test "should update service_category" do
    put :update, :id => service_categories(:one).to_param, :service_category => { }
    assert_redirected_to service_category_path(assigns(:service_category))
  end

  test "should destroy service_category" do
    assert_difference('ServiceCategory.count', -1) do
      delete :destroy, :id => service_categories(:one).to_param
    end

    assert_redirected_to service_categories_path
  end
end
