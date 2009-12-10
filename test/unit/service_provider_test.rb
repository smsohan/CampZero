require 'test_helper'

class ServiceProviderTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ServiceProvider.new.valid?
  end
end
