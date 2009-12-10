require 'test_helper'

class ServiceProviderCategoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => ServiceProviderCategory.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    ServiceProviderCategory.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    ServiceProviderCategory.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to service_provider_category_url(assigns(:service_provider_category))
  end
  
  def test_edit
    get :edit, :id => ServiceProviderCategory.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    ServiceProviderCategory.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ServiceProviderCategory.first
    assert_template 'edit'
  end
  
  def test_update_valid
    ServiceProviderCategory.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ServiceProviderCategory.first
    assert_redirected_to service_provider_category_url(assigns(:service_provider_category))
  end
  
  def test_destroy
    service_provider_category = ServiceProviderCategory.first
    delete :destroy, :id => service_provider_category
    assert_redirected_to service_provider_categories_url
    assert !ServiceProviderCategory.exists?(service_provider_category.id)
  end
end
