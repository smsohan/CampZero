require 'test_helper'

class ServiceProviderCategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ServiceProviderCategory.new.valid?
  end
end
