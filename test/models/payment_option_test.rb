require "test_helper"

class PaymentOptionTest < ActiveSupport::TestCase
  def setup
    @payment_option = PaymentOption.new(
      name: PaymentOption::VISA
    )
  end

  test "should be valid" do
    assert @payment_option.valid?
  end

  test "should require name" do
    @payment_option.name = '    '
    assert_not @payment_option.valid?
  end

  test "name should be at most 100 characters" do
    @payment_option.name = 'a' * 101
    assert_not @payment_option.valid?
  end

  test "name should be unique" do
    copy = @payment_option.dup
    @payment_option.save
    assert_not copy.valid?
  end
end
