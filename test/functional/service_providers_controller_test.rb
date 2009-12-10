require 'test_helper'

class ServiceProvidersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => ServiceProvider.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    ServiceProvider.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    ServiceProvider.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to service_provider_url(assigns(:service_provider))
  end
  
  def test_edit
    get :edit, :id => ServiceProvider.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    ServiceProvider.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ServiceProvider.first
    assert_template 'edit'
  end
  
  def test_update_valid
    ServiceProvider.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ServiceProvider.first
    assert_redirected_to service_provider_url(assigns(:service_provider))
  end
  
  def test_destroy
    service_provider = ServiceProvider.first
    delete :destroy, :id => service_provider
    assert_redirected_to service_providers_url
    assert !ServiceProvider.exists?(service_provider.id)
  end
end
