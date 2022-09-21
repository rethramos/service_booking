require "test_helper"

class CartTest < ActiveSupport::TestCase
  def setup
    @cart = users(:john).build_cart
  end

  test "the truth" do
    assert @cart.valid?
  end

  test "should require user" do
    @cart.user = nil
    assert_not @cart.valid?
  end
end
